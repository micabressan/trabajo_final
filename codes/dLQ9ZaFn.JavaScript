// ==UserScript==
// @name        OSHColor
// @namespace   https://www.oldschoolhack.me/
// @description Hintergrund ändern
// @include     https://oldschoolhack.me/*
// @include     https://www.oldschoolhack.me/*
// @version     4
// @grant       GM_addStyle
// ==/UserScript==

var BackgroundColorGroup1 = "#111111"; // 111111
var BackgroundColorGroup2 = "#0a0a0a"; // 0a0a0a
var BackgroundColorGroup3 = "#1a1a1a"; // 1a1a1a
var BackgroundColorGroup4 = "#333333"; // 333333
var BackgroundColorGroup5 = "#003300"; // 003300
var BackgroundColorGroup6 = "#330000"; // 330000
var BackgroundColorGroup7 = "#0f0f0f"; // 141414
var BackgroundColorGroup8 = "#00bb00"; // 00bb00
var BackgroundColorGroup9 = "#bb0000"; // bb0000

var LineColorGroup1 = "#333333"; // 333333
var LineColorGroup2 = "#484848"; // 484848

var TextColorGroup1 = "#aaaaaa";  // 888888
var TextColorGroup2 = "#bbbbbb"; // 999999
var TextColorGroup3 = "#cccccc"; // aaaaaa
var TextColorGroup4 = "#000000"; // 000000

var HomeButton = "http://abload.de/img/homemjjpg.png";
var IconImage = "http://abload.de/img/ui-icons_f48a00_256x2n0j03.png";
var CategoryMarker = "http://abload.de/img/markerjly0t.png";
var ZoomImage = "http://abload.de/img/zoom-iconlyklu.png";
var NewBanner = "http://www.abload.de/img/new2eekn6.png";
var FavIcon = "data:image/x-icon;base64,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";
var Banner = "http://www.abload.de/img/header223ag2.png";
var ChristmasBanner = "http://abload.de/img/oldschoolhackheaderxmkqek5.png";
var GermanFlag = "http://abload.de/img/germanhkrek4w.png"; //"https://www.oldschoolhack.me/images/icons/german.gif"; // "http://abload.de/img/germanhkrek4w.png"; // coughcough
var OshIcon = "http://www.abload.de/img/logo2hvkk6.png";
var OshIconSmall = "http://abload.de/img/371c2o.png";
var ReportButton = "http://abload.de/img/reportpeqeq.gif";
var Upvote = "http://abload.de/img/vote_upy7pbz.gif";
var Downvote = "http://abload.de/img/vote_down0lp0r.gif";
var DefaultHackScreenshot = "http://abload.de/img/notavailablenekoq.jpg";
var DefaultAvatarIcon = "http://abload.de/img/noavatar9zyfg.jpg";
var DefaultAvatarSmall = "http://abload.de/img/noavatar5lsft.jpg";
var TopicHot = "http://abload.de/img/topic_hotmpjzz.gif";
var TopicMoved = "http://abload.de/img/topic_movedrajuv.gif";
var TopicLocked = "http://abload.de/img/topic_hot_lockngjut.gif";
var TopicDotHot = "http://abload.de/img/topic_dot_hottmbmz.gif";
var TopicDotHotNew = "http://abload.de/img/topic_dot_hot_newl1d1y.gif";
var TopicHotNew = "http://abload.de/img/topic_hot_new3tsa2.gif";
var UploadSourceA = "http://abload.de/img/local42qr5.png";
var UploadSourceB = "http://abload.de/img/remotev9pg4.png";
var Loading = "http://abload.de/img/ajax-loaderu5sm0.gif";

function ReplaceBackgrounds()
{
	// Page background
	GM_addStyle("body { background: " + BackgroundColorGroup1 + "!important; }");
	
	// Navbar
	GM_addStyle(".page-header { background: " + BackgroundColorGroup2 + "!important; }");
	GM_addStyle(".header-menu ul li.selected a, .header-menu ul li a:hover { background-color: " + BackgroundColorGroup3 + "!important; }"); // Selected/On Hover
	GM_addStyle(".header-menu ul li .home { background: url('" + HomeButton + "') no-repeat scroll 100% 0 rgba(0, 0, 0, 0); }"); // Home Button
	GM_addStyle(".header-menu ul li.selected .home, .header-menu ul li .home:hover { background: url('" + HomeButton + "') no-repeat scroll 0 0 rgba(0, 0, 0, 0); }"); // Home Button Selected
	
	// Header Bar
	//GM_addStyle(".special > .header { background: " + "#ff0000" + "!important; }"); //? No effect? - ka was das war
	
	// Box Headers
	GM_addStyle(".box > .header { background: " + BackgroundColorGroup2 + "!important; }");
	
	// Forum Section Content
	GM_addStyle(".forums tr.content:nth-child(2n) { background: " + BackgroundColorGroup7 + "!important; }");
	
	// Forum Section Bars
	GM_addStyle(".forums tr.header { background: " + BackgroundColorGroup3 + "!important; }");
	
	// Forum Section Sub Bars
	GM_addStyle(".forums tr.columns { background: " + BackgroundColorGroup2 + "!important; }");
	
	// Forum News Bars (hottest, top poster, etc.)
	GM_addStyle(".forum-news tr.header { background: " + BackgroundColorGroup3 + "!important; }");
	
	// Footer
	GM_addStyle(".page-footer { background: " + BackgroundColorGroup2 + "!important; }");
	
	// Search Bar
	GM_addStyle(".header-search .input { background: " + BackgroundColorGroup1 + "!important; }");
	
	// Buttons (Search bar, etc.)
	GM_addStyle(".flatbutton, .flatbutton-small { background-color: " + BackgroundColorGroup3 + "; }");
	GM_addStyle(".flatbutton:hover, .flatbutton-small:hover { background-color: " + BackgroundColorGroup4 + "; }");
	
	// Forum Hovers
	GM_addStyle(".forums tr.columns:hover td, .forums tr.content:hover td { background-color: " + BackgroundColorGroup2 + "; }"); // Default hovers
	GM_addStyle(".file-recent-list li:hover { box-shadow: 0 0 10px 3px " + BackgroundColorGroup3 + " inset; }"); // Download Hover
	GM_addStyle(".topics .content > tr.split:hover td { background-color: " + BackgroundColorGroup2 + "; }"); // Topics Hover
	GM_addStyle(".topics .content > tr:first-child:hover td { background-color: " + BackgroundColorGroup2 + "; }"); // Topics Hover
	GM_addStyle(".topics .content > tr:hover td { background-color: " + BackgroundColorGroup2 + "; }"); // Topics Hover
	
	// Shoutbox
	GM_addStyle(".shoutbox > .content > div > div:nth-child(2n+1) { background-color: " + BackgroundColorGroup3 + "; }");
	GM_addStyle("input, select, textarea { background: " + BackgroundColorGroup2 + "; }"); // Inputbox
	
	// Popups (Shoutbox smileys, etc.)
	GM_addStyle(".ui-widget-header { background: " + BackgroundColorGroup3 + "; }"); // Header
	GM_addStyle(".ui-widget-content { background: " + BackgroundColorGroup2 + "; }"); // Background
	GM_addStyle(".ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default { background: " + BackgroundColorGroup3 + "; }"); // Button
	GM_addStyle(".ui-state-default .ui-icon { background-image: url('" + IconImage + "') !important; }"); // Close Button
	
	// Fieldset
	GM_addStyle("legend { background: " + BackgroundColorGroup2 + "; }"); // Header
	
	// Topics
	GM_addStyle(".topics .announcements > tr:first-child { background: " + BackgroundColorGroup3 + "!important; }"); // Header
	GM_addStyle(".topics .content > tr:first-child { background: " + BackgroundColorGroup3 + "!important; }"); // Header
	GM_addStyle(".topics .content > tr.split { background: " + BackgroundColorGroup3 + "!important; }"); // Header
	GM_addStyle(".topics .content > tr:nth-child(2n) { background: " + BackgroundColorGroup7 + "; }"); // Header
	
	// Navigation buttons (pages, etc.)
	GM_addStyle(".navbar b { background: " + BackgroundColorGroup3 + "; }");
	GM_addStyle(".navbar a { background: " + BackgroundColorGroup2 + "; }");
	GM_addStyle(".navbar b:hover { background: " + BackgroundColorGroup2 + "; }");
	GM_addStyle(".navbar a:hover { background: " + BackgroundColorGroup3 + "; }");
	
	// ThreadPosts
	GM_addStyle(".thread-post tr.header { background: " + BackgroundColorGroup2 + "; }");
	
	// Forum Diverse Headers
	GM_addStyle(".forum-moderate .header { background: " + BackgroundColorGroup2 + "; }");
	
	// Profile
	GM_addStyle(".profile .header { background: " + BackgroundColorGroup3 + "; }");
	
	// UCP
	GM_addStyle(".three-panel tr:first-child { background: " + BackgroundColorGroup3 + "; }");
	GM_addStyle(".three-panel tr:first-child:hover td { background: " + BackgroundColorGroup2 + "; }");
	GM_addStyle(".three-panel tr:hover td { background: " + BackgroundColorGroup2 + "; }");
	
	// Reputation
	GM_addStyle(".reputation-box .bar-positive { background: " + BackgroundColorGroup8 + "; }");
	GM_addStyle(".reputation-box .bar-negative { background: " + BackgroundColorGroup9 + "; }");
	
	// Editor
	GM_addStyle("div.sceditor-toolbar { background: " + BackgroundColorGroup2 + "; }"); // Header
	GM_addStyle(".sceditor-container { background: " + BackgroundColorGroup2 + "; }"); // Content
	GM_addStyle("div.sceditor-group { background: " + BackgroundColorGroup3 + "; }"); // Toolgroups
	GM_addStyle(".sceditor-container iframe, .sceditor-container textarea { background: " + BackgroundColorGroup3 + "; }"); // RawContent
	GM_addStyle(".sceditor-button:hover, .sceditor-button:active, .sceditor-button.active { background: " + BackgroundColorGroup4 + "; }"); // Tools hover
	GM_addStyle("div.sceditor-dropdown { background: " + BackgroundColorGroup2 + "; }"); // Dropdown lists
	GM_addStyle("div.sceditor-dropdown .button { background: " + BackgroundColorGroup3 + "; }"); // Dropdown Buttons
	GM_addStyle("blockquote { background: " + BackgroundColorGroup3 + "; }"); // Quote
	
	// FAQ Animation
	GM_addStyle(".file-help { background: " + BackgroundColorGroup6 + "; }");
	
	// Download Comments
	GM_addStyle(".file-comments .header { background: " + BackgroundColorGroup2 + "; }");
	
	// Not Approved Downloads
	GM_addStyle(".category-file-list .notapproved { background: " + BackgroundColorGroup6 + "; }");
	
	// Login Box
	GM_addStyle(".header-login-box form { background: " + BackgroundColorGroup2 + "; }");
	
	// Image Zoom Box
	GM_addStyle("#lightbox-container-image-box { background: " + BackgroundColorGroup1 + "; }");
	GM_addStyle("#lightbox-container-image-data-box { background: " + BackgroundColorGroup1 + "; }");
	
	// Icons
	GM_addStyle(".file-category-list li a { background: url('" + CategoryMarker + "') no-repeat scroll 0 7px rgba(0, 0, 0, 0); }"); // hack categories marker
	GM_addStyle(".file-screenshot-main .box .zoom { background: url('" + ZoomImage + "') no-repeat scroll 0 0 rgba(0, 0, 0, 0); }"); // Screenshot zoom
	GM_addStyle(".portal-recent-file .banner { background: url('" + NewBanner + "') no-repeat scroll 0 0 rgba(0, 0, 0, 0); }"); // NEW banner on new hacks
	
	// Error Message
	GM_addStyle(".error { background: " + BackgroundColorGroup6 + "; }");
	
	// Notifications
	GM_addStyle(".notification div { background: " + BackgroundColorGroup6 + "; }");
}

function ReplaceLinesAndFonts()
{
	// Header Bar Borders
	GM_addStyle(".special > .header { border: 1px solid " + LineColorGroup1 + "!important; }");
	
	// Nav Bar Divisors:
	GM_addStyle(".header-menu ul li a { border-right: 1px solid " + LineColorGroup2 + "!important; }");
	GM_addStyle(".header-menu ul { border-left: 1px solid " + LineColorGroup2 + "!important; }"); // leftmost
	
	// Most Outside Borders
	GM_addStyle(".box > .content { border-color: -moz-use-text-color " + LineColorGroup1 + " " + LineColorGroup1 + "!important; }");
	
	// News Border
	GM_addStyle(".forum-news { border: 1px solid " + LineColorGroup1 + "!important; }");
	GM_addStyle(".forum-news tr.content > td { border-right: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle(".forum-news tr.content { border-bottom: 1px solid " + LineColorGroup1 + "!important; }");
	
	// Footer Border
	GM_addStyle(".page-footer { border-top: 1px solid " + LineColorGroup1 + "!important; }");
	
	// Sections Border
	GM_addStyle(".forums { border: 1px solid " + LineColorGroup1 + "!important; }");
	
	// Popup Borders
	GM_addStyle(".ui-widget-content { border: 1px solid " + LineColorGroup1 + "!important; }"); // content
	GM_addStyle(".ui-widget-header { border: 1px solid " + LineColorGroup1 + "!important; }"); // header
	GM_addStyle(".ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default { border: 1px solid " + LineColorGroup1 + "!important; }"); // buttons
	
	// Shoutbox Input
	GM_addStyle("input, select, textarea { border: 1px solid " + LineColorGroup1 + "!important; }");
	
	// Fields
	GM_addStyle("fieldset { border: 1px solid " + LineColorGroup1 + "!important; }");
	GM_addStyle("legend { border: 1px solid " + LineColorGroup1 + "!important; }");
	
	// Donation Box
	GM_addStyle(".donation-box { border: 1px solid " + LineColorGroup1 + "!important; }");
	
	// List Boxes
	GM_addStyle(".file-recent-list li { border-right: 1px solid " + LineColorGroup1 + "; }"); // Downloads
	GM_addStyle(".box-navigation li { border-top: 1px solid " + LineColorGroup1 + "; }"); // FAQ
	
	// Topics
	GM_addStyle(".topics { border: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle(".topics tr:last-child { border-bottom: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle(".topics tr td { border-left: 1px solid " + LineColorGroup1 + "; border-right: 1px solid " + LineColorGroup1 + ";}");
	GM_addStyle(".topics .content > tr td { border-top: 1px solid " + LineColorGroup1 + "; }");
	
	// ThreadPosts
	GM_addStyle(".thread-post { border: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle(".thread-post tr td { border-left: 1px solid " + LineColorGroup1 + "; border-right: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle(".thread-post tr.footer > td { border-top: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle(".thread-post tr.reputation > td { border-top: 1px solid " + LineColorGroup1 + "; }");
	
	// Forum diverse
	GM_addStyle(".forum-moderate { border: 1px solid " + LineColorGroup1 + "; }");
	
	// Quote Spoilers
	GM_addStyle(".bb-quote, .bb-spoiler { border: 1px solid " + LineColorGroup1 + "; }");
	
	// UCP
	GM_addStyle(".three-panel { border: 1px solid " + LineColorGroup1 + "; }");
	
	// Editor
	GM_addStyle(".sceditor-container { border: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle("div.sceditor-toolbar { border-bottom: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle("div.sceditor-group { border-bottom: none; }");
	GM_addStyle("div.sceditor-dropdown { border: 1px solid " + LineColorGroup1 + "; }");
	
	// Login Box
	GM_addStyle(".header-login-box { border: 1px solid " + LineColorGroup1 + "; }");
	
	// Download Comments
	GM_addStyle(".file-comments .content td:first-child { border-right: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle(".file-comments .action td:first-child { border-right: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle(".file-comments .action td { border-top: 1px solid " + LineColorGroup1 + "; }");
	
	// Recent hacks
	GM_addStyle(".portal-recent-files li { border: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle(".portal-recent-files li:hover { border: 1px solid " + LineColorGroup1 + "; }");
	
	// News user info icon border
	GM_addStyle(".portal-news .user-info { border-bottom: 1px solid " + LineColorGroup1 + "; border-left: 1px dotted " + LineColorGroup1 + "; }");
	
	// Post Preview
	GM_addStyle(".search-preview { border: 1px solid " + LineColorGroup1 + "; }");
	
	// Hack Div
	GM_addStyle(".category-file-list div div { border-bottom: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle(".category-file-list { border: 1px solid " + LineColorGroup1 + "; }");
	
	// Hack Screenshot
	GM_addStyle(".file-screenshot-main .box { border: 1px solid " + LineColorGroup1 + "; }");
	GM_addStyle(".file-screenshot { border: 1px solid " + LineColorGroup1 + "; }");
	
	// Hack Name Underline
	GM_addStyle(".file-information .name { border-bottom: 1px solid " + LineColorGroup1 + "; }");
	
	// Forum theme divisors
	GM_addStyle(".forums tr.content td { border-top: 1px solid " + LineColorGroup1 + "; }");
	
	// Error Border
	GM_addStyle(".error { border: 1px solid " + LineColorGroup1 + "; }");
	
	// Notifications
	GM_addStyle(".notification div { border-color: " + LineColorGroup1 + "  -moz-use-text-color; }");
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
    // LinkText etc.
	GM_addStyle("a { color: " + TextColorGroup1 + "!important; }");
	
	// FieldText - ThreadTags, timetags, etc.
	GM_addStyle("p { color: " + TextColorGroup3 + "!important; }");
	
	// Other Text
	GM_addStyle("body { color: " + TextColorGroup2 + "!important; }");
	
	// News Header Text
	GM_addStyle(".forum-news tr.header { color: " + TextColorGroup1 + "!important; }");
	
	// Box Header Text
	GM_addStyle(".box > .header { color: " + TextColorGroup1 + "!important; }");
	
	// Big Text (Forumbar, etc.)
	GM_addStyle(".special > .header { color: " + TextColorGroup1 + "!important; }");
	
	// Copyright Text
	GM_addStyle(".page-footer .copyright { color: " + TextColorGroup2 + "!important; }");
	
	// Search Bar Text
	GM_addStyle(".header-search .input { color: " + TextColorGroup1 + "!important; }");
	
	// Button Text (Search button, etc.)
	GM_addStyle(".flatbutton, .flatbutton-small { color: " + TextColorGroup1 + "!important; }");
	
	// Popups (Smileys etc.)
	GM_addStyle(".ui-widget-header { color: " + TextColorGroup1 + "!important; }"); // Header
	GM_addStyle(".ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default { color: " + TextColorGroup1 + "!important; }"); // Button
	
	// Inputs (Spenden betrag, etc.)
	GM_addStyle("input, select, textarea { color: " + TextColorGroup1 + "!important; }");
	
	// Fields
	GM_addStyle("fieldset { color: " + TextColorGroup1 + "!important; }");
	GM_addStyle("legend { color: " + TextColorGroup1 + "!important; }");
	
	// navigation (pages, etc.)
	GM_addStyle(".navbar a, .navbar b { color: " + TextColorGroup1 + "!important; }");
	
	// Posts (Date, etc.)
	GM_addStyle(".thread-post tr.header { color: " + TextColorGroup3 + "!important; }");
	
	// File Comments (Date, etc.)
	GM_addStyle(".file-comments .header { color: " + TextColorGroup3 + "!important; }");
	
	// FAQ Download Help
	GM_addStyle(".file-help { color: " + TextColorGroup4 + "!important; }");
	
	// Error Message
	GM_addStyle(".error { color: " + TextColorGroup1 + "!important; }");
}


function ReplacePictures()
{
	// Favicon
	var head = document.getElementsByTagName('head')[0];
	var icon = document.createElement('link');

	icon.setAttribute('type', 'image/x-icon');
	icon.setAttribute('rel', 'shortcut icon');

	icon.setAttribute('href', FavIcon);

	head.appendChild(icon);
	
	// Misc Pictures
    var Images = document.getElementsByTagName ("img");
    var i = 0;
	while(i < Images.length)
	{
		if(Images[i].src == "https://www.oldschoolhack.me/images/header.png") // Top Header
		{
			Images[i].src = Banner;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/header_xmas.png") // Top Christmas header
		{
				Images[i].src = ChristmasBanner;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/icons/german.gif") // Language Flag
		{
			Images[i].src = GermanFlag;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/logo.png" || Images[i].src == "https://www.oldschoolhack.me/forumdata/avatar/3.png")  // Knacki icon
		{
			Images[i].src = OshIcon;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/forumdata/avatar/mini/3.png")  // Knacki icon small
		{
			Images[i].src = OshIconSmall;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/report.gif") // report button
		{
			Images[i].src = ReportButton;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/vote_up.gif") // Upvote
		{
			Images[i].src = Upvote;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/vote_down.gif") // Downvote
		{
			Images[i].src = Downvote;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/hackdata/screenshot/thumb/notavailable.jpg") // hack no screenshot
		{
			Images[i].src = DefaultHackScreenshot;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/forumdata/avatar/noavatar.jpg") // no avatar icon
		{
			Images[i].src = DefaultAvatarIcon;
		}
		if (Images[i].src == "https://www.oldschoolhack.me/forumdata/avatar/mini/noavatar.jpg") // no avatar small
		{
			Images[i].src = DefaultAvatarSmall;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/topic_hot.gif") // topic icon
		{
			Images[i].src = TopicHot;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/topic_moved.gif") // topic icon
		{
			Images[i].src = TopicMoved;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/topic_hot_lock.gif") // topic icon
		{
			Images[i].src = TopicLocked;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/topic_dot_hot.gif") // topic icon
		{
			Images[i].src = TopicDotHot;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/topic_dot_hot_new.gif") // topic icon
		{
			Images[i].src = TopicDotHotNew;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/topic_hot_new.gif") // topic icon
		{
			Images[i].src = TopicHotNew;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/local.png") // download/upload icon
		{
			Images[i].src = UploadSourceA;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/remote.png") // download/upload icon
		{
			Images[i].src = UploadSourceB;
		}
		if(Images[i].src == "https://www.oldschoolhack.me/images/loading.gif") // Post loading
		{
			Images[i].src = Loading;
		}

		i++;
	}
}

function OshRetroCleaner()
{
    ReplaceBackgrounds();
    ReplaceLinesAndFonts();
    ReplacePictures();
}

OshRetroCleaner();