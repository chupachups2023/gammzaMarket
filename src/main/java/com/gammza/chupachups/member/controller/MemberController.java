package com.gammza.chupachups.member.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String memberInfo(Model model, HttpSession session) { 
		Member loginMember = (Member) session.getAttribute("loginMember");
		String userId = loginMember.getUserId();
		Member member = memberService.selectOneMember(userId);
		model.addAttribute("member", member);
		return "/mypage/memberInfo";
	}
	
	
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
	return result;
	// return "redirect:/";
	}
	
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
	
	
	
	
	

	@RequestMapping(value = "/mailCheck.me", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheck(String email, String userId, Model model) throws Exception {
		System.out.println("이메일 데이터 전송 확인");	// 확인용
		System.out.println("인증 이메일 : " + email);
		
		// 인증번호 생성
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);
		model.addAttribute("emailAuth", checkNum);
		
		// 이메일 전송 내용
		String setFrom = "kr.suhyunchoi96@gmail.com";		// 발신 이메일
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
		
		String num = Integer.toString(checkNum);		// ajax를 뷰로 반환시 데이터 타입은 String 타입만 가능
		
		return "redirect:/";		// String 타입으로 반환 후 반환
	}
	
	
}
