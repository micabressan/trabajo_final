// ==UserScript==
// @name        Anti-AdBlock Hackintosh.zone
// @namespace   https://xmine128.tk/gm/
// @include     *://*.hackintosh.zone/*
// @include     *://hackintosh.zone/*
// @version     0.1.0
// @run-at      document-start
// @grant       unsafeWindow
// ==/UserScript==

document.addEventListener("DOMContentLoaded", function()
{
	var head = document.getElementsByTagName("head")[0];
	
	// Fake Google ad frame content
	var ad1 = document.createElement("ins");
	ad1.className = "adsbygoogle";
	ad1.appendChild(document.createTextNode("AAK"));
	head.insertBefore(ad1, head.childNodes[0]);
	
	// Fake CleanMyMac ad frame size
	var ad2 = document.createElement("div");
	ad2.id  = "cleanmymac";
	Object.defineProperty(ad2.wrappedJSObject, 'clientHeight', {value: 1});
	head.insertBefore(ad2, head.childNodes[0]);
});