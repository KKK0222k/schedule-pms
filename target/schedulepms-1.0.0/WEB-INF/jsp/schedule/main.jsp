<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일정관리 시스템 - 메인</title>
    
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css">
    
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; background-color: #f4f5f7; margin: 0; }
        .container { max-width: 1200px; margin: 0 auto; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 1px solid #ddd; padding-bottom: 10px; }
        .btn { padding: 8px 15px; border: 1px solid #ddd; background: #fff; cursor: pointer; border-radius: 4px; }
        .btn-primary { background: #0056b3; color: white; border: none; }
        .btn-primary:hover { background: #004494; }
        .menu { margin-bottom: 20px; }
        .menu a { margin-right: 15px; text-decoration: none; color: #333; font-weight: bold; }
        .menu a:hover { color: #0056b3; }
    </style>
    
    <!-- Load required libraries from CDNs as requested if missing from local lib folder to ensure it runs -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/locale/ko.js"></script>

    <!-- Configure AppMain dynamically from JSP -->
    <script src="${pageContext.request.contextPath}/js/schedule/common/main.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            AppMain.config.contextPath = "${pageContext.request.contextPath}";
            
            // On load, by default load the schedule list module or redirect to list.do
            // Here, we'll just redirect to list view. The main menu handles navigation.
            location.href = AppMain.config.contextPath + "/schedule/list.do";
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>일정관리 시스템</h2>
            <div>
                <span>${sessionScope.userInfo.usrId}님 환영합니다.</span>
                <button class="btn" onclick="location.href='${pageContext.request.contextPath}/login/logout.do'">로그아웃</button>
            </div>
        </div>
        <div class="content text-center">
            <p>로딩 중...</p>
        </div>
    </div>
</body>
</html>
