<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

</head>
<body>

<h1>회원가입</h1>

<form action="registerAdd" method="post">

	<%-- Controller로 이동하기 위한 input tag --%>

	<input type="hidden" name="command" value="addAf">

	아이디 : <input type="text" name="id" id="_id" maxlength="20" size="20">		
	<input type="button" id="btn" value="id확인">
	<p id="idcheck" style="font-size: 8px"></p>
	<br><br>
	
	패스워드 : <input type="password" name="pwd" id="_pwd" maxlength="20" minlength="6" placeholder="6자리 이상 입력">
	<br><br>
	
	이름 : <input type="text" name="UserName" id="_username" maxlength="20">
	<br><br>
	
	생일 : <input type="text" name="birth" id="_birth" maxlength="20" placeholder="숫자로만 입력">
	<br><br>
	
	<%-- 주소 --%>
	
	<input type="text" name="Postcode" id="sample6_postcode" placeholder="우편번호">
	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" name="Address" id="sample6_address" placeholder="주소"><br>
	<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소">
	<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목">
	<br><br>
	
	<%-- 주소 끝 --%>
	
	이메일 : <input type="email" name="email" id="_email" maxlength="30" size="30">
	<br><br>
	
	전화번호 : <input type="phonenum" name="phonenum" id="_phonenum" maxlength="20" placeholder="숫자로만 입력">
	<br><br>

	<input type="submit" value="회원가입">
	
</form>

<script>
    function sample6_execDaumPostcode() 
    {
        new daum.Postcode({
            oncomplete: function(data)
            {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R')
                {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
    
    $("#btn").click(function () 
    {		
		$.ajax({
			type:"get",
			url:"./idcheck.jsp",
			data:"id=" + $('#id').val(),			
			success:function(data){				
				if(data.trim() == "OK"){
					$("#idcheck").css("color", "#0000ff");
					$("#idcheck").html("사용할 수 있는 id입니다");
				}else{
					$("#idcheck").css("color", "#ff0000");
					$("#idcheck").html("사용 중인 id입니다");		
					$("#id").val("");
				}
			}			
		});
	});
</script>

</body>
</html>