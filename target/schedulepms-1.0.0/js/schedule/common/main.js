var AppMain = (function() {
    
    // Global configurations
    var config = {
        contextPath: "",
        apiProxyUrl: "/common/proxy.jsp?api="
    };
    
    function init() {
        console.log("AppMain initialized. Global settings loaded.");
        // Setup default ajax error handling if using jQuery
        if(window.jQuery) {
            $.ajaxSetup({
                error: function(xhr, status, err) {
                    if(xhr.status === 401) {
                        alert("로그인이 필요합니다.");
                        location.href = config.contextPath + "/login/view.do";
                    }
                }
            });
        }
    }
    
    function getProxyUrl(targetApiUrl) {
        // e.g. targetApiUrl = "http://other-domain.com/api/data"
        return config.contextPath + config.apiProxyUrl + encodeURIComponent(targetApiUrl);
    }
    
    function loadModule(scriptPath, moduleName, callback) {
        // Check if already loaded
        if (window[moduleName]) {
            if(typeof callback === 'function') callback();
            return;
        }

        var script = document.createElement('script');
        script.src = config.contextPath + scriptPath;
        script.onload = function() {
            if(typeof callback === 'function') callback();
        };
        script.onerror = function() {
            console.error("Failed to load module: " + scriptPath);
        };
        document.head.appendChild(script);
    }

    return {
        init: init,
        config: config,
        getProxyUrl: getProxyUrl,
        loadModule: loadModule
    };
})();

// Wait for jQuery if loaded
document.addEventListener("DOMContentLoaded", function() {
    AppMain.init();
});
