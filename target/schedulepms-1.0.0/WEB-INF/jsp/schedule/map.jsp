<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>월별 일정 장소 - 일정관리 시스템</title>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; background-color: #f4f5f7; margin: 0; }
        .container { max-width: 1000px; margin: 0 auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .header { border-bottom: 2px solid #0056b3; padding-bottom: 10px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
        .search-area { display: flex; gap: 10px; margin-bottom: 20px; align-items: center; }
        .search-area select, .search-area input[type="month"] { padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .btn { padding: 10px 20px; border: 1px solid #ddd; background: #fff; cursor: pointer; border-radius: 4px; margin: 0 5px; font-size: 14px; }
        .btn-primary { background: #0056b3; color: white; border: none; }
        
        #monthlyMap { width: 100%; height: 600px; border-radius: 8px; border: 1px solid #ddd; }
        
        /* Custom InfoWindow Style */
        .info-window { padding: 10px; font-size: 13px; min-width: 200px; }
        .info-window h4 { margin: 0 0 5px 0; font-size: 14px; color: #0056b3; }
        .info-window p { margin: 0; color: #666; font-size: 12px; }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/schedule/common/main.js"></script>
    <script src="${pageContext.request.contextPath}/js/schedule/panel/map.js"></script>
    
    <script>
        window.KAKAO_API_KEY = '${kakaoApiKey}';
    </script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoApiKey}&libraries=services"></script>

    <script>
        $(document).ready(function() {
            AppMain.config.contextPath = "${pageContext.request.contextPath}";
            ScheduleMap.open();
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2 style="margin:0;">월별 일정 장소</h2>
            <div>
                <button class="btn" id="btnList">목록(달력) 보기</button>
            </div>
        </div>

        <div class="search-area">
            <label for="searchMonth" style="font-weight: bold;">조회 월 선택:</label>
            <input type="month" id="searchMonth" name="searchMonth">
            <button class="btn btn-primary" id="btnSearch">조회</button>
        </div>

        <div id="monthlyMap"></div>
    </div>
</body>
</html>
