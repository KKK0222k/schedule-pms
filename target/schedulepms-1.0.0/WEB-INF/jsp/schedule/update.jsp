<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일정 수정 - 일정관리 시스템</title>
    
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; background-color: #f4f5f7; margin: 0; }
        .container { max-width: 800px; margin: 0 auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .header { border-bottom: 2px solid #0056b3; padding-bottom: 10px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: bold; color: #555; margin-bottom: 5px; }
        .form-group input[type="text"], .form-group textarea, .form-group input[type="file"] { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .form-group textarea { height: 150px; resize: vertical; }
        .date-group { display: flex; gap: 10px; align-items: center; }
        .date-group input { width: 45%; }
        .required::after { content: " *"; color: red; }
        .btn-group { text-align: center; margin-top: 30px; }
        .btn { padding: 10px 20px; border: 1px solid #ddd; background: #fff; cursor: pointer; border-radius: 4px; margin: 0 5px; font-size: 14px; }
        .btn-primary { background: #0056b3; color: white; border: none; }
        .file-info { margin-top: 5px; font-size: 14px; color: #888; }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/schedule/common/main.js"></script>
    <script src="${pageContext.request.contextPath}/js/schedule/panel/update.js"></script>
    
    <script>
        // Set Kakao API Key for app-js-loader and Postcode API script
        window.KAKAO_API_KEY = '${kakaoApiKey}';
    </script>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoApiKey}&libraries=services"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script>
        $(document).ready(function() {
            AppMain.config.contextPath = "${pageContext.request.contextPath}";
            ScheduleUpdate.open('${scheduleSn}');
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2 style="margin:0;">일정 수정</h2>
            <div>
                <button class="btn" id="btnDetail">취소(상세보기)</button>
                <button class="btn" id="btnList">목록</button>
            </div>
        </div>

        <form id="updateForm" enctype="multipart/form-data">
            <input type="hidden" id="scheduleSn" name="scheduleSn">

            <div class="form-group">
                <label class="required" for="scheduleNm">일정명</label>
                <input type="text" id="scheduleNm" name="scheduleNm" placeholder="일정명을 입력하세요.">
            </div>

            <div class="form-group">
                <label class="required">일정 기간</label>
                <div class="date-group">
                    <input type="text" id="scheduleStartDe" name="scheduleStartDe" class="datepicker" placeholder="시작일자 (YYYY-MM-DD)" readonly>
                    <span>~</span>
                    <input type="text" id="scheduleEndDe" name="scheduleEndDe" class="datepicker" placeholder="종료일자 (YYYY-MM-DD)" readonly>
                </div>
            </div>

            <div class="form-group">
                <label for="scheduleAdres">장소 (주소)</label>
                <div style="display:flex; gap:10px;">
                    <input type="text" id="scheduleAdres" name="scheduleAdres" placeholder="주소를 검색하세요" readonly style="flex:1;">
                    <button type="button" class="btn btn-primary" id="btnSearchAdres">주소 변경</button>
                    <!-- Hidden coordinate fields for DB -->
                    <input type="hidden" id="locLon" name="locLon">
                    <input type="hidden" id="locLat" name="locLat">
                </div>
            </div>

            <div class="form-group">
                <label for="scheduleCn">일정 내용</label>
                <textarea id="scheduleCn" name="scheduleCn" placeholder="일정 내용을 입력하세요."></textarea>
            </div>

            <div class="form-group">
                <label for="attachFile">첨부파일 변경</label>
                <input type="file" id="attachFile" name="attachFile">
                <div class="file-info" id="fileInfo"></div>
            </div>
        </form>

        <div class="btn-group">
            <button type="button" class="btn btn-primary" id="btnSave">수정 완료</button>
        </div>
    </div>
</body>
</html>
