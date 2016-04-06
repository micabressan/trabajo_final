// basic tracking
var debug = false;
var _gaq = _gaq || [];
_gaq.push(['_setAccount', "UA-42377422-1"]);
_gaq.push(['_setAllowAnchor', true]);
_gaq.push(['_setSiteSpeedSampleRate', 100]);

// customvars
if (location.href.indexOf("site_id") > 0)
{
  var querystring = location.search.substr(1).split("&");
  var platform = "";
  for (i = 0; i < querystring.length; i++)
  {
    var names = querystring[i].split("=");

    if (names[0].toLowerCase() == "site_id") { var siteid = names[1]; }
    if (names[0].toLowerCase() == "url") { 
      var platform = unescape(names[1]);
      platform = platform.replace("http://", "");
      platform = platform.replace("https://", "");
      platform = platform.replace("www.", "");
      platform = platform.substr(0, platform.indexOf("/"))

    }
    if (names[0].toLowerCase() == "locale")    { _gaq.push(['_setCustomVar', 3, 'Locale',     names[1], 1]); if (debug) { console.log("3: " + names[1]); } }
    if (names[0].toLowerCase() == "channelid") { _gaq.push(['_setCustomVar', 4, 'Channel ID', names[1], 1]); if (debug) { console.log("4: " + names[1]); } }
  }
  _gaq.push(['_setCustomVar', 1, 'Site ID', siteid + ' - ' + platform, 1]); 
  if (debug) { console.log("1: " + siteid + ' - ' + platform); }
}

// ticket send or not
if ((location.href.indexOf("/home") > -1) && (jQuery("#notice").length > 0))
{
  _gaq.push(['_trackPageview', '/home?ticket=send']);
} else {
  _gaq.push(['_trackPageview']);
}

(function() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? '/web/20150624003623/https://ssl' : '/web/20150624003623/http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();

// Search form
jQuery(function () 
{
  jQuery(document).ready(function() {

    jQuery('#suggest_form').submit(function () 
    {
      _gaq.push(['_trackPageview', '/search?keyword=' + jQuery('#suggestions_query').attr('value')]);
    });

  });  
});