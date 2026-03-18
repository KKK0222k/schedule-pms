var ScheduleList = (function() {
    
    // Config and default search state
    var searchState = {
        scheduleNm: ""
    };

    function open() {
        console.log("ScheduleList open() called");
        bindEvents();
        initCalendar();
        initList();
    }
    
    function bindEvents() {
        // Use off() before on() to ensure no duplicate event bindings
        $("#btnInsert").off("click").on("click", function() {
            location.href = AppMain.config.contextPath + "/schedule/insert.do";
        });
        
        $("#btnSearch").off("click").on("click", function() {
            searchState.scheduleNm = $("#searchKeyword").val();
            loadListData();
            
            // Re-fetch calendar events on search if calendar is visible
            if ($("#calendarView").is(":visible")) {
                $('#calendar').fullCalendar('refetchEvents');
            }
        });
        
        // Tab switching between list and calendar
        $(".view-tabs button").off("click").on("click", function() {
            $(".view-tabs button").removeClass("active");
            $(this).addClass("active");
            var viewType = $(this).data("view");
            if(viewType === "calendar") {
                $("#calendarView").show();
                $("#listView").hide();
                $('#calendar').fullCalendar('render'); // Force render
            } else {
                $("#calendarView").hide();
                $("#listView").show();
                loadListData();
            }
        });
    }

    function initCalendar() {
        if(typeof $('#calendar').fullCalendar !== 'function') {
            console.error("FullCalendar plugin not loaded!");
            return;
        }
        
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,listMonth' // 'listMonth' gives a list view per month. (or basicWeek, basicDay if preferred)
            },
            fixedWeekCount: false,
            contentHeight: "auto",
            aspectRatio: 2, // makes the calendar a bit shorter/wider reducing scroll needs
            // Default view can be 'month'
            defaultView: 'month',
            events: function(start, end, timezone, callback) {
                // Fetch events from API using searchState
                var requestData = {
                    scheduleNm: searchState.scheduleNm
                    // FullCalendar also passes start/end automatically if you want to filter strictly by month
                };
                
                $.ajax({
                    url: AppMain.config.contextPath + "/schedule/list",
                    type: "POST",
                    dataType: "json",
                    data: requestData,
                    success: function(response) {
                        var events = [];
                        if (response.resultList) {
                            $.each(response.resultList, function(i, item) {
                                // Requirement: "일정 시작시간 + 일정명 형태 표시" -> fullcalendar title handles this,
                                // but we can pad / format the date if they included time. Since purely 'YYYY-MM-DD' is used,
                                // we'll use title directly. To show time, `item.scheduleNm` can be prefixed if time exists.
                                // FullCalendar treats 'end' as exclusive. If an event ends on 'YYYY-MM-DD', 
                                // we must add 1 day to 'end' so it renders inclusively across that day.
                                var endDateObj = new Date(item.scheduleEndDe);
                                endDateObj.setDate(endDateObj.getDate() + 1);
                                var endStr = endDateObj.toISOString().split('T')[0];

                                events.push({
                                    id: item.scheduleSn,
                                    title: item.scheduleNm,
                                    start: item.scheduleStartDe,
                                    end: endStr
                                });
                            });
                        }
                        callback(events);
                    },
                    error: function() {
                        alert("일정 목록을 불러오지 못했습니다.");
                        callback([]);
                    }
                });
            },
            eventClick: function(calEvent, jsEvent, view) {
                location.href = AppMain.config.contextPath + "/schedule/detail.do?scheduleSn=" + calEvent.id;
            }
        });
    }
    
    function initList() {
        loadListData();
    }
    
    function loadListData() {
        $.ajax({
            url: AppMain.config.contextPath + "/schedule/list",
            type: "POST",
            dataType: "json",
            data: searchState,
            success: function(response) {
                var tbody = $("#scheduleTableBody");
                tbody.empty();
                
                if (response.resultList && response.resultList.length > 0) {
                    $.each(response.resultList, function(i, item) {
                        var tr = $("<tr>");
                        tr.append($("<td>").text((i + 1))); // Sequence / Row Num
                        var titleLink = $("<a>").attr("href", AppMain.config.contextPath + "/schedule/detail.do?scheduleSn=" + item.scheduleSn).text(item.scheduleNm);
                        tr.append($("<td>").append(titleLink)); // 일정명
                        tr.append($("<td>").text(item.scheduleStartDe)); // 시작일자
                        tr.append($("<td>").text(item.scheduleEndDe)); // 종료일자
                        tbody.append(tr);
                    });
                } else {
                    tbody.append("<tr><td colspan='4' class='text-center'>등록된 일정이 없습니다.</td></tr>");
                }
            },
            error: function() {
                console.error("List load failed");
            }
        });
    }

    return {
        open: open
    };
})();
