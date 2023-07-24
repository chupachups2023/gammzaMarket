package com.gammza.chupachups.gonggu.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

import com.gammza.chupachups.chatRoom.model.service.ChatRoomService;
import com.gammza.chupachups.common.ChangeDate;
import com.gammza.chupachups.common.SpringUtils;
import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
import com.gammza.chupachups.ggRequest.controller.RequestController;
import com.gammza.chupachups.ggRequest.model.service.RequestService;
import com.gammza.chupachups.ggRequest.model.vo.Request;
import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.service.PartiService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.gonggu.model.vo.Parti;
import com.gammza.chupachups.likeList.controller.LikeListController;
import com.gammza.chupachups.likeList.model.service.LikeListService;
import com.gammza.chupachups.likeList.model.vo.Zzim;
import com.gammza.chupachups.location.controller.LocationController;
import com.gammza.chupachups.location.model.service.LocationService;
import com.gammza.chupachups.location.model.vo.Location;
import com.gammza.chupachups.member.model.vo.Member;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/gonggu")
@SessionAttributes({"gonggu"})
public class GongguController {
	@Autowired
	private GongguService gongguService;
	@Autowired
	private ServletContext application;
	@Autowired
	private LocationService locationService;
	@Autowired
	private LocationController locationController;
	@Autowired
	private LikeListController likeListController;
	@Autowired
	private LikeListService likeListService;
	@Autowired
	private ChatRoomService chatRoomService;
	@Autowired
	private PartiService partiService;
	@Autowired
	private RequestService requestService;
	@Autowired
	private RequestController requestController;
	@Autowired
	private PartiController partiController;
	
	//요청하기에서 연동해서 글 쓸 때
	@GetMapping("/ggWrite.go")
	public void ggWrite(HttpServletRequest request,Model model) {
		Map<String, Gonggu> flashMap =(Map<String, Gonggu>) RequestContextUtils.getInputFlashMap(request);
		Gonggu gonggu=new Gonggu();
		if(flashMap !=null) {
			gonggu=flashMap.get("gonggu");
		}
		model.addAttribute("gonggu", gonggu);
		System.out.println("연동해서 글쓰기");
	}

	@GetMapping("/ggListView.go")
	public ModelAndView ggListView(Model model,RedirectAttributes redirectAttr, HttpSession session,
				@RequestParam(defaultValue="127.0016985") String longitude,@RequestParam(defaultValue="37.5642135") String latitude,
				@RequestParam(defaultValue="PULLUP_AT") String sort,@RequestParam(defaultValue="1") int end) {
		Member loginMember=(Member) session.getAttribute("loginMember");
		
		model.addAttribute("category", "");
		model.addAttribute("gongguName", "");
		
		ArrayList<Gonggu> ggListView;
		ModelAndView mav=new ModelAndView();
		HashMap<String,String> locationMap=new HashMap<String,String>();
		locationMap.put("sortby", sort);
		model.addAttribute("sortByHidden", sort);
		String endStatus="AND END_STATUS = 1";
		if(end == 0) {
			endStatus=" ";
		}
		locationMap.put("endStatus", endStatus);
		model.addAttribute("endStatus", end);
		
		if(loginMember !=null) {
			if(loginMember.getLatitude() == null) {
				redirectAttr.addFlashAttribute("msg","정확한 주변 공구를 보려면 장소 인증을 먼저 해야 합니다.");
				mav.setView(new RedirectView("/chupachups/location/location.lo"));
				return mav;
			}else {
				locationMap.put("longitude", loginMember.getLongitude());
				locationMap.put("latitude", loginMember.getLatitude());
				ggListView = gongguService.selectggListView(locationMap);
			}
		}else {
			locationMap.put("longitude", longitude);
			locationMap.put("latitude", latitude);
			ggListView = gongguService.selectggListView(locationMap);
		}
		for(int i=0;i<ggListView.size();i++) {
			Location tempLocal=locationService.selectLocationByNo(ggListView.get(i).getLocationNo());
			String locationName=locationController.SelectLocationName(tempLocal);
			ggListView.get(i).setLocationName(locationName);
			
		}
		model.addAttribute("location", locationMap);
		model.addAttribute("ggListView", ggListView);
		mav.setViewName("/gonggu/ggListView");
		
		return mav;
	}
	
	@GetMapping("/mainList.go")
	public String mainList(Model model, HttpSession session, @RequestParam(defaultValue="1") int page) {
		//소셜 로그인 하려다 취소한 사람 세션에서 지워주기
		Long kakaoIdkey = (Long)session.getAttribute("kakaoIdkey");
		String naverIdkey = (String)session.getAttribute("naverIdkey");
		if(kakaoIdkey != null) {
			session.removeAttribute("kakaoIdkey");
		}
		if(naverIdkey != null) {
			session.removeAttribute("naverIdkey");
		}
		
		ArrayList<Gonggu> mainList = gongguService.selectMainList();
		
		for(int i=0;i<mainList.size();i++) {
			Location tempLocal=locationService.selectLocationByNo(mainList.get(i).getLocationNo());
			String locationName=locationController.SelectLocationName(tempLocal);
			mainList.get(i).setLocationName(locationName);
			//홈 띄워질 때마다 공구 상태 관리
			gongguStatusMgr(mainList.get(i).getGongguNo());
		}
		
		int i = page-1;
		ArrayList<Gonggu> ggListView2 = new ArrayList<Gonggu>();
		for(int j=0; i<(8*page); i++,j++) {
			ggListView2.add(j, mainList.get(i));
		}
		model.addAttribute("mainList", ggListView2);
		model.addAttribute("page", page);
		
		return "/common/mainpage";
	}
	
	@PostMapping("/mainList.go")
	public String mainList(Model model, @RequestParam int page) {
		JSONArray jarr = new JSONArray();
		String returnVal = "jsonView";
		
		ArrayList<Gonggu> mainList = gongguService.selectMainList();
		for(int i=0;i<mainList.size();i++) {
			Location tempLocal=locationService.selectLocationByNo(mainList.get(i).getLocationNo());
			String locationName=locationController.SelectLocationName(tempLocal);
			mainList.get(i).setLocationName(locationName);
			//홈 띄워질 때마다 공구 상태 관리
			gongguStatusMgr(mainList.get(i).getGongguNo());
		}
		int i = 8*(page-1);
		
		ArrayList<Gonggu> ggListView2 = new ArrayList<Gonggu>();
		if(mainList.size()>=i+8) {
			for(int j=0; i<(8*page); i++,j++) {
				ggListView2.add(j, mainList.get(i));
			}
		}else {
			for(int j=0; i<mainList.size(); i++,j++) {
				ggListView2.add(j, mainList.get(i));
			}
		}
		jarr.addAll(ggListView2);
		model.addAttribute("result", jarr);
		
		return "jsonView";
	}
	
	//공구 상태 관리
	public void gongguStatusMgr(int gongguNo) {
		Gonggu gonggu = gongguService.selectOneGonggu(gongguNo);
		LocalDateTime today = LocalDateTime.now();
		LocalDateTime endTime = LocalDateTime.parse(ChangeDate.chageDateToJsp(gonggu.getEndTime()));
		
		//공구 날짜가 지났는데 상태가 1(진행 중)이면 
		if(today.isAfter(endTime) && gonggu.getEndStatus()==1) {
			gongguService.updateEndStatus(gongguNo);
			partiController.nonPartiMemPointMgr(gongguNo);
		}
	}
	
	 @GetMapping("/ggRead.go") 
	 public String ggRead(@RequestParam int gongguNo, Model model, HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes) throws ParseException {
		 Member loginMember=(Member)session.getAttribute("loginMember");
		 if(loginMember!=null) {
			 Zzim myZzim=likeListController.selectMyZzim(gongguNo,loginMember.getUserId());
			 if(myZzim !=null) {
				 model.addAttribute("zzim", myZzim);
			 }else {
				 model.addAttribute("zzim", null);
			 }
		 }
		 int zzimCount=likeListService.selectZzim(gongguNo).size();
		 model.addAttribute("zzimCount", zzimCount);
		 gongguService.updateGongguCount(gongguNo);
		 Gonggu gonggu = gongguService.selectOneGonggu(gongguNo);
		 
		 HashMap<String,String> map=new HashMap<String,String>();
		 map.put("gongguNo", String.valueOf(gongguNo));
		 map.put("sort", "recent");
		 ArrayList<Parti> partiList=partiService.selectPartiListForLeader(map);
		 
		 int partiNum=0;
		 int onPartiNum=0;
		 for(int i=0;i<partiList.size();i++) {
			 if(partiList.get(i).getStatus()>0) {
				 partiNum+=partiList.get(i).getNum();
			 }
			 if(partiList.get(i).getStatus()==1) {
				 onPartiNum++;
			 }
			 
		 }
		 model.addAttribute("partiNum", partiNum);
		 model.addAttribute("onPartiNum", onPartiNum);
		 model.addAttribute("gonggu", gonggu);
		 
		 //공구 진행 중인 회원 수
		 
		 
		 if(gonggu.getEndStatus()==1) {
			 return "/gonggu/ggRead"; 
		 }else if(gonggu.getStatus()==0){
			 redirectAttributes.addFlashAttribute("msg", "삭제된 글입니다.");
			 String referer = request.getHeader("Referer");
			 return "redirect:"+ referer;
		 }else {
			 return "/gonggu/ggEnd"; 
		 }
		 
	 }
	 
	
	 
	 
	 @PostMapping("/ggEnrollFrm.go")
	 public String ggEnrollFrm(Gonggu gonggu, Location map,@RequestParam MultipartFile upPhoto1, @RequestParam MultipartFile upPhoto2,
			@RequestParam MultipartFile upPhoto3, Model model,RedirectAttributes redirectAttr) {
		 Request request=requestService.selectRequest(gonggu.getGongguNo());
		 int locationNo=locationController.selectLocation(map).getLocationNo();
		 gonggu.setLocationNo(locationNo);
		if (gonggu.getOpenTime().equals("sysdate")) {
			gonggu.setEndTime(ChangeDate.chageDate(gonggu.getEndTime()));
			gonggu.setSendTime(ChangeDate.chageDate(gonggu.getSendTime()));
		} else {
			gonggu.setOpenTime(ChangeDate.chageDate(gonggu.getOpenTime()));
			gonggu.setEndTime(ChangeDate.chageDate(gonggu.getEndTime()));
			gonggu.setSendTime(ChangeDate.chageDate(gonggu.getSendTime()));
		}

		String saveDirectory = application.getRealPath("/resources/upload");

		ArrayList<String> photo = new ArrayList<String>();

		if (upPhoto1.getSize() > 0) {
			String changeFilename = SpringUtils.changeMultipartFile(upPhoto1);

			photo.add(changeFilename);

			File destFile = new File(saveDirectory, changeFilename);

			try {
				upPhoto1.transferTo(destFile); // 실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			if(request !=null) {
				gonggu.setPhoto1(request.getPhoto1());
			}
		}
		if(upPhoto2.getSize()>0) {
			String changeFilename=SpringUtils.changeMultipartFile(upPhoto2);
			photo.add(changeFilename);
			
			File destFile=new File(saveDirectory, changeFilename);

			try {
				upPhoto2.transferTo(destFile); // 실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			if(request != null) {
				gonggu.setPhoto2(request.getPhoto2());
			}
		}
		if(upPhoto3.getSize()>0) {
			String changeFilename=SpringUtils.changeMultipartFile(upPhoto3);
			
			photo.add(changeFilename);
			
			File destFile=new File(saveDirectory, changeFilename);
			try {
				upPhoto3.transferTo(destFile); // 실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			if(request !=null) {
				gonggu.setPhoto3(request.getPhoto3());
			}
		}
		if (!photo.isEmpty()) {

			photo.remove(null);

			if (photo.size() == 1) {
				gonggu.setPhoto1(photo.get(0));
			} else if (photo.size() == 2) {
				gonggu.setPhoto1(photo.get(0));
				gonggu.setPhoto2(photo.get(1));
			} else {
				gonggu.setPhoto1(photo.get(0));
				gonggu.setPhoto2(photo.get(1));
				gonggu.setPhoto3(photo.get(2));
			}
		}
		int result = gongguService.insertGonggu(gonggu);
		if(result>0) {
			int gongguNo=gongguService.selectLastNum();
			Gonggu newGonggu=gongguService.selectOneGonggu(gongguNo);
			model.addAttribute("gonggu", newGonggu);
			
//			if(memId equals(hostId)) {
//				System.out.println("자기자신한테 메시지 안돼");
//				return 원래사이트
//			} else if(이미 있는 채팅방이면) {
//				보내주기만 함 생성x
//				return
//			} else(관련 채팅방 없으면){
//				return
//			}			
			chatRoomService.insertChatRoom(newGonggu);
			if(request != null) {
				requestController.updateRequestReqStatus(request.getRequestNo());
			}
			
			return "/gonggu/ggRead";
		}else {
			redirectAttr.addFlashAttribute("msg","글 작성에 실패했습니다ㅠ");
			return "/gonggu/ggWrite";
		}
	}
	 @GetMapping("/update.go")
	 public String gongguUpdate(@RequestParam int gongguNo, Model model) {
		 Gonggu gonggu=gongguService.selectOneGonggu(gongguNo);
		 model.addAttribute("gonggu", gonggu);
		 Location location=locationService.selectLocationByNo(gonggu.getLocationNo());
		 model.addAttribute("location", location);
		 
		 return "/gonggu/ggUpdate";
	 }
	
	 @PostMapping("/ggUpdate.go")
	 public String ggUpdate(Gonggu newGonggu, Location map, @RequestParam MultipartFile upPhoto1, @RequestParam MultipartFile upPhoto2,
			@RequestParam MultipartFile upPhoto3, Model model, RedirectAttributes redirectAttr) {
		 Gonggu Ogonggu=gongguService.selectOneGonggu(newGonggu.getGongguNo());
		 
		 int locationNo=locationService.selectLocation(map).getLocationNo();
		 newGonggu.setLocationNo(locationNo);
		 //공구 바로 시작하기 처리
		if (newGonggu.getOpenTime().equals("sysdate")) {
			newGonggu.setEndTime(ChangeDate.chageDate(newGonggu.getEndTime()));
			newGonggu.setSendTime(ChangeDate.chageDate(newGonggu.getSendTime()));
		} else {
			newGonggu.setOpenTime(ChangeDate.chageDate(newGonggu.getOpenTime()));
			newGonggu.setEndTime(ChangeDate.chageDate(newGonggu.getEndTime()));
			newGonggu.setSendTime(ChangeDate.chageDate(newGonggu.getSendTime()));
		}
		
		String saveDirectory = application.getRealPath("/resources/upload");

		ArrayList<String> photo = new ArrayList<String>();
		
		if (upPhoto1.getSize() > 0) {
			if(Ogonggu.getPhoto1() != null) {
				File file=new File(saveDirectory, Ogonggu.getPhoto1());
				file.delete();
			}
			
			String changeFilename = SpringUtils.changeMultipartFile(upPhoto1);
			photo.add(changeFilename);
			File destFile = new File(saveDirectory, changeFilename);

			try {
				upPhoto1.transferTo(destFile); // 실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			if(Ogonggu.getPhoto1() != null) {
				photo.add(Ogonggu.getPhoto1());
			}
		}
		if(upPhoto2.getSize()>0) {
			String changeFilename=SpringUtils.changeMultipartFile(upPhoto2);
			photo.add(changeFilename);
			
			File destFile=new File(saveDirectory, changeFilename);
			if(Ogonggu.getPhoto2() != null) {
				File file=new File(saveDirectory, Ogonggu.getPhoto2());
				file.delete();
			}

			try {
				upPhoto2.transferTo(destFile); // 실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			if(Ogonggu.getPhoto2() != null) {
				photo.add(Ogonggu.getPhoto2());
			}
		}
		if(upPhoto3.getSize()>0) {
			String changeFilename=SpringUtils.changeMultipartFile(upPhoto3);
			photo.add(changeFilename);
			
			File destFile=new File(saveDirectory, changeFilename);
			if(Ogonggu.getPhoto3() != null) {
				File file=new File(saveDirectory, Ogonggu.getPhoto3());
				file.delete();
			}
			
			try {
				upPhoto3.transferTo(destFile); // 실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			if(Ogonggu.getPhoto3() != null) {
				photo.add(Ogonggu.getPhoto3());
			}
		}
		//사진 정렬
		if (!photo.isEmpty()) {

			photo.remove(null);
			
			if (photo.size() == 1) {
				newGonggu.setPhoto1(photo.get(0));
			} else if (photo.size() == 2) {
				newGonggu.setPhoto1(photo.get(0));
				newGonggu.setPhoto2(photo.get(1));
			} else {
				newGonggu.setPhoto1(photo.get(0));
				newGonggu.setPhoto2(photo.get(1));
				newGonggu.setPhoto3(photo.get(2));
			}
		}
		int result = gongguService.updateGonggu(newGonggu);
		if(result>0) {
			Gonggu updateGonggu=gongguService.selectOneGonggu(newGonggu.getGongguNo());
			model.addAttribute("gonggu", updateGonggu);
			return "/gonggu/ggRead";
		}else {
			redirectAttr.addFlashAttribute("msg","글 수정에 실패했습니다ㅠ");
			return "/gonggu/ggRead";
		}
	}
	 
	 //공구 총대가 공구 마감
	 @GetMapping("/gongguEnd.go")
	 public String gongguEnd(@RequestParam int gongguNo, Model model) {
		 gongguService.updateEndStatus(gongguNo);
		 Gonggu gonggu = gongguService.selectOneGonggu(gongguNo);
		 model.addAttribute("gonggu", gonggu);
		 
		 return "/gonggu/ggEnd";
	 }
	
	 @GetMapping("/ggSearch.go")
	 public String searchGonggu(@RequestParam("gongguName") String gongguName, Model model,HttpSession session,
			 @RequestParam(defaultValue="127.0016985") String longitude,@RequestParam(defaultValue="37.5642135") String latitude,
			 @RequestParam(defaultValue="PULLUP_AT") String sort,@RequestParam(defaultValue="1") int end, RedirectAttributes redirectAttr) {
		 model.addAttribute("category", "");
	 	Member mem=(Member)session.getAttribute("loginMember");
	 	HashMap<String,String> map=new HashMap<String,String>();
	 	if(mem !=null) {
	 		if(mem.getLatitude() == null) {
	 			redirectAttr.addFlashAttribute("msg","정확한 주변 공구를 보려면 장소 인증을 먼저 해야 합니다.");
	 			return "redirect:/location/location.lo";
	 		}else {
	 			map.put("longitude", mem.getLongitude());
	 			map.put("latitude", mem.getLatitude());
	 		}
	 	}else {
	 		map.put("longitude", longitude);
	 		map.put("latitude", latitude);
	 	}
	 	
		 StringTokenizer st=new StringTokenizer(gongguName);
		 String searchSql="INTERSECT ";
		 searchSql+=" SELECT * "
			 		+ " FROM gonggu "
			 		+ " where gonggu_name LIKE '%"+st.nextToken()+"%' "; 
		 while(st.hasMoreTokens()) {
			 searchSql+=" UNION "
			 		+ " SELECT * "
			 		+ " FROM gonggu "
			 		+ " where gonggu_name LIKE '%"+st.nextToken()+"%' "; 
		 }
		 if(sort.equals("PULLUP_AT")) {
			 searchSql+=" order by 22 desc";
		 }else {
			 searchSql+=" order by 24";
		 }
         
         model.addAttribute("sortByHidden", sort);
         String endStatus="AND END_STATUS = 1";
         if(end == 0) {
        	 endStatus=" ";
         }
         map.put("endStatus", endStatus);
         model.addAttribute("endStatus", end);
		 
		 map.put("search", searchSql);
		 
		 ArrayList<Gonggu> ggListView = gongguService.searchGonggu(map);
		 for(int i=0;i<ggListView.size();i++) {
				Location tempLocal=locationService.selectLocationByNo(ggListView.get(i).getLocationNo());
				String locationName=locationController.SelectLocationName(tempLocal);
				ggListView.get(i).setLocationName(locationName);
		 }
		 
		 model.addAttribute("ggListView", ggListView);
		 int totalRecord=gongguService.selectGongguTotalRecord();
		 
		 model.addAttribute("keyword", gongguName);
		 model.addAttribute("location", map);
		
		 PageInfo pi=Pagination.getPageInfo(totalRecord, 1, 1, 8);
         model.addAttribute("pi", pi);
         
         
         
		 return "/gonggu/ggListView";
	 }
	 
	 @GetMapping("/categoryList.go")
	public String categoryList(@RequestParam("category") int category, Model model, HttpSession session,RedirectAttributes redirectAttr,
			@RequestParam(defaultValue="127.0016985") String longitude,@RequestParam(defaultValue="37.5642135") String latitude,
			@RequestParam(defaultValue="PULLUP_AT") String sort,@RequestParam(defaultValue="1") int end) {
		 model.addAttribute("gongguName", "");
	 	Member mem=(Member)session.getAttribute("loginMember");
	 	HashMap<String,String> map=new HashMap<String,String>();
	 	if(mem==null) {
	 		map.put("longitude", longitude);
	 		map.put("latitude", latitude);
	 	}else {
	 		if(mem.getLatitude() == null) {
	 			redirectAttr.addFlashAttribute("msg","정확한 주변 공구를 보려면 장소 인증을 먼저 해야 합니다.");
	 			return "redirect:/location/location.lo";
	 		}else {
	 			map.put("longitude", mem.getLongitude());
	 			map.put("latitude", mem.getLatitude());
	 		}
	 	}
	 	map.put("category", String.valueOf(category));
	 	
	 	map.put("sort", sort);
        model.addAttribute("sortByHidden", sort);
        
        String endStatus="AND END_STATUS = 1";
        if(end == 0) {
       	 endStatus=" ";
        }
        map.put("endStatus", endStatus);
        model.addAttribute("endStatus", end);
		 
		 
		 ArrayList<Gonggu> ggListView = gongguService.searchGonggu(map);
		 for(int i=0;i<ggListView.size();i++) {
				Location tempLocal=locationService.selectLocationByNo(ggListView.get(i).getLocationNo());
				String locationName=locationController.SelectLocationName(tempLocal);
				ggListView.get(i).setLocationName(locationName);
		 }
		ArrayList<Gonggu> categoryList = gongguService.selectOneCategory(map);
		
		model.addAttribute("ggListView", categoryList);
		model.addAttribute("location", map);
		
		return "/gonggu/ggListView";
	}
	 
	 @GetMapping("/deleteGonggu.go")
	 public String deleteGonggu(@RequestParam int gongguNo, RedirectAttributes redirectAttr) {
		 
		 gongguService.updateGongguStatus(gongguNo);
		 
		 redirectAttr.addFlashAttribute("msg","삭제가 완료되었습니다.");
		 
		 return "redirect:/"; 
	 }
	 @GetMapping("/pullUpGonggu.go")
	 public String pullUpGonggu(@RequestParam int gongguNo, RedirectAttributes redirectAttr) {
		 
		 gongguService.updatepullUpAt(gongguNo);
		 
		 redirectAttr.addFlashAttribute("msg","공구 끌올이 완료되었습니다.");
		 
		 return "redirect:/gonggu/ggRead.go?gongguNo="+gongguNo; 
	 }
	 
}
