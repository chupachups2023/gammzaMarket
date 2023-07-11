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

