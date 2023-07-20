 package com.gammza.chupachups.member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.member.model.service.MemberService;
import com.gammza.chupachups.member.model.vo.Member;
import com.gammza.chupachups.review.model.service.ReviewService;
import com.gammza.chupachups.review.model.vo.Review;

@Controller
@RequestMapping("/member")
@SessionAttributes({"loginMember"})

public class MemberController {
	
	@Autowired
	private ReviewService reviewService; 
	
	@Autowired
	private MemberService memberService;	
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	// 로그인 
	@GetMapping("/memberLogin.me")
	public String memberLogin() {
		return "member/memberLogin";
	}
	
	@PostMapping("/memberLogin.me")
	public String memberLogin(String userId, String userPwd, Model model, RedirectAttributes redirectAtt,HttpSession session) {
		Member member = memberService.selectOneMember(userId);
		// 인증
		if (member != null && passwordEncoder.matches(userPwd, member.getUserPwd())) {
			if(member.getStatus()==0) {
				redirectAtt.addFlashAttribute("msg", "탈퇴한 회원입니다.");
				
				return "redirect:/";
			}else {
				model.addAttribute("loginMember", member);	// requestScope => sessionScope 바꾸기
				
				Long kakaoIdkey = (Long)session.getAttribute("kakaoIdkey");
				String naverIdkey = (String)session.getAttribute("naverIdkey");
				
				if(kakaoIdkey != null) {
					HashMap<String,String> map = new HashMap<String,String>();
					map.put("userId", userId);
					map.put("kakaoIdkey", String.valueOf(kakaoIdkey));
					int result=memberService.updateKakaoIdkey(map);
					member = memberService.selectOneMember(userId);
					model.addAttribute("loginMember", member);
					redirectAtt.addFlashAttribute("msg", "카카오 간편로그인 연결이 완료되었습니다.");
					session.removeAttribute("kakaoIdkey");
					
					return "redirect:/";
				}
				if(naverIdkey != null) {
					HashMap<String,String> map = new HashMap<String,String>();
					map.put("userId", userId);
					map.put("naverIdkey", naverIdkey);
					int result=memberService.updateNaverIdkey(map);
					member = memberService.selectOneMember(userId);
					model.addAttribute("loginMember", member);
					redirectAtt.addFlashAttribute("msg", "네이버 간편로그인 연결이 완료되었습니다.");
					session.removeAttribute("naverIdkey");
					
					return "redirect:/";
				}
				redirectAtt.addFlashAttribute("msg", member.getName()+ "님 환영합니다💚");
			}
		} else {
			redirectAtt.addFlashAttribute("msg", "아이디 또는 비밀번호가 맞지 않습니다.");
		}
		return "redirect:/";
	}
	
	// 아이디 중복 확인 
	@GetMapping("/checkId.me")
	public String checkIdFunc(@RequestParam String userId, Model model) {
		Member member = memberService.checkIdFunc(userId);
		boolean available = member == null;
		
		model.addAttribute("userId", userId);
		model.addAttribute("available", available);
		
		return "jsonView";
	}
	
	// 로그아웃 
	@GetMapping("/memberLogout.me")
	public String memberLogout(SessionStatus status) {
		if (!status.isComplete())
			status.setComplete();
		return "redirect:/";
	}
	
	// 회원가입 
	@GetMapping("/memberEnroll.me")
	public void memberEnroll() {} 
	
	@PostMapping("/memberEnroll.me") 
	public String memberEnroll(Member member, RedirectAttributes redirectAtt) {
		
		// 비밀번호 암호화
		String rawPassword = member.getUserPwd();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setUserPwd(encodedPassword);
		int result = memberService.insertMember(member);
		redirectAtt.addFlashAttribute("msg", "회원가입이 완료되었습니다. 로그인이 필요합니다.");
		return "redirect:/";
	}
	

	@RequestMapping(value = "/mailCheck.me", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheck(String email, Model model) throws Exception {
		
		// 인증번호 생성
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		model.addAttribute("emailAuth", checkNum);
		
		// 이메일 전송 내용
		String setFrom = "gammzamarket@gmail.com";		// 발신 이메일
		String toMail = email;					// 받는 이메일
		String title = "[본인인증] 감자마켓 인증 이메일 입니다. ";
		String content = 
								"<h2>안녕하세요 감자마켓 입니다!</h2><br><br>"
							+	"인증 번호는 " + checkNum + "입니다.<br><br>"
							+	"해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		
		// 이메일 전송 코드
		try {
			MimeMessage msg = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(msg);
		} catch(Exception e) {
			e.printStackTrace();
		}
      return Integer.toString(checkNum);		// ajax를 뷰로 반환시 데이터 타입은 String 타입만 가능
		
		//return "redirect:/";		// String 타입으로 반환 후 반환
	}
      
   /*   
	@PostMapping("/memberUpdate.me")
	public String memberUpdate(Member member, Model model, @RequestParam String newPwd, RedirectAttributes redirectAtt) {
		if(newPwd.length() > 0) {
			String encodedPassword = passwordEncoder.encode(newPwd);
			member.setUserPwd(encodedPassword);
		}else {
			String encodedPassword = passwordEncoder.encode(member.getUserPwd());
			member.setUserPwd(encodedPassword);
		}
		int result = memberService.updateMember(member);
		
		if(result > 0) {
			redirectAtt.addFlashAttribute("msg", "회원정보 수정되셨습니다");
		} else {
			redirectAtt.addFlashAttribute("msg", "회원정보 수정 실패");

		}
		return "redirect:/member/memberInfo.me";
	}
	*/
	
	@PostMapping("/memberUpdate_Ad.me")
	public String memberUpdate_Ad(Member member, Model model, @RequestParam String newPwd, @RequestParam int nowPage, RedirectAttributes redirectAtt) {
		if(newPwd.length() > 0) {
			String encodedPassword = passwordEncoder.encode(newPwd);
			member.setUserPwd(encodedPassword);
		}
		
		int result = memberService.updateMember_Ad(member);
		
		if(result > 0) {
			redirectAtt.addFlashAttribute("msg", "회원정보가 수정되었습니다");
		} else {
			redirectAtt.addFlashAttribute("msg", "회원정보 수정 실패");
		}
		return "redirect:/member/memberInfo_Ad.me?nowPage="+nowPage+"&userId="+ member.getNewUserId();
	}
	
	@GetMapping("/changeStatus.do")
	public String changeStatus(@ModelAttribute("loginMember") Member member, RedirectAttributes redirectAtt, SessionStatus status) {
		String userId = member.getUserId();
		int result1 = memberService.selectProceedingGonggu(userId);
		
		if(result1 == 0) {
			int result2 = memberService.changeStatus(userId);
			if(result2 > 0) {
				status.setComplete();
				redirectAtt.addFlashAttribute("msg", "회원 탈퇴되셨습니다");
			} else {
				redirectAtt.addFlashAttribute("msg", "회원정보 탈퇴 실패, 다시 시도해주세요");
			}
			return "redirect:/";
		}else {
			redirectAtt.addFlashAttribute("msg", "진행중인 공구를 모두 끝내시고 탈퇴 진행해주세요");
			return "redirect:/member/memberInfo.me";
		}
	}	
	
	@GetMapping("/changeStatus_Ad.do")
	public String changeStatus_Ad(@RequestParam String userId, @RequestParam int nowPage, RedirectAttributes redirectAtt) {
		int result1 = memberService.selectProceedingGonggu(userId);
		
		if(result1 == 0) {
			int result2 = memberService.changeStatus(userId);
			if(result2 > 0) {
				redirectAtt.addFlashAttribute("msg", "회원 탈퇴 성공");
			} else {
				redirectAtt.addFlashAttribute("msg", "회원정보 탈퇴 실패, 다시 시도해주세요");
			}
			return "redirect:/member/memberList.do?nowPage="+nowPage;
		}else {
			redirectAtt.addFlashAttribute("msg", "진행중인 공구가 있습니다");
			return "redirect:/member/memberList.do?nowPage="+nowPage;
		}
	}
	
	@PostMapping("/checkPwd.do")
	public void checkPwd(@RequestParam String insertPwd, @ModelAttribute("loginMember") Member member, HttpServletResponse response, RedirectAttributes redirectAtt) throws ServletException, IOException{
		boolean result = passwordEncoder.matches(insertPwd, member.getUserPwd());
		response.getWriter().print(result);
	}
	
	/*
	@GetMapping("/memberInfo.me")
	public String memberInfo(Model model, @ModelAttribute("loginMember") Member member) { 
		model.addAttribute("member", member);
		return "/mypage/memberInfo";
	}	
	*/
	@GetMapping("/memberInfo_Ad.me")
	public String memberInfo_Ad(Model model, @RequestParam String userId, @RequestParam int nowPage) { 
		Member member = memberService.selectOneMember(userId);
		model.addAttribute("member", member);
		model.addAttribute("nowPage", nowPage);
		return "/adminpage/memberInfo_Ad";
	}
	//관리자 회원추가 페이지 가기
	@GetMapping("/insertMember_Ad.do") 
	public void insertMember_Ad() {
	}
	
	
	// 관리자 회원추가
	@PostMapping("/insertMember_Ad.do") 
	public void insertMember_Ad(Member member, RedirectAttributes redirectAtt, HttpServletResponse response) throws Exception {
		// 비밀번호 암호화
		String rawPassword = member.getUserPwd();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setUserPwd(encodedPassword);
		int result = memberService.insertMember(member);
		response.getWriter().print(result);
	}
	
	// 아이디 찾기 
	@GetMapping("/findId.me")
	public String findId() {
		return "/member/findId";
	}

	@PostMapping("/findId.me")
	@ResponseBody
	public String findIdClick(@RequestParam("phone") String phone) {
		String result = memberService.findIdClick(phone);
		return result;
	}
	
	// 비밀번호 찾기 
	@GetMapping("/findPwd.me")
	public String findPwd() {
		return "/member/findPwd";
	}
	
	@PostMapping("/authPwd.me")
	public ModelAndView authPwd(HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		
		// 사용자 입력값 
		String userId = (String) request.getParameter("userId");
		String email = (String) request.getParameter("email");
		
		Member member = memberService.selectOneMember(userId);
		
		if (member == null) {
			model.addAttribute("msg", "일치하는 회원이 없습니다.");
			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/findPwd");
			return mv;
		}
		
		if (member.getEmail().equals(email) == false) {
			model.addAttribute("msg", "일치하는 회원이 없습니다.");
			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/findPwd");
			return mv;
		}
		
		Random r = new Random();
		int num = r.nextInt(999999);
		if (member.getUserId().equals(userId)) {
			session.setAttribute("member", member);
			
			String setfrom = "gammzamarket@gmail.com"; 
			String tomail = email;
			String title = "[감자마켓] 비밀번호 변경 인증 이메일입니다.";
			String content = System.getProperty("line.separator") 
							+ "안녕하세요! 감자마켓입니다."
							+ System.getProperty("line.separator") 
							+ "회원님의 비밀번호 찾기 인증 번호는 " + num + "입니다."
							+ System.getProperty("line.separator");
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");
				messageHelper.setFrom(setfrom);
				messageHelper.setTo(tomail);
				messageHelper.setSubject(title);
				messageHelper.setText(content);
				mailSender.send(message);
			} catch (Exception e) {
				e.printStackTrace();
			}
			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/authPwd");
			mv.addObject("num", num);
			mv.addObject("userId", userId);
			mv.addObject("email", email);
			return mv;
		} else {
			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/findPwd");
			return mv;
		}
	}
	
	// 인증번호 입력 
	@PostMapping("/setPwd.me")
	public String setPwd(@RequestParam("emailAuth") String emailAuth, @RequestParam("num") String num, Model model) throws IOException {
		if (emailAuth.equals(num)) {
			return "member/updatePwd";
		} else {
			model.addAttribute("msg", "유효하지 않은 인증번호입니다.");
			return "member/findPwd";
		}
	}
	
	// 새로운 비밀번호 설정 
	@PostMapping("/updatePwd.me")
	public String updatePwd(@RequestParam("userPwdNew") String userPwdNew, HttpSession session, RedirectAttributes redirectAtt) throws IOException {
		Member tempMember = (Member) session.getAttribute("member");
		
		String rawPassword = userPwdNew;
		String encodedPassword = passwordEncoder.encode(rawPassword);
		tempMember.setUserPwd(encodedPassword);
		
		int result = memberService.updatePwd(tempMember);
		
		if (result > 0) { // 데이터베이스 변경된 행의 수 
			redirectAtt.addFlashAttribute("msg", "비밀번호 변경이 완료되었습니다.");
		} else {
			redirectAtt.addFlashAttribute("msg", "비밀번호 변경 실패");
			return "member/updatePwd";
		}
		session.removeAttribute("tempMember");
		return "redirect:/";
	}
	
	
	@GetMapping("/memberDetail.me")
	public void memberDetail() {
	}
	
	@PostMapping("/memberUpdate.me")
	public String memberUpdate(Member member, Model model, RedirectAttributes redirectAtt) {
		String rawPassword = member.getUserPwd();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setUserPwd(encodedPassword);
		
		int result = memberService.updateMember(member);
		
		if(result > 0) {
			redirectAtt.addFlashAttribute("msg", "회원정보 수정 성공");
		} else {
			redirectAtt.addFlashAttribute("msg", "회원정보 수정 실패");
		}
		
		return "redirect:/member/memberInfo.me?userId="+member.getUserId();
	}
	

	@GetMapping("/memberInfo.me")
	public String memberInfo(Model model, @ModelAttribute("loginMember") Member member) { 
		model.addAttribute("member", member);
		return "/mypage/memberInfo";
	}


	@GetMapping("/userPf.bo")
	public String userPf(Model model, HttpServletRequest request, HttpSession hs) {
		Review review = (Review)hs.getAttribute("review");


		String userpr = request.getParameter("userPr");
		String userpp = request.getParameter("userPp");
		String userpl = request.getParameter("userPl");
		model.addAttribute("userpr", userpr);
		model.addAttribute("userpp", userpp);
		model.addAttribute("userpl", userpl);
		if(userpl != null) {
			Member loginmember = memberService.selectOneMember(userpl);
			ArrayList<Review> recieved=reviewService.selectRecievedReview(loginmember.getUserId());
			ArrayList<Gonggu> leadedGonggu=reviewService.selectAllMyGonggu(loginmember.getUserId());
			
			ArrayList<Review> partiReview=new ArrayList<Review>();
			ArrayList<Review> leaderReview=new ArrayList<Review>();
			int count=-1;
			for(int i=0;i<recieved.size();i++) {
				for(int j=0;j<leadedGonggu.size();j++) {
					if(recieved.get(i).getGongguNo()==leadedGonggu.get(j).getGongguNo()) {
						leaderReview.add(recieved.get(i));
						count=-1;
						break;
					}else {	count=i;}
				}
				if(count==i) {
					partiReview.add(recieved.get(i));
				}
			}
			model.addAttribute("member", loginmember);
			model.addAttribute("review", review);
			model.addAttribute("partiReview", partiReview);
			model.addAttribute("leaderReview", leaderReview);
		} else if(userpr != null) {
			Member loginmember = memberService.selectOneMember(userpr);
			ArrayList<Review> recieved=reviewService.selectRecievedReview(loginmember.getUserId());
			ArrayList<Gonggu> leadedGonggu=reviewService.selectAllMyGonggu(loginmember.getUserId());
			
			ArrayList<Review> partiReview=new ArrayList<Review>();
			ArrayList<Review> leaderReview=new ArrayList<Review>();
			int count=-1;
			for(int i=0;i<recieved.size();i++) {
				for(int j=0;j<leadedGonggu.size();j++) {
					if(recieved.get(i).getGongguNo()==leadedGonggu.get(j).getGongguNo()) {
						leaderReview.add(recieved.get(i));
						count=-1;
						break;
					}else {	count=i;}
				}
				if(count==i) {
					partiReview.add(recieved.get(i));
				}
			}
			model.addAttribute("member", loginmember);
			model.addAttribute("review", review);
			model.addAttribute("partiReview", partiReview);
			model.addAttribute("leaderReview", leaderReview);
		} else if(userpp != null) {
			Member loginmember = memberService.selectOneMember(userpp);
			ArrayList<Review> recieved=reviewService.selectRecievedReview(loginmember.getUserId());
			ArrayList<Gonggu> leadedGonggu=reviewService.selectAllMyGonggu(loginmember.getUserId());
			
			ArrayList<Review> partiReview=new ArrayList<Review>();
			ArrayList<Review> leaderReview=new ArrayList<Review>();
			int count=-1;
			for(int i=0;i<recieved.size();i++) {
				for(int j=0;j<leadedGonggu.size();j++) {
					if(recieved.get(i).getGongguNo()==leadedGonggu.get(j).getGongguNo()) {
						leaderReview.add(recieved.get(i));
						count=-1;
						break;
					}else {	count=i;}
				}
				if(count==i) {
					partiReview.add(recieved.get(i));
				}
			}
			model.addAttribute("member", loginmember);
			model.addAttribute("review", review);
			model.addAttribute("partiReview", partiReview);
			model.addAttribute("leaderReview", leaderReview);
		}
		return "/others/userProfile";
	}

	
	@GetMapping("/getReview.re")
	public String getReview(@RequestParam int reviewNo, Model model) {
		Review review=reviewService.selectOneReview(reviewNo);
		model.addAttribute("review", review);
		return "jsonView";
	}
	
	
	@GetMapping("/memberList.do")
	public String memberList(@RequestParam(defaultValue="1") int nowPage, Model model) {
		int totalRecord = memberService.selectTotalRecord();
		int limit = 10;
		int offset = (nowPage -1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 5);
		
		List<Member> memberList = memberService.selectMemberList(rowBounds);
		model.addAttribute("memberList", memberList);
		model.addAttribute("pi", pi);
		
		return "/adminpage/memberList";
	}

}
