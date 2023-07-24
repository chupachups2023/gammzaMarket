package com.gammza.chupachups.chatMsg.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gammza.chupachups.chatMsg.model.service.ChatMsgService;
import com.gammza.chupachups.chatMsg.model.vo.ChatMsg;
import com.gammza.chupachups.chatRoom.model.service.ChatRoomService;
import com.gammza.chupachups.chatRoom.model.vo.ChatRoom;
import com.gammza.chupachups.member.model.service.MemberService;
import com.gammza.chupachups.member.model.vo.Member;

@Controller
//@SessionAttributes({"MsgList"})
public class ChatMsgController {

	@Autowired
	private ChatMsgService chatMsgService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ChatRoomService chatRoomService;	

	@GetMapping("/chatRoom/msgList.do")
	public String selectChatMsg(HttpServletRequest request, @RequestParam(required = false) String roomNo, ChatMsg chatMsg, Model model) {
		
		String userId = (String) request.getAttribute("userId");
		List<ChatMsg> MsgList = chatMsgService.selectChatMsg(roomNo);
		for(int i=0;i<MsgList.size();i++) {
			Member member=memberService.selectOneMember(MsgList.get(i).getChatWriter());
			if(member.getStatus()==0) {
				MsgList.get(i).setChatWriter("탈퇴한 회원입니다.");
			}
		}
		/* System.out.println("msgList : " + roomNo); */
		model.addAttribute("MsgList", MsgList);
		model.addAttribute("userId", userId);
		
		return "jsonView";
	}
	
	@PostMapping("/mypage/insertMsg.do")
	public String insertMsg(HttpServletRequest request, @RequestParam(required = false) ChatMsg chatMsg, @RequestParam(required = false) int roomNo, Model model) {
	    String chatContent = request.getParameter("chatContent");
	    String chatWriter = request.getParameter("chatWriter");
	    
	    ChatMsg chatMsg1 = new ChatMsg();
	    
	    chatMsg1.setChatContent(chatContent);
	    chatMsg1.setChatWriter(chatWriter);
	    chatMsg1.setRoomNo(roomNo);
	    chatMsgService.insertMsg(chatMsg1);
	    
	    int updateSendDate = chatRoomService.updateSendDate(roomNo);
	    
	    model.addAttribute("chatWriter", chatWriter);
	    model.addAttribute("chatContent", chatContent);
	    model.addAttribute("chatMsg", chatMsg);
	    model.addAttribute("roomNo", roomNo);
	    model.addAttribute("updateSendDate", updateSendDate);
	    
	    return "redirect:/";
	}
	

}
