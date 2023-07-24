package com.gammza.chupachups.purchase.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
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
	public void pointPurchase(@ModelAttribute("loginMember") Member member, Model model) {
		member = memberService.selectOneMember(member.getUserId());
		model.addAttribute("loginMember", member);
	}

	@PostMapping("/updatePoint.do")
	public void updatePoint(PointPurRec pointPR, Model model, @ModelAttribute("loginMember") Member member) {
		String userId = member.getUserId();
		pointPR.setUserId(userId);
		
		int result1 = purchaseService.updatePoint(pointPR);
		int result2 = purchaseService.insertPointPurRec(pointPR);
		
		member = memberService.selectOneMember(userId);
		model.addAttribute("loginMember", member);
		model.addAttribute(pointPR);
	}

	@GetMapping("/pointPurChk.do")
	public void pointPurChk(@RequestParam String pointOrderNum, Model model) {
		model.addAttribute(pointOrderNum);
	}
//	restKey 삭제
	private IamportClient client = new IamportClient("","");
	
	@PostMapping("/checkUid.do")
	public void selectPointOrderNum(@RequestParam String pointOrderNum, HttpServletResponse response) throws Exception {
		int result = purchaseService.selectPointOrderNum(pointOrderNum);
		response.getWriter().print(result);
	}
	
	/*결제검증*/
	@ResponseBody
	@RequestMapping(value="/verifyAmount/{imp_uid}", method = RequestMethod.POST)
	public IamportResponse<Payment> verifyAmountPOST(@PathVariable(value = "imp_uid") String imp_uid) throws IamportResponseException, IOException {
		return client.paymentByImpUid(imp_uid);
    }
	
	/* 결제내역 목록 */
	@GetMapping("/checkPayment.do")
	public void checkPayment(@ModelAttribute("loginMember") Member member, @RequestParam(defaultValue="1") int nowPage, PointPurRec point, Model model) {
		String userId = member.getUserId();
		
		int totalRecord = purchaseService.selectTotalRecord_M(userId);
		int limit = 10;
		int offset = (nowPage -1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 5);
		
		List<PointPurRec> paymentList = purchaseService.selectPaymentRecord(userId, rowBounds);
		
		for(int i=0;i<paymentList.size();i++) {
			Date date = paymentList.get(i).getPurchasedTime();
			long timeInMilliSeconds = date.getTime();
	        java.sql.Date purchasedTime = new java.sql.Date(timeInMilliSeconds);
	        paymentList.get(i).setPurchasedTime(purchasedTime);
		}
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("pi", pi);
	}
	
	@GetMapping("/checkPayment_Ad.do")
	public String checkPayment_Ad(@RequestParam(defaultValue="1") int nowPage, PointPurRec point, Model model) {
		int totalRecord = purchaseService.selectTotalRecord();
		int limit = 10;
		int offset = (nowPage -1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 5);
		
		List<PointPurRec> paymentList = purchaseService.selectPaymentRecord_Ad(rowBounds);
		
		for(int i=0;i<paymentList.size();i++) {
			Date date = paymentList.get(i).getPurchasedTime();
			long timeInMilliSeconds = date.getTime();
	        java.sql.Date purchasedTime = new java.sql.Date(timeInMilliSeconds);
	        paymentList.get(i).setPurchasedTime(purchasedTime);
		}
		
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("pi", pi);
		return "/adminpage/checkPayment_Ad";
	}
	


}
