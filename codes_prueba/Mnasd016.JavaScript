jQuery(document).ready(function($){
  function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
      results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
  }

  var domainToCheck = getParameterByName('domainToCheck');
  if (domainToCheck) {
    $(".search-field").val(domainToCheck);
    $(".rstore-domain-search-button").click();
  }
});

// getParameterByName function found the internet.  Unknown attribution.
// Licensed under MIT License
// For use with WordPress Plugin https://wordpress.org/plugins/reseller-store/