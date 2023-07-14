 package com.gammza.chupachups.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import javax.mail.MessagingException;
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

@Controller
@RequestMapping("/member")
@SessionAttributes({"loginMember"})

public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	@GetMapping("/memberLogin.me")
	public String memberLogin() {
		return "member/memberLogin";
	}
	
	@PostMapping("/memberLogin.me")
	public String memberLogin(String userId, String userPwd, Model model, RedirectAttributes redirectAtt,HttpSession session) {
		System.out.println("userId = " + userId);
		System.out.println("userPwd = " + userPwd);
		
		Member member = memberService.selectOneMember(userId);
		System.out.println("member = " + member);
		
		// 인증
		if (member != null && passwordEncoder.matches(userPwd, member.getUserPwd())) {
			model.addAttribute("loginMember", member);	// requestScope => sessionScope 바꾸기
			
			Long kakaoIdkey = (Long)session.getAttribute("kakaoIdkey");
			String naverIdkey = (String)model.getAttribute("naverIdkey");
			
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
			
		} else {
			redirectAtt.addFlashAttribute("msg", "아이디 또는 비밀번호가 맞지 않습니다.");
		}
		
//		String kakaoIdkey = (String) model.getAttribute("kakaoIdkey");
//		String naverIdkey = (String) model.getAttribute("naverIdkey");
//		
//		System.out.println("naverIdkey: " + naverIdkey);
//		System.out.println(member);
//		
//		if (naverIdkey == null) { // 일반 로그인한 상태 
//			memberService.insertNaverIdkey(member.getNaverIdkey());
//			return "redirect:/";
//			
//			
//		} else {
//			return "redirect:/";
//		}
		
		
		
		/*
		 * Member loginMember=memberService.selectMemberByKakao();
		 * 
		 * if (loginMember == null) { // 카카오 연동을 최초로 하는 신규/기존 회원 (KAKAO_IDKEY == NULL)
		 * model.addAttribute("kakaoIdkey", kakaoProfile.getId()); //
		 * redirectAtt.addFlashAttribute("msg", "카카오 간편로그인 최초 1회 연결이 필요합니다."); return
		 * "/member/socialLogin";
		 */
		return "redirect:/";
	}
	
	
	@GetMapping("/checkId.me")
	public String checkIdFunc(@RequestParam String userId, Model model) {
		Member member = memberService.checkIdFunc(userId);
		boolean available = member == null;
		
		model.addAttribute("userId", userId);
		model.addAttribute("available", available);
		
		return "jsonView";
	}
		
	
	// @SessionAttributes + model 통해 로그인정보를 관리하는 경우
	/*
	 * SessionStatus객체를 통해 사용완료 처리해야 한다
	 * 	- session객체를 폐기하지 않고 재사용
	 */	
	@GetMapping("/memberLogout.me")
	public String memberLogout(SessionStatus status) {
		if (!status.isComplete())
			status.setComplete();
		return "redirect:/";
	}
	
	
	@GetMapping("/memberEnroll.me")
	public void memberEnroll() {} 
	
	@PostMapping("/memberEnroll.me") 
	public String memberEnroll(Member member, RedirectAttributes redirectAtt) {
		System.out.println("userPass = " + member);
		
		// 비밀번호 암호화
		String rawPassword = member.getUserPwd();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setUserPwd(encodedPassword);
		System.out.println("changePass = " + member);
		int result = memberService.insertMember(member);
		
		redirectAtt.addFlashAttribute("msg", "회원가입이 완료되었습니다. 로그인이 필요합니다.");
		
		return "redirect:/";
	}
		
	
	@GetMapping("/memberDetail.me")
	public void memberDetail() {
	}
	
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
	
	@GetMapping("/memberInfo.me")
	public String memberInfo(Model model, @ModelAttribute("loginMember") Member member) { 
		model.addAttribute("member", member);
		return "/mypage/memberInfo";
	}
	
	/* 
		수정중!! 
	
	// 아이디/비밀번호 찾기 
	@GetMapping("/findId.me")
	public String findId() {
		return "/member/findId";
	}

	@GetMapping("/findPwd.me")
	public String findPwd() {
		return "/member/findPwd";
	}
	
	@PostMapping("/findId.me")
	@ResponseBody
	public String findIdClick(@RequestParam("phone") String phone) {
		String result = memberService.findIdClick(phone);
		System.out.println(result);
	return result;
	// return "redirect:/";
	}
	
	
	@PostMapping("/authPwd.me")
	public ModelAndView authPwd(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String userId = (String) request.getParameter("userId");
		String email = (String) request.getParameter("email");
		
		System.out.println("테스트1: " + userId);
		System.out.println("테스트2: " + email);
		
		
		Member member = memberService.selectOneMemberByEmail(email);
		
		if (member != null) {
			Random r = new Random();
			int num = r.nextInt(999999); // 랜덤난수설정 
			
			if (member.getUserId().equals(userId)) {
				session.setAttribute("email", member.getEmail());
				
				String setfrom = "javalalax@gmail.com"; // 감자마켓 
				String tomail = email; // 받는사람 
				String title = "[감자마켓] 비밀번호 변경 인증 이메일입니다.";
				String content = System.getProperty("line.separator") 
									+ "안녕하세요 감자마켓입니다!" 
									+  System.getProperty("line.separator")
									+ "회원님의 비밀번호 찾기 인증 번호는 "
									+ num
									+ "입니다."
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
					System.out.println(e.getMessage());
					e.printStackTrace();
				}
				
				ModelAndView mv = new ModelAndView();
				mv.setViewName("member/authPwd");
				mv.addObject("num", num);
				return mv;
			} else {
				ModelAndView mv = new ModelAndView();
				mv.setViewName("member/findPwd");
				return mv;
			}
		} else {
			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/findPwd");
			return mv;
		}
	}
	
	@PostMapping("/setPwd.me")
	public String setPwd(@RequestParam("emailAuth") String emailAuth, @RequestParam("num") String num, RedirectAttributes redirectAtt) throws IOException {
		if (emailAuth.equals(num)) {
			return "member/updatePwd";
		} else {
			redirectAtt.addFlashAttribute("msg", "유효하지 않은 인증번호입니다.");
			return "member/findPwd";
		}
	}
	
	@PostMapping("/updatePwd.me")
	public String updatePwd(Member member, HttpSession session, RedirectAttributes redirectAtt, Model model) throws IOException {
		
		String rawPassword = member.getUserPwd();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setUserPwd(encodedPassword);
		
		int result = memberService.updatePwd(member);
		
		System.out.println(member);
		
		if (result > 0) {
			System.out.println("result: " + result);
			// redirectAtt.addFlashAttribute("msg", "비밀번호 변경이 완료되었습니다.");
		} else {
			System.out.println("result: " + result);
			// redirectAtt.addFlashAttribute("msg", "비밀번호 변경 실패");
			return "member/updatePwd";
		}
		return "redirect:/";
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	@PostMapping("/findPwd.me")
	@ResponseBody
	public String findPwdClick(@RequestParam("userId") String userId, @RequestParam("phone") String phone) {
		System.out.println(userId);
		System.out.println(phone);
		String result = memberService.findPwdClick(userId, phone);
	// return result;
	return "/member/updatePwd";
	// return "redirect:/";
	}
	*/
	
	
	
	
	

	@RequestMapping(value = "/mailCheck.me", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheck(String email, Model model) throws Exception {
		System.out.println("이메일 데이터 전송 확인");	// 확인용
		System.out.println("인증 이메일 : " + email);
		
		// 인증번호 생성
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);
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
	
	@GetMapping("/memberList.do")
	public String memberList(@RequestParam(defaultValue="1") int nowPage, Model model) {
		int totalRecord = memberService.selectTotalRecord();
		int limit = 10;
		int offset = (nowPage -1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 5);
		
		List<Member> memberList = memberService.selectMemberList(rowBounds);
		System.out.println(memberList);
		model.addAttribute("memberList", memberList);
		model.addAttribute("pi", pi);
		
		return "/adminpage/memberList";
	}
}
