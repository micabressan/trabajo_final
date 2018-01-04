//////////////////////////
//		getScroll
//////////////////////////
var pageScroll;

function getScroll() {
	pageScroll = window.pageYOffset || document.documentElement.scrollTop;
	// console.log(pageScroll);
};
getScroll();
//////////////////////////
//		showLogo
//////////////////////////
var logo = document.getElementById('logoBox');
var nav = document.getElementById('nav');

function showLogo() {
	if (pageScroll >= 200) {
		logo.classList.remove('art-nav__logo_hidden');
		nav.classList.remove('art-nav_opacity');
	} else {
		logo.classList.add('art-nav__logo_hidden');
		nav.classList.add('art-nav_opacity');
	}
};
showLogo();
//////////////////////////
//		openMenu
//////////////////////////
var menuBtn = document.getElementById('menuBtn');
var menuLabel = document.querySelector('.art-nav__checkbox-label');
var menu = document.getElementById('menu');

menuBtn.addEventListener('click', menuCloseAfterClick);

function menuCloseAfterClick() {
	var pageWidth = document.documentElement.clientWidth;

	if (pageWidth < 768) {
		if (menuBtn.getAttribute('checked') == '') {
			menuBtn.removeAttribute('checked');
			menuLabel.classList.remove('art-nav__checkbox-label_open');
			menu.classList.remove('art-nav__menu_open');
		} else {
			menuBtn.setAttribute('checked', '');
			menuLabel.classList.add('art-nav__checkbox-label_open');
			menu.classList.add('art-nav__menu_open');

		}
	} else {
		menuBtn.removeAttribute('checked');
		menuLabel.classList.remove('art-nav__checkbox-label_open');
		menu.classList.remove('art-nav__menu_open');
	}	
};
//////////////////////////
//		EasyScroll
//////////////////////////

function eazyScroll(el) {
	var sectionsCollection = document.querySelectorAll('.js-section');
	var linkCollection = document.querySelectorAll('.js-link');

	if (el && el == true) {
		if (window.addEventListener) {
			if ('onwheel' in document) {
				// IE9+, FF17+, Ch31+
				window.addEventListener("wheel", sectionScroll);
			} else if ('onmousewheel' in document) {
				// ÑƒÑÑ‚Ð°Ñ€ÐµÐ²ÑˆÐ¸Ð¹ Ð²Ð°Ñ€Ð¸Ð°Ð½Ñ‚ ÑÐ¾Ð±Ñ‹Ñ‚Ð¸Ñ
				window.addEventListener("mousewheel", sectionScroll);
			} else {
				// Firefox < 17
				window.addEventListener("MozMousePixelScroll", sectionScroll);
			}
		} else { 
			// IE8-
			window.attachEvent("onmousewheel", sectionScroll);
		}
	}

	for (var i = 0; i < linkCollection.length; i++) {
		linkCollection[i].addEventListener('click', linkScroll);
	}

	linkActiveToScroll();
	window.addEventListener('scroll', linkActiveToScroll);
	

	function scrollTimer(direction) {
		if (!el) {
			window.removeEventListener('scroll', linkActiveToScroll);
		}
				
		var count = 0;
		var timer = setInterval(function() {
					
			if (count < 10) {
				window.scrollBy(0,direction);
				count++;
				
			} else {
				clearInterval(timer);
				if (!el) {
					window.addEventListener('scroll', linkActiveToScroll);
				}
			}
		}, 50);
	};
	function linkActiveToScroll() {

		for (var i = 0; i < sectionsCollection.length; i++) {
			var compare = sectionsCollection[i].offsetTop - pageScroll;

			if (compare < 400 && compare >= 0) {
				var linkTarget = sectionsCollection[i].id;

				for (var i = 0; i < linkCollection.length; i++) {
					if (linkCollection[i].classList.contains('art-menu__link_active')) {
						linkCollection[i].classList.remove('art-menu__link_active');
					}
				}
				for (var i = 0; i < linkCollection.length; i++) {
					if (linkCollection[i].getAttribute('data-target') == linkTarget) {
						linkCollection[i].classList.add('art-menu__link_active');
					}
				}
			}			
		}
	};
	function linkScroll(event) {
		var link = this.getAttribute('data-target');
		var linkSection = document.getElementById(link);
		var pageWidth = document.documentElement.clientWidth;
		var	linkSectionPosition;
		var linkLength;
		var scrollPage;
		
		for (var i = 0; i < linkCollection.length; i++) {
			if (linkCollection[i].classList.contains('art-menu__link_active')) {
				linkCollection[i].classList.remove('art-menu__link_active');
			}
		}

		this.classList.add('art-menu__link_active');
		linkSectionPosition = linkSection.offsetTop;
		linkLength = linkSectionPosition - pageScroll;
		scrollPage = linkLength/10;

		menuCloseAfterClick();
		scrollTimer(scrollPage);

		event.preventDefault();
	};
	function sectionScroll(e) {
		var e = e || window.event;
		var delta = e.deltaY || e.detail || e.wheelDelta;
		var sectionHeight = sectionsCollection[0].clientHeight;
				
		var pageScroll = sectionHeight/10;

		if (delta > 0) {
			scrollTimer(pageScroll);
		} else {
			scrollTimer(-pageScroll);
		}

		event.preventDefault();
	};
};
eazyScroll();
//////////////////////////
//		modal
//////////////////////////
var body = document.querySelector('body');
var modalLinksCollection = document.querySelectorAll('.js-modal');
var modalsCollection = document.querySelectorAll('.modal');

function modal() {
	for (var i = 0; i < modalLinksCollection.length; i++) {
		modalLinksCollection[i].addEventListener('click', showModal);
	}

	function showModal(e) {
		var target = this.getAttribute('href');
		target = target.slice(1);
		event.preventDefault();
		console.log(target);
		for (var i = 0; i < modalsCollection.length; i++) {
			if (modalsCollection[i].id == target) {
				body.style.overflow = 'hidden';
				modalsCollection[i].classList.add('modal_show');
				modalsCollection[i].querySelector('.modal__btn-close').addEventListener('click', function() {
					this.parentElement.parentElement.parentElement.classList.remove('modal_show');
					body.style.overflow = '';
				});
			}
		}
	};
}
modal();
//////////////////////////
//		formValidator
//////////////////////////
function formValidator() {
	var form = document.getElementById('main-form');
	var namePattern = /^[Ð°-ÑÐ-Ð¯Ñ‘Ða-zA-Z]{2,}$/; 
	var phonePattern = /^(\s*)?(\+)?([- _():=+]?\d[- _():=+]?){10,12}(\s*)?$/;
	var countSuccess;
	var inputCounter;

	if (form) {
		var button 			= form.querySelector('button');
		var inputCollection = form.querySelectorAll('.order__input');
		var checkbox 		= form.querySelector('.order__checkbox');

		checkbox.addEventListener('click', buttonDisabled);
		button.addEventListener('click', validateInputValue);
		form.addEventListener('submit', formAjaxRequest);
	}
	function buttonDisabled() {
		if (this.getAttribute('checked') == '') {
			this.removeAttribute('checked')
			button.setAttribute('disabled', '');
		} else if (!this.getAttribute('checked')) {
			this.setAttribute('checked', '')
			button.removeAttribute('disabled');
		}
	};
	function validateInputValue() {
		countSuccess = 0;
		inputCounter = 0;

		for (var i = 0; i < inputCollection.length; i++) {
			inputCounter++;

			if (inputCollection[i].value == '') {
				showErrorMessage(inputCollection[i]);
			} else {
				switch(inputCollection[i].name) {
					case 'name' : 
						if(namePattern.test(inputCollection[i].value) == true)	{
							countSuccess++;
						} else {
							showErrorMessage(inputCollection[i]);
						}
					break
					case 'phone' : 
						if (phonePattern.test(inputCollection[i].value) == true) {
							countSuccess++;
						} else {
							showErrorMessage(inputCollection[i]);
						}
					break
					default : 
						console.log(inputCollection[i].name);
						console.log(inputCollection[i].value);
					break
				}
			}
		}	
	};
	function formAjaxRequest() {
		if (inputCounter == countSuccess) {
			// console.log('ok');
			var requestBody = new FormData(form);
			var xhr = new XMLHttpRequest();

			xhr.open("POST", "/artsend.php");
			xhr.onreadystatechange = function() {
				if (xhr.readyState != 4) {
					console.log('in process' + ' ' + xhr.readyState);
				} else {
					if (xhr.status != 200) {
						console.log('error');
						console.log(xhr.readyState + ':' + xhr.status + ':' + xhr.statusText);
					} else {
						console.log(xhr.responseText + ' ' + xhr.statusText);
						showAjaxAnswer(xhr.responseText);		
					}
				}
			};
		
			xhr.send(requestBody);
		}
		event.preventDefault();

		function showAjaxAnswer(answerText) {
			if (answerText == 'ok') {
				
				var massegeSuccess = document.querySelector('.order__message-box');

				form.style.display = 'none';
				massegeSuccess.style.display = 'block';
			} else if (answerText == 'home-form') {
				console.log('input type=hidden not find or attr name undefined');
			} else {
				for (var i = 0; i < inputCollection.length; i++) {
					if (inputCollection[i].name == answerText) {
						showErrorMessage(inputCollection[i]);
					}
				}
			}	
		};
	};
	function showErrorMessage(inp) {
		if (inp.getAttribute('data-error')) {
			var errorValue = inp.getAttribute('data-error');

			inp.nextElementSibling.innerHTML = errorValue;
			inp.nextElementSibling.style.visibility = 'visible';
			inp.addEventListener('focus', clearErrorMessage);
		}	
	};
	function clearErrorMessage() {
		this.nextElementSibling.innerHTML = '';
		this.nextElementSibling.style.visibility = 'hidden';
	};
};
formValidator();
//////////////////////////
//		pageScrollEvent
//////////////////////////
window.addEventListener('scroll', function() {
	getScroll();
	showLogo();
});