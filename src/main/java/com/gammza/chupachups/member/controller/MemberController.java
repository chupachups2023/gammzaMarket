 package com.gammza.chupachups.member.controller;

import java.util.HashMap;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	
	@GetMapping("/memberLogin.me")
	public String memberLogin() {
		return "member/memberLogin";
	}
	
	@PostMapping("/memberLogin.me")
	public String memberLogin(String userId, String userPwd, Model model, RedirectAttributes redirectAtt) {
		System.out.println("userId = " + userId);
		System.out.println("userPwd = " + userPwd);
		
		Member member = memberService.selectOneMember(userId);
		System.out.println("member = " + member);
		
		// 인증
		if (member != null && passwordEncoder.matches(userPwd, member.getUserPwd())) {
			model.addAttribute("loginMember", member);	// requestScope => sessionScope 바꾸기
		} else {
			redirectAtt.addFlashAttribute("msg", "아이디 또는 비밀번호가 맞지 않습니다.");
		}
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
	
	/*
	@PostMapping("/checkId.do")
	@ResponseBody
	public Map<String, Object> checkIdFunc(@RequestParam("userId") String userId, Map<String, Object> map) {
		Map<String, Object> result = new HashMap<>();
		
		Member member = memberService.checkIdFunc(userId);
		System.out.println("userId = " + userId);
		
		return map;
}
*/
		
	/*
	@PostMapping("/checkId.do")
	@ResponseBody
	public int checkIdFunc(@RequestParam("userId") String userId) {
		int cnt = memberService.checkIdFunc(userId);
		return cnt;
	}
	*/
		
	/*
	@ResponseBody
	@PostMapping(value="/checkId.do", produces = "application/json; charset=UTF-8")
	public Map<String, Boolean> checkIdFunc(String userId){
		Member member = memberService.selectOneMember(userId);
		boolean flag = (member == null);
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("flag", flag);
		return map;
		
		/*
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		count = memberService.checkIdFunc(userId);
		map.put("cnt", count);
		return map;
	}
	 */
	
	
	/*
	@GetMapping("/memberLogin.me")
	public void login(Model model) throws Exception {
		// Logger.info("login GET .....");
		
		SNSLogin snsLogin = new SNSLogin(naverSns);
		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
		
//		SNSLogin snsLogin = new SNSLogin(naverSns);
//		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
	}
	 */
	
	
	
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
	public String memberEnroll(Member member) {
		System.out.println("userPass = " + member);
		
		// 비밀번호 암호화
		String rawPassword = member.getUserPwd();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setUserPwd(encodedPassword);
		System.out.println("changePass = " + member);
		
		int result = memberService.insertMember(member);
		return "redirect:/";
	}
		
	
	@GetMapping("/memberDetail.me")
	public void memberDetail() {
	}
	
	@PostMapping("/memberUpdate.me")
	public String memberUpdate(Member member, Model model, RedirectAttributes redirectAtt) {
		// pw암호화해서 member.userPwd에 넣기
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
	public String memberInfo() { 
		return "/mypage/memberInfo";
	}
	
	
	// 아이디/비밀번호 찾기 
	@GetMapping("/findId.me")
	public String findId() {
		return "member/findId";
	}

	@GetMapping("/findPwd.me")
	public String findPwd() {
		return "member/findPwd";
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
	
	@GetMapping("/userPf.bo")
	public String selectUserPf(@RequestParam String gongguNo, Model model) {
		model.addAttribute("gongguNo", gongguNo);
		return "/others/userProfile";
	}
	
}


