// ==UserScript==
// @name         twitterbg
// @namespace    eh
// @description  change twitter's new background
// @include      https://twitter.com/*
// @grant        none
// @version      1.0
// ==/UserScript==

function addGlobalStyle(css) {
    var head, style;
    head = document.getElementsByTagName('head')[0];
    if (!head) { return; }
    style = document.createElement('style');
    style.type = 'text/css';
    style.innerHTML = css;
    head.appendChild(style);
}

// RU:
// замени YOURTWITTERNAME на свой url из твиттера
// замени IMAGELINK на ссылку на картинку типа http://site.com/image.jpg
// чтобы найти ссылку на ранее установленный фон см. инструкцию на картинке http://i.imgur.com/zijbWNL.png

//EN:
// replace YOURTWITTERNAME with your twitter handle
// replace IMAGELINK with the link to your image, e.g http://site.com/image.jpg
// to find the url of existing (maybe previously set) twitter background see instruction http://i.imgur.com/zijbWNL.png

addGlobalStyle('body.user-style-YOURTWITTERNAME { background-image: url( IMAGELINK ) !important; background-size: cover; background-repeat: no-repeat;  background-attachment: fixed; background-color: #eeeeee  !important;} .ProfileSidebar--withLeftAlignment {background-color: #fff; border: 1px solid #e1e8ed; border-radius: 5px; margin-top: 37px; margin-left: -1px;} .ProfileHeaderCard {margin-top: 0px ; padding-top: 10px;}')