var ScheduleDetail = (function () {

    var currentScheduleSn = null;

    function open(scheduleSn) {
        currentScheduleSn = scheduleSn;
        console.log("ScheduleDetail open() called with id:", scheduleSn);
        loadDetail();
        bindEvents();
    }

    function bindEvents() {
        $("#btnList").on("click", function () {
            location.href = AppMain.config.contextPath + "/schedule/list.do";
        });

        $("#btnUpdate").on("click", function () {
            location.href = AppMain.config.contextPath + "/schedule/update.do?scheduleSn=" + currentScheduleSn;
        });

        $("#btnDelete").on("click", function () {
            if (confirm("정말로 삭제하시겠습니까?")) {
                deleteSchedule();
            }
        });

        $("div.map-btn").find("button").on("click", function (){
           const _btn = $(this);
           _btn.id == "btnKakao" ? _btn.addClass("btn-primary") : _btn.addClass("btn-danger");
           console.log(_btn);
        });
    }

    function loadDetail() {
        if (!currentScheduleSn) return;

        $.ajax({
            url: AppMain.config.contextPath + "/schedule/" + currentScheduleSn,
            type: "POST",
            dataType: "json",
            success: function (response) {
                if (response.result) {
                    var data = response.result;
                    $("#detailNm").text(data.scheduleNm);
                    $("#detailPeriod").text(data.scheduleStartDe + " ~ " + data.scheduleEndDe);
                    $("#detailCn").text(data.scheduleCn);

                    if (data.scheduleAdres) {
                        $("#detailAdres").text(data.scheduleAdres).show();
                        if (data.locLat && data.locLon && window.kakao && kakao.maps) {
                            $("#scheduleMap").show();
                            renderMap(data.locLat, data.locLon);
                        }
                    }

                    if (data.scheduleFileOrgNm) {
                        var fileLink = $("<a>")
                            .attr("href", AppMain.config.contextPath + data.scheduleFilePath)
                            .attr("download", data.scheduleFileOrgNm)
                            .text(data.scheduleFileOrgNm);
                        $("#detailFile").html(fileLink);
                    } else {
                        $("#detailFile").text("첨부파일 없음");
                    }
                }
            }
        });
    }

    function deleteSchedule() {
        $.ajax({
            url: AppMain.config.contextPath + "/schedule/delete",
            type: "POST",
            data: { scheduleSn: currentScheduleSn },
            dataType: "json",
            success: function (response) {
                if (response.success) {
                    alert("삭제되었습니다.");
                    location.href = AppMain.config.contextPath + "/schedule/list.do";
                }
            }
        });
    }

    function renderMap(lat, lng) {
        kakao.maps.load(function () {
            var container = document.getElementById('scheduleMap'); //지도를 담을 영역의 DOM 레퍼런스
            var options = {
                center: new kakao.maps.LatLng(lat, lng), //지도의 중심좌표.
                level: 3 //지도의 레벨(확대, 축소 정도)
            };
            var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

            // 마커 생성
            var markerPosition = new kakao.maps.LatLng(lat, lng);
            var marker = new kakao.maps.Marker({
                position: markerPosition
            });
            marker.setMap(map);
        });
    }

    return {
        open: open
    };
})();
