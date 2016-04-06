// ==UserScript==
// @name        Anti-AdBlock KingMaker.news
// @namespace   https://xmine128.tk/gm/
// @include     *://*.kingmaker.news/*
// @include     *://kingmaker.news/*
// @version     0.1.0
// @grant       unsafeWindow
// ==/UserScript==
document.addEventListener("DOMContentLoaded", function() {
	unsafeWindow.google_jobrunner = true;
});