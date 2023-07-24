function validation_Ad() {
    var uid = document.getElementById("userId");
    var pw = document.getElementById("userPwd");
    var pwc = document.getElementById("userPwdChk");
    var uname = document.getElementById("name");
    var phone = document.getElementById("phone");
    var email = document.getElementById("email");
    var birthday = document.getElementById("birthday");
    
    // 정규표현식
    // 아이디 
    var idCfm = /^[a-z0-9]{4,12}$/;
    
    // 비밀번호 
    var pwdCfm = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*.])[a-zA-Z0-9!@#$%^&*.]{8,20}$/;
    
    // 이름 
    var nameCfm = /^[가-힣a-zA-Z0-9]{2,15}$/;
    
    // 휴대폰번호
    var phoneCfm = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
    
    // 이메일 
    var emailCfm = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    
    // 인증번호 
    var authCfm = /^[0-9]{1,6}$/;
    
    // 생년월일
    var birthdayCfm = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;

    
    // 아이디 확인
    if (uid.value == "") {
        alert("아이디를 입력하세요");
        uid.focus();
        return false;
    }
    
    // 아이디 대소문자 확인 
    if (!idCfm.test(uid.value)) {
        alert("아이디는 4~12자의 영문 소문자와 숫자만 사용 가능합니다");
        uid.focus();
        return false;
    }
    
    
    // 비밀번호 확인 
    if (pw.value == "") {
        alert("비밀번호를 입력하세요");
        pw.focus();
        return false;
    }
    
    // 비밀번호와 아이디 비교 
    else if (pw.value == uid.value) {
        alert("아이디와 동일한 비밀번호를 사용할 수 없습니다");
        pw.focus();
        return false;
    }
    
    // 비밀번호 일치 확인 
    if (pw.value != pwc.value) {
        alert("비밀번호가 일치하지 않습니다");
        cpw.focus();
        return false;
    }
    
    // 비밀번호 영문, 숫자, 특수문자 포함 8~20자리
    if (!pwdCfm.test(pw.value)) {
        alert("비밀번호는 8~20자리의 영문, 숫자, 특수문자를 최소 1개씩 포함해야 합니다");
        pw.focus();
        return false;
    }
    
    // 이름 확인 
    if (uname.value == "") {
        alert("이름을 입력하세요");
        uname.focus();
        return false;
    } else if (!nameCfm.test(uname.value)) {
        alert("이름은 2글자 이상으로 설정해 주세요");
        uname.focus();
        return false;
    }
    
    // 휴대폰번호
    if (phone.value == "") {
        alert("휴대폰번호를 입력하세요");
        phone.focus();
        return false;
    } else if (!phoneCfm.test(phone.value)) {
        alert("휴대폰번호가 올바르지 않습니다");
        phone.focus();
        return false;
    }
    
    // 이메일 주소 확인 
    if (email.value == "") {
        alert("이메일 주소를 입력하세요");
        email.focus();
        return false;
    } else if (!emailCfm.test(email.value)) {
        alert("잘못된 이메일 형식입니다");
        email.focus();
        return false;
    }
    
    // 생년월일 
    if (birthday.value == "") {
        alert("생년월일을 입력하세요");
        birthday.focus();
        return false;
    } else if (!birthdayCfm.test(birthday.value)) {
        alert("생년월일 형식이 올바르지 않습니다");
        birthday.focus();
        return false;
    } 
	insertMember();
}
