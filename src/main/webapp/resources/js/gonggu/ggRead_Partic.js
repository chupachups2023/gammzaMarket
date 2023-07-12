const sliderWrap = document.querySelector(".ggRead-slider-wrap");
const sliderImg = document.querySelector(".ggRead-slider-img");  // 보여지는 영역
const sliderInner = document.querySelector(".ggRead-slider-inner");  // 움직이는 영역
const slider = document.querySelectorAll(".ggRead-img-slider");  // 개별적 이미지
const sliderDot = document.querySelector(".ggRead-slider-dot");  // dot

let currentIndex = 0;  // 현재 이미지
let sliderCount = slider.length;  // 이미지 개수
let sliderWidth = sliderImg.offsetWidth;  // 이미지 가로값
let dotIndex = "";

function init(){
    slider.forEach(() => {
        dotIndex += '<div class="ggRead-dot"><img src="https://cdn-icons-png.flaticon.com/512/319/319873.png"></div>'
    });
    sliderDot.innerHTML = dotIndex;
    sliderDot.firstChild.classList.add("active");
}
init();

function gotoSlider(num){
    sliderInner.style.transition = "all 400ms";
    sliderInner.style.transform = "translateX("+ -sliderWidth * num +"px)";
    currentIndex = num;

    const dotActive = document.querySelectorAll(".ggRead-slider-dot .ggRead-dot");
    dotActive.forEach(el => el.classList.remove("active"));
    dotActive[num].classList.add("active");
}

document.querySelectorAll(".ggRead-slider-dot .ggRead-dot").forEach((dot, index) => {
    dot.addEventListener("click", () => {
        gotoSlider(index);
    })
});

function setLeftTime(){
	var now_utc = Date.now();
	var endTime = document.getElementById("endtime").value;
	var eT=new Date(endTime).getTime();
	var leftMii=eT-now_utc;
	
	var leftDay=Math.floor(leftMii/1000/60/60/24);
	var leftHour=Math.floor(leftMii/1000/60/60-leftDay*24);
	var leftMin=Math.ceil(leftMii/1000/60-leftDay*24*60-leftHour*60);
	document.getElementById("left-time").innerHTML=leftDay+"일 "+leftHour+"시간 "+leftMin+"분 남았어요";
};


//setLeftTime();
$(function(){
		setLeftTime();
	setInterval(function(){
		
		setLeftTime();
	},1000*10);
});



