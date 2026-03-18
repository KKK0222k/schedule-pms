var ScheduleUpdate = (function() {
    
    var currentScheduleSn = null;

    function open(scheduleSn) {
        currentScheduleSn = scheduleSn;
        console.log("ScheduleUpdate open() called with id:", scheduleSn);
        initDatePicker();
        loadDetail();
        bindEvents();
    }
    
    function initDatePicker() {
        if($.fn.datepicker) {
            $(".datepicker").datepicker({
                dateFormat: 'yy-mm-dd'
            });
        }
    }
    
    function bindEvents() {
        $("#btnList").on("click", function() {
            location.href = AppMain.config.contextPath + "/schedule/list.do";
        });
        
        $("#btnDetail").on("click", function() {
            location.href = AppMain.config.contextPath + "/schedule/detail.do?scheduleSn=" + currentScheduleSn;
        });
        
        $("#btnSave").on("click", function() {
            updateSchedule();
        });

        $("#btnSearchAdres").on("click", function() {
            openAddressSearch();
        });
    }

    function openAddressSearch() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수
                $("#scheduleAdres").val(addr);
                
                // 주소로 상세 좌표 검색 (Geocoding)
                if (window.kakao && kakao.maps && kakao.maps.services) {
                    var geocoder = new kakao.maps.services.Geocoder();
                    geocoder.addressSearch(addr, function(result, status) {
                        if (status === kakao.maps.services.Status.OK) {
                            $("#locLon").val(result[0].x);
                            $("#locLat").val(result[0].y);
                        } else {
                            console.warn("좌표를 찾을 수 없는 주소입니다.");
                            $("#locLon").val('');
                            $("#locLat").val('');
                        }
                    });
                }
            }
        }).open();
    }

    function loadDetail() {
        if(!currentScheduleSn) return;
        
        $.ajax({
            url: AppMain.config.contextPath + "/schedule/" + currentScheduleSn,
            type: "POST",
            dataType: "json",
            success: function(response) {
                if (response.result) {
                    var data = response.result;
                    $("#scheduleSn").val(data.scheduleSn);
                    $("#scheduleNm").val(data.scheduleNm);
                    $("#scheduleStartDe").val(data.scheduleStartDe);
                    $("#scheduleEndDe").val(data.scheduleEndDe);
                    $("#scheduleCn").val(data.scheduleCn);
                    
                    if(data.scheduleAdres) {
                        $("#scheduleAdres").val(data.scheduleAdres);
                        $("#locLon").val(data.locLon);
                        $("#locLat").val(data.locLat);
                    }
                    
                    if (data.scheduleFileOrgNm) {
                        $("#fileInfo").text("기존 파일: " + data.scheduleFileOrgNm);
                    }
                }
            }
        });
    }

    function validate() {
        if (!$("#scheduleNm").val()) {
            alert("일정명을 입력하세요.");
            $("#scheduleNm").focus();
            return false;
        }
        if (!$("#scheduleStartDe").val()) {
            alert("일정시작일자를 선택하세요.");
            $("#scheduleStartDe").focus();
            return false;
        }
        if (!$("#scheduleEndDe").val()) {
            alert("일정종료일자를 선택하세요.");
            $("#scheduleEndDe").focus();
            return false;
        }
        return true;
    }
    
    function updateSchedule() {
        if (!validate()) return;
        
        var form = document.getElementById("updateForm");
        var formData = new FormData(form);
        
        $.ajax({
            url: AppMain.config.contextPath + "/schedule/update",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if(response.success) {
                    alert("수정되었습니다.");
                    location.href = AppMain.getContextPath() + "/schedule/detail.do?scheduleSn=" + currentScheduleSn;
                } else {
                    alert("수정 중 오류가 발생했습니다.");
                }
            },
            error: function() {
                alert("서버 연결 실패.");
            }
        });
    }

    return {
        open: open
    };
})();
