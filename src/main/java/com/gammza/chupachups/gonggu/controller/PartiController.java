package com.gammza.chupachups.gonggu.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.service.PartiService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.gonggu.model.vo.Parti;
import com.gammza.chupachups.location.model.service.LocationService;
import com.gammza.chupachups.location.model.vo.Location;
import com.gammza.chupachups.member.model.service.MemberService;
import com.gammza.chupachups.member.model.vo.Member;
import com.gammza.chupachups.notify.model.service.NotifyService;
import com.gammza.chupachups.notify.model.vo.Notify;


@Controller
@RequestMapping("/gonggu")
@SessionAttributes({"loginMember"})
public class PartiController {
	@Autowired
	private PartiService partiService;
	@Autowired
	private GongguService gongguService;
	@Autowired
	private LocationService locationService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private NotifyService notifyService;
	
	//이미 참여한 공구인지 체크
	@GetMapping("/partiEnroll.pa")
	public ModelAndView partiEnroll(@RequestParam int gongguNo, Model model,RedirectAttributes redirectAttr) {
		Member loginMember=(Member)model.getAttribute("loginMember");
		
		HashMap<String, String> map=new HashMap<String,String>();
		map.put("gongguNo", String.valueOf(gongguNo));
		map.put("userId", loginMember.getUserId());
		Parti parti=partiService.selectOneParti(map); //이미 참여한 이력이 있는지 검색
		
		Gonggu gonggu=gongguService.selectOneGonggu(gongguNo);
		model.addAttribute("gonggu", gonggu);
		Location location=locationService.selectLocationByNo(gonggu.getLocationNo());
		model.addAttribute("location", location);
		
		if(parti!=null) {
			redirectAttr.addFlashAttribute("msg","이미 참여한 공구입니다.");
			ModelAndView mav=new ModelAndView();
			mav.setView(new RedirectView("ggPartiList.pa"));
			
			return mav;
		}else {
			HashMap<String,String> partiMap=new HashMap<String,String>();
			partiMap.put("gongguNo", String.valueOf(gongguNo));
			partiMap.put("sort", "recent");
			ArrayList<Parti> partiList=partiService.selectPartiListForLeader(partiMap);
			
			int count=0;
			
			for(int i=0; i<partiList.size();i++) {
				if(partiList.get(i).getStatus() == 2) {
					count++;
				}
			}
			model.addAttribute("partiCount", count);
			return new ModelAndView("/gonggu/ggPartiEnroll");
			
		}
		
	}
	
	//참여 신청하기
	@PostMapping("/partiEnroll.pa")
	public String partiEnrollFrm(Parti parti,RedirectAttributes redirectAttr,Model model) {
		int result=partiService.insertParti(parti);
		
		if(result>0) {
			int totalPrice=gongguService.selectOneGonggu(parti.getGongguNo()).getPrice()*parti.getNum();
			HashMap<String,String> updatePoint=new HashMap<String,String>();
			updatePoint.put("totalPoint", String.valueOf(totalPrice));
			updatePoint.put("userId", parti.getPartiMember());
			int pointResult=partiService.updateMemberPointMinus(updatePoint);
			if(pointResult>0) {
				Member member=memberService.selectOneMember(parti.getPartiMember());
				model.addAttribute("loginMember", member);
			}
			String str=partiList(model,"resent",0);
			
			Gonggu gonggu=gongguService.selectOneGonggu(parti.getGongguNo());
			Notify notify=new Notify();
			notify.setNotifyMember(gonggu.getGongguWriter());
			String gongguName=gonggu.getGongguName();
			if(gongguName.length()>7) {
				gongguName=gongguName.substring(0, 7)+"⋯";
			}
			notify.setNotiContent("/gonggu/checkPartis.pa?gongguNo="+gonggu.getGongguNo()+"'>"+gongguName+"공구에 새로운 참여자가 있습니다.</a>");
			notifyService.insertNotify(notify);
			
			return str;
		}else {
			redirectAttr.addFlashAttribute("msg","참여가 정상적으로 이루어지지 않았습니다.");
			return "redirect:/";
		}
	}
	//참여자 참여리스트
	@GetMapping("/ggPartiList.pa")
	public String partiList(Model model,@RequestParam(defaultValue="recent") String sort,@RequestParam(defaultValue="0") int end) {
		Member loginMember=(Member)model.getAttribute("loginMember");
		
		HashMap<String,String> listMap=new HashMap<String,String>();
		listMap.put("sort", sort);
		
		listMap.put("userId", loginMember.getUserId());
		String endStatus="";
		if(end == 1) {	endStatus="AND g.END_STATUS = 1";}
		listMap.put("endStatus", endStatus);
		
		model.addAttribute("endStatus", end);
		model.addAttribute("sort", sort);
		
		ArrayList<Gonggu> partiGongguList=new ArrayList<>();
		partiGongguList=partiService.selectAllPartiList(listMap);
		for(int i=0;i<partiGongguList.size();i++) {
			
			int gongguNo=partiGongguList.get(i).getGongguNo();
			HashMap<String, String> map=new HashMap<String,String>();
			map.put("gongguNo", String.valueOf(gongguNo));
			map.put("userId", loginMember.getUserId());
			Parti oneParti=partiService.selectOneParti(map);
			
			partiGongguList.get(i).setPrice(partiGongguList.get(i).getPrice()*oneParti.getNum());
			partiGongguList.get(i).setCreateAt(oneParti.getRegAt()); //공구 생성날짜를 참여일로 바꾸기 jsp에서 뿌려줄 때 공구 생성날짜는 필요 없는데 참여일 날짜는 필요하니까
			partiGongguList.get(i).setStatus(oneParti.getStatus());
		}
		
		//리뷰 갯수 가져와야됨
		
		model.addAttribute("partiList", partiGongguList);
		
		return "/mypage/ggList_Parti";
	}
	
	//물건 수령 했다고 버튼 눌렀을 때
	@GetMapping("/partiStatusUpdate.pa")
	public String partiStatusUpdate(@RequestParam int gongguNo, Model model, @RequestParam(defaultValue="recent") String sort, @RequestParam(defaultValue="0") int end) {
		String userId=((Member)model.getAttribute("loginMember")).getUserId();
		HashMap<String, String> map=new HashMap<String,String>();
		map.put("gongguNo", String.valueOf(gongguNo));
		map.put("userId", userId);
		Parti parti=partiService.selectOneParti(map);
		partiService.updatePartiStatusSelf(map);
		
		Gonggu gonggu=gongguService.selectOneGonggu(gongguNo);
		int totalPrice=gonggu.getPrice()*parti.getNum();
		HashMap<String,String> updatePoint=new HashMap<String,String>();
		updatePoint.put("totalPoint", String.valueOf(totalPrice));
		updatePoint.put("userId", gonggu.getGongguWriter());
		
		int result=partiService.updateMemberPointPlus(updatePoint);
		
		Notify notify=new Notify();
		String gongguName=gonggu.getGongguName();
		if(gongguName.length()>7) {
			gongguName=gongguName.substring(0, 7)+"⋯";
		}
		notify.setNotifyMember(gonggu.getGongguWriter());
		
		DecimalFormat df=new DecimalFormat("###,###");
		notify.setNotiContent("/gonggu/checkPartis.pa?gongguNo="+gonggu.getGongguNo()+"'>"+gongguName+" 공구 참여자가 물건을 수령하여 "+df.format(totalPrice)+"포인트가 들어왔습니다.</a>");
		notifyService.insertNotify(notify);
		
		partiList(model,sort,end);
		return "/mypage/ggList_Parti";
	}
	
	//공구 총대가 보는 참여자 리스트
	@GetMapping("/checkPartis.pa")
	public String checkPartis(@RequestParam int gongguNo, Model model, @RequestParam(defaultValue="recent") String sort) {
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("gongguNo", String.valueOf(gongguNo));
		map.put("sort", sort);
		ArrayList<Parti> partiList=partiService.selectPartiListForLeader(map);
		Gonggu gonggu=gongguService.selectOneGonggu(gongguNo);
		
		model.addAttribute("sort", sort);
		model.addAttribute("gonggu", gonggu);
		model.addAttribute("partiList", partiList);
		return "/gonggu/ggPartiList";
	}
	
	//총대가 참여자 선택
	@GetMapping("/partiMemSelect.pa")
	public String partiMemSelect(@RequestParam(defaultValue="") String[] id, @RequestParam int gongguNo, Model model,
			@RequestParam(defaultValue="recent")String sort) {
		Gonggu gonggu=gongguService.selectOneGonggu(gongguNo);
		for(int i=0;i<id.length;i++) {
			HashMap<String, String> map=new HashMap<String,String>();
			map.put("gongguNo", String.valueOf(gongguNo));
			map.put("userId", id[i]);
			int result=partiService.updatePartiStatusByLeader(map);
			
			Notify notify=new Notify();
			String gongguName=gonggu.getGongguName();
			if(gongguName.length()>7) {
				gongguName=gongguName.substring(0, 7)+"⋯";
			}
			notify.setNotifyMember(id[i]);
			
			notify.setNotiContent("/gonggu/ggPartiList.pa'>"+gongguName+"공구 참여가 확정되었습니다.</a>");
			notifyService.insertNotify(notify);
			
		}
		HashMap<String, String> map=new HashMap<String,String>();
		map.put("gongguNo", String.valueOf(gongguNo));
		map.put("sort", sort);
		
		ArrayList<Parti> partiList=partiService.selectPartiListForLeader(map);
		int selectCount=0;
		for(int i=0;i<partiList.size();i++) {
			if(partiList.get(i).getStatus()>0)
				selectCount+=partiList.get(i).getNum();
		}
		if(gonggu.getNum()==selectCount) {
			nonPartiMemPointMgr(gongguNo);
			gongguService.updateEndStatus(gongguNo);
		}
		
		checkPartis(gongguNo,model,sort);
		
		return "/gonggu/ggPartiList";
	}
	
	//공구가 마감되면 참여 안하는 회원들 포인트 돌려주기
	public void nonPartiMemPointMgr(int gongguNo) {
		Gonggu gonggu=gongguService.selectOneGonggu(gongguNo);
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("gongguNo", String.valueOf(gongguNo));
		map.put("sort", "recent");
		ArrayList<Parti> partiList=partiService.selectPartiListForLeader(map);
		
		for(int i=0;i<partiList.size();i++) {
			if(partiList.get(i).getStatus()==0) {
				int totalPrice=gonggu.getPrice()*partiList.get(i).getNum();
				
				HashMap<String,String> updatePoint=new HashMap<String,String>();
				updatePoint.put("totalPoint", String.valueOf(totalPrice));
				updatePoint.put("userId", partiList.get(i).getPartiMember());
				
				partiService.updateMemberPointPlus(updatePoint);
				
				Notify notify=new Notify();
				notify.setNotifyMember(partiList.get(i).getPartiMember());
				
				String gongguName=gonggu.getGongguName();
				if(gongguName.length()>7) {
					gongguName=gongguName.substring(0, 7)+"⋯";
				}
				DecimalFormat df=new DecimalFormat("###,###");
				notify.setNotiContent("/mypage/mypageMain.me'>"+gongguName+"공구가 마감되어 사용되지 않은 "+df.format(totalPrice)+"포인트가 돌아왔습니다");
				notifyService.insertNotify(notify);
			}
		}
			
	}
	
	//총대가 오픈한 공구 리스트
	@GetMapping("/ggLeadList.pa")
	public String getLeadList(Model model, @RequestParam(defaultValue="recent") String sort, @RequestParam(defaultValue="0") int end, HttpSession session) {
		HashMap<String,String> listMap=new HashMap<String,String>();
		listMap.put("sort", sort);
		
		String endStatus=" ";
		if(end == 1) {	endStatus="AND END_STATUS = 1";	}
		listMap.put("endStatus", endStatus);
		
		model.addAttribute("endStatus", end);
		model.addAttribute("sort", sort);
		
		Member member=(Member)model.getAttribute("loginMember");
		listMap.put("userId", member.getUserId());
		ArrayList<Gonggu> leadList=gongguService.selectLeadGongguList(listMap);
		model.addAttribute("leadList", leadList);
		
		return "/mypage/ggList_Leader";
	}
	
	
}
