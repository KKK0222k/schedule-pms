<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - 일정관리 시스템</title>
    <!-- Basic styles for responsive design -->
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f4f5f7; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }
        .login-container { background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); width: 100%; max-width: 400px; box-sizing: border-box; }
        .login-container h2 { text-align: center; margin-bottom: 20px; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #666; }
        .form-group input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .btn { width: 100%; padding: 10px; background-color: #0056b3; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin-top: 10px; }
        .btn:hover { background-color: #004494; }
    </style>
    <!-- Include jQuery directly or via app-js-loader if configured. For login page standard script is fine -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // Use AppMain contextPath logic if main.js is loaded, but for standalone login page, defining manually is easier
        var contextPath = "${pageContext.request.contextPath}";
        
        function doLogin() {
            var userId = $("#usrId").val();
            var userPwd = $("#usrPwd").val();
            
            if(!userId) { alert("아이디를 입력하세요."); return; }
            if(!userPwd) { alert("비밀번호를 입력하세요."); return; }
            
            $.ajax({
                type: "POST",
                url: contextPath + "/login/action.do",
                data: {
                    usrId: userId,
                    usrPwd: userPwd
                },
                dataType: "json",
                success: function(response) {
                    if(response.success) {
                        location.href = contextPath + "/schedule/main.do";
                    } else {
                        alert(response.message || "로그인 실패");
                    }
                },
                error: function() {
                    alert("서버 연결 오류");
                }
            });
        }
    </script>
</head>
<body>

<div class="login-container">
    <h2>일정관리 시스템</h2>
    <div class="form-group">
        <label for="usrId">아이디</label>
        <input type="text" id="usrId" name="usrId" required>
    </div>
    <div class="form-group">
        <label for="usrPwd">패스워드</label>
        <input type="password" id="usrPwd" name="usrPwd" required>
    </div>
    <button type="button" class="btn" onclick="doLogin()">로그인</button>
</div>

</body>
</html>
