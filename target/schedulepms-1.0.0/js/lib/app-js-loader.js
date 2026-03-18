document.addEventListener("DOMContentLoaded", function() {
    // Load local JS packages
    if (typeof AppJsPackage !== 'undefined' && AppJsPackage.libs) {
        var head = document.getElementsByTagName('head')[0];
        AppJsPackage.libs.forEach(function(src) {
            var script = document.createElement('script');
            script.type = 'text/javascript';
            script.src = src;
            script.async = false; // Preserve order
            head.appendChild(script);
        });
    }
    
});
