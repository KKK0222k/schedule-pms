<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일정 목록 - 일정관리 시스템</title>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css">
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; background-color: #f4f5f7; margin: 0; }
        .container { max-width: 1200px; margin: 0 auto; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 1px solid #ddd; padding-bottom: 10px; }
        .search-area { margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; background: #fafafa; padding: 15px; border-radius: 4px; border: 1px solid #eee; }
        .search-area .inputs input { padding: 8px; border: 1px solid #ccc; border-radius: 4px; width: 250px; }
        .view-tabs { display: flex; gap: 10px; margin-bottom: 20px; }
        .view-tabs button { padding: 8px 15px; border: 1px solid #0056b3; background: #fff; color: #0056b3; cursor: pointer; border-radius: 4px; }
        .view-tabs button.active { background: #0056b3; color: white; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: center; }
        th { background-color: #f8f9fa; }
        td a { color: #0056b3; text-decoration: none; font-weight: bold; }
        td a:hover { text-decoration: underline; }
        .btn { padding: 8px 15px; border: 1px solid #ddd; background: #fff; cursor: pointer; border-radius: 4px; }
        .btn-primary { background: #0056b3; color: white; border: none; }
        .btn-primary:hover { background: #004494; }
        #calendarView { margin-top: 20px; }
        .fc-event { cursor: pointer; background-color: #0056b3 !important; border-color: #004494 !important; }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/locale/ko.js"></script>
    
    <script src="${pageContext.request.contextPath}/js/schedule/common/main.js"></script>
    <script src="${pageContext.request.contextPath}/js/schedule/panel/list.js"></script>
    
    <script>
        $(document).ready(function() {
            AppMain.config.contextPath = "${pageContext.request.contextPath}";
            ScheduleList.open();
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>일정 목록</h2>
            <div>
                <span>${sessionScope.userInfo.usrId}님</span>
                <button class="btn" onclick="location.href='${pageContext.request.contextPath}/login/logout.do'">로그아웃</button>
            </div>
        </div>

        <div class="search-area">
            <div class="inputs">
                <input type="text" id="searchKeyword" placeholder="일정명 검색">
                <button type="button" class="btn btn-primary" id="btnSearch">검색</button>
            </div>
            <div>
                <button type="button" class="btn" style="background:#28a745; color:white; border:none;" onclick="location.href='${pageContext.request.contextPath}/schedule/map.do'">월별 일정 장소</button>
                <button type="button" class="btn btn-primary" id="btnInsert">일정 등록</button>
            </div>
        </div>

        <div class="view-tabs">
            <button type="button" class="active" data-view="calendar">달력형</button>
            <button type="button" data-view="list">목록형</button>
        </div>

        <div id="calendarView">
            <div id="calendar"></div>
        </div>

        <div id="listView" style="display: none;">
            <table>
                <thead>
                    <tr>
                        <th width="10%">순번</th>
                        <th width="50%">일정명</th>
                        <th width="20%">시작일자</th>
                        <th width="20%">종료일자</th>
                    </tr>
                </thead>
                <tbody id="scheduleTableBody">
                    <!-- Data populated by JS -->
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
