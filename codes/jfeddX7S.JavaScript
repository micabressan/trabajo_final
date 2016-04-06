// ==UserScript==
// @name        Anti-AdBlock BinBucks.com
// @namespace   https://xmine128.tk/gm/
// @include     *://binbucks.com/*
// @version     0.1.0
// @grant       unsafeWindow
// ==/UserScript==
document.addEventListener("DOMContentLoaded", function()
{
	unsafeWindow.testJuicyPay = true;
	unsafeWindow.testSensePay = true;
});