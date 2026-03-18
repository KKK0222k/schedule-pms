var ScheduleMap = (function() {
    
    var map;
    var markers = [];
    var infowindows = [];

    function open() {
        console.log("ScheduleMap open() called");
        bindEvents();
        initDefaultMonth();
        initMap();
        loadMapData();
    }
    
    function bindEvents() {
        $("#btnList").on("click", function() {
            location.href = AppMain.config.contextPath + "/schedule/list.do";
        });
        
        $("#btnSearch").on("click", function() {
            loadMapData();
        });
    }

    function initDefaultMonth() {
        var now = new Date();
        var yyyy = now.getFullYear();
        var mm = String(now.getMonth() + 1).padStart(2, '0');
        $("#searchMonth").val(yyyy + "-" + mm); // Default to current YYYY-MM
    }

    function initMap() {
        var container = document.getElementById('monthlyMap');
        var options = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // Default Seoul City Hall
            level: 8
        };
        map = new kakao.maps.Map(container, options);
    }

    function clearMarkers() {
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = [];
        infowindows = [];
    }

    function loadMapData() {
        var searchMonth = $("#searchMonth").val(); // YYYY-MM
        if(!searchMonth) {
            alert("조회할 월을 선택해주세요.");
            return;
        }

        $.ajax({
            url: AppMain.config.contextPath + "/schedule/map/data",
            type: "POST",
            dataType: "json",
            data: { searchMonth: searchMonth },
            success: function(response) {
                renderMarkers(response.resultList);
            },
            error: function() {
                alert("월별 일정 장소 데이터를 불러오지 못했습니다.");
            }
        });
    }

    function renderMarkers(list) {
        clearMarkers();
        
        if (!list || list.length === 0) {
            alert("해당 월에 장소가 등록된 일정이 없습니다.");
            return;
        }

        var bounds = new kakao.maps.LatLngBounds();
        var hasValidCoords = false;

        $.each(list, function(i, item) {
            if (item.locLat && item.locLon) {
                hasValidCoords = true;
                var position = new kakao.maps.LatLng(item.locLat, item.locLon);
                
                var marker = new kakao.maps.Marker({
                    position: position,
                    map: map
                });
                markers.push(marker);
                bounds.extend(position);

                // Add InfoWindow
                var content = '<div class="info-window">' +
                              '  <h4><a href="' + AppMain.config.contextPath + '/schedule/detail.do?scheduleSn=' + item.scheduleSn + '" target="_blank">' + item.scheduleNm + '</a></h4>' +
                              '  <p>' + item.scheduleStartDe + ' ~ ' + item.scheduleEndDe + '</p>' +
                              '  <p style="margin-top:5px; color:#333;">' + (item.scheduleAdres || item.scheduleLocAdres || '주소 정보 없음') + '</p>' +
                              '</div>';
                              
                var infowindow = new kakao.maps.InfoWindow({
                    content: content,
                    removable: true
                });

                kakao.maps.event.addListener(marker, 'click', function() {
                    infowindow.open(map, marker);
                });
            }
        });

        if (hasValidCoords) {
            map.setBounds(bounds);
        } else {
            alert("해당 월의 일정에 유효한 위치 좌표가 없습니다.");
        }
    }

    return {
        open: open
    };
})();
