//
// Really Simple FB Adblocker
// 02/01/2018
//
// Description: 
// This simple script hides "Recommended Posts" and "Recommended Pages".
//
// Instructions:
// Inject the script on facebook.com (by using an addon, for ex. "Custom Style Script" on Firefox).
//

document.addEventListener("DOMContentLoaded", function() {
    window.onscroll = function() {
        // Hides "Recommended Posts"
        var list = document.getElementsByClassName("v_1hzrkmvfq2");
        for (indx = 0; indx < list.length; ++indx) {
            var x = list[indx].parentElement.parentElement.parentElement.parentElement.parentElement;
            x.style.display = "none";
        }
    };
    // Hides "Recommended Pages"
    var right_panel = document.getElementById("pagelet_ego_pane");
    right_panel.style.display = "none";
});