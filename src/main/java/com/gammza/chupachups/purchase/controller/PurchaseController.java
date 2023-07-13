package com.gammza.chupachups.purchase.controller;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.gammza.chupachups.member.model.service.MemberService;
import com.gammza.chupachups.member.model.vo.Member;
import com.gammza.chupachups.purchase.model.service.PurchaseService;
import com.gammza.chupachups.purchase.model.vo.PointPurRec;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
@RequestMapping("/member")
@SessionAttributes({"loginMember"})
public class PurchaseController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private PurchaseService purchaseService;

	@GetMapping("/pointPurchase.do")
	public void pointPurchase(HttpSession session, Model model) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		String userId = loginMember.getUserId();

		Member member = memberService.selectOneMember(userId);
		model.addAttribute("loginMember", member);
	}

	@PostMapping("/updatePoint.do")
	public void updatePoint(PointPurRec pointPR, Model model, HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		String userId = loginMember.getUserId();
		pointPR.setUserId(userId);
		
		int result1 = purchaseService.updatePoint(pointPR);
		int result2 = purchaseService.insertPointPurRec(pointPR);
		
		Member member = memberService.selectOneMember(userId);
		model.addAttribute("loginMember", member);
		model.addAttribute(pointPR);
	}

	@GetMapping("/pointPurChk.do")
	public void pointPurChk(@RequestParam String pointOrderNum, Model model) {
		model.addAttribute(pointOrderNum);
	}
//	비공개 깃헙이라 넣었지만 restKey는 공개되면 문제가 생길 수 있으니 포폴 사용시 삭제해주세요.
	private IamportClient client = new IamportClient("0801753876651112","hdMMqurzCCIPb4MfLwsghA1aKzvKJoSmXrpR4jd68bDiZCvciaqVu1lR7HHjrXYzWNuyDHzSWotRohBi");
	
	@ResponseBody
	@RequestMapping(value="/verifyAmount/{imp_uid}", method = RequestMethod.POST)
	public IamportResponse<Payment> verifyAmountPOST(@PathVariable(value = "imp_uid") String imp_uid) throws IamportResponseException, IOException {
		return client.paymentByImpUid(imp_uid);
    }

}
