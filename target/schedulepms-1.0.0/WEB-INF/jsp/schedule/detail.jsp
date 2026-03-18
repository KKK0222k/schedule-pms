<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일정 상세 - 일정관리 시스템</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; background-color: #f4f5f7; margin: 0; }
        .container { max-width: 800px; margin: 0 auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .header { border-bottom: 2px solid #0056b3; padding-bottom: 10px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
        .detail-group { margin-bottom: 20px; }
        .detail-group label { display: block; font-weight: bold; color: #555; margin-bottom: 5px; }
        .detail-group .content-box { padding: 15px; background: #fafafa; border: 1px solid #ddd; border-radius: 4px; min-height: 40px; }
        .btn-group { text-align: center; margin-top: 30px; }
        .btn { padding: 10px 20px; border: 1px solid #ddd; background: #fff; cursor: pointer; border-radius: 4px; margin: 0 5px; font-size: 14px; }
        .btn-primary { background: #0056b3; color: white; border: none; }
        .btn-danger { background: #dc3545; color: white; border: none; }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/schedule/common/main.js"></script>
    <script src="${pageContext.request.contextPath}/js/schedule/panel/detail.js"></script>
    
    <script>
        window.KAKAO_API_KEY = '${kakaoApiKey}';
        window.VWORLD_API_KEY = '${vworldApiKey}';
    </script>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoApiKey}&libraries=services"></script>
    <script src="https://map.vworld.kr/js/vworldMapInit.js.do?apiKey=${vworldApiKey}"></script>

    <script>
        $(document).ready(function() {
            AppMain.config.contextPath = "${pageContext.request.contextPath}";
            ScheduleDetail.open('${scheduleSn}');
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2 style="margin:0;">일정 상세</h2>
            <button class="btn" id="btnList">목록</button>
        </div>

        <div class="detail-group">
            <label>일정명</label>
            <div class="content-box" id="detailNm"></div>
        </div>

        <div class="detail-group">
            <label>일정 기간</label>
            <div class="content-box" id="detailPeriod"></div>
        </div>

        <div class="detail-group">
            <label>장소</label>
            <div class="content-box" id="detailAdres" style="margin-bottom: 10px; display: none;"></div>
            <div class="btn-group map-btn">
                <button type="button" class="btn btn-kakao" id="btnKakao">카카오</button>
                <button type="button" class="btn btn-vworld" id="btnVworld">브이월드</button>
            </div>
            <div id="scheduleMap" style="width: 100%; height: 300px; display: none; border-radius: 4px; border: 1px solid #ddd;"></div>
            <input type="hidden" id="locLon">
            <input type="hidden" id="locLat">
        </div>

        <div class="detail-group">
            <label>일정 내용</label>
            <div class="content-box" id="detailCn" style="min-height: 100px; white-space: pre-wrap;"></div>
        </div>

        <div class="detail-group">
            <label>첨부파일</label>
            <div class="content-box" id="detailFile"></div>
        </div>

        <div class="btn-group">
            <button type="button" class="btn btn-primary" id="btnUpdate">수정</button>
            <button type="button" class="btn btn-danger" id="btnDelete">삭제</button>
        </div>
    </div>
</body>
</html>
