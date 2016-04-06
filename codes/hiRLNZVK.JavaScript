// ==UserScript==
// @name 1chan Ultimate Extension Tool
// @author 1anon, nanodesu, postman, ayakudere, theanonym
// @version inach.org
// @description For some info, updates and stuff please proidite nahui
// @icon http://1chan.inach.org/ico/favicons/1chan.inach.org.gif
// @require http://github.com/andris9/jStorage/raw/master/jstorage.js
// @include       http://1chan.inach.org/*
// @include       https://1chan.inach.org/*
// @include       http://*.1chan.inach.org/*
// @include       https://*.1chan.inach.org/*
// @grant none
// ==/UserScript==

// TO DO LIST:
// * Массивы подписей в автопостах
// * Автососачер
// * Ботух призывающий к самоубийству



    // Globals
    var formTextarea;
    var deletingSmiles;
    var locationPrefix;
    var hidePatterns;
    var features = ['tools-panel', 'answermap', 'hiding', 'smiles', 'markup', 'spoilers',
                    'show-hidden', 'form-settings', 'panel-hiding', 'markup-top',
                    /*'hide-short-news',*/ 'show-true-face', 'change-title', 'hide-icon'
                   ];
    var descriptions = ['Включить панель инструментов', 'Построение карты ответов', 'Скрытие постов', 'Панель смайлов',
                        'Панель разметки', 'Раскрытие спойлеров', 'Показывать скрытые комментарии',
                        'Настройки рядом с формой', 'Убирать панель по клику',
                        'Разметка над формой', /*'Скрывать новости короче 140 символов',*/ 'Показать сущность постеров',
                        'Изменять имя страницы', 'Скрывать посты по иконке'
                       ];
                       
    var styleCode = ['default'
    //, 'photon', 'neutron', 'futaba',
                     //'burichan', 'gurochan', 'lenta', 'vk'
                    ];
    var styleName = ['Дефолтный', 'Photon', 'Neutron', 'Futaba',
                     'Burichan', 'Gurochan', 'Лента', 'Сосач'
                    ];
    
    var codeIcon = ["sosach", "0chan", "iichan", "cirno", 
                    "obdrochan", "samechan", "tirech", "4chan",
                    "krautchan", "hivemind", "olanet", "1chan",
                    "konfopetuh"
                    ];
    var nameIcon = ["Сосач", "Нульчан", "Ычан", "Сырна", 
                    "Доброчан", "Сеймчан", "Тиретиреч", "Форчан",
                    "Краутчан", "Хайвмайнд", "Оланет", "Одинчан",
                    "Конференции"
                    ];
    
    var enabledFeatures;
    var enabledStyles;
    var enabledIcons;
    var pasteNum = 0;
	var zalgo_up = [
				'\u030d', /*     ?     */		'\u030e', /*     ?     */		'\u0304', /*     ?     */		'\u0305', /*     ?     */
				'\u033f', /*     ?     */		'\u0311', /*     ?     */		'\u0306', /*     ?     */		'\u0310', /*     ?     */
				'\u0352', /*     ?     */		'\u0357', /*     ?     */		'\u0351', /*     ?     */		'\u0307', /*     ?     */
				'\u0308', /*     ?     */		'\u030a', /*     ?     */		'\u0342', /*     ?     */		'\u0343', /*     ?     */
				'\u0344', /*     ?     */		'\u034a', /*     ?     */		'\u034b', /*     ?     */		'\u034c', /*     ?     */
				'\u0303', /*     ?     */		'\u0302', /*     ?     */		'\u030c', /*     ?     */		'\u0350', /*     ?     */
				'\u0300', /*     ?     */		'\u0301', /*     ?     */		'\u030b', /*     ?     */		'\u030f', /*     ?     */
				'\u0312', /*     ?     */		'\u0313', /*     ?     */		'\u0314', /*     ?     */		'\u033d', /*     ?     */
				'\u0309', /*     ?     */		'\u0363', /*     ?     */		'\u0364', /*     ?     */		'\u0365', /*     ?     */
				'\u0366', /*     ?     */		'\u0367', /*     ?     */		'\u0368', /*     ?     */		'\u0369', /*     ?     */
				'\u036a', /*     ?     */		'\u036b', /*     ?     */		'\u036c', /*     ?     */		'\u036d', /*     ?     */
				'\u036e', /*     ?     */		'\u036f', /*     ?     */		'\u033e', /*     ?     */		'\u035b', /*     ?     */
				'\u0346', /*     ?     */		'\u031a' /*     ?     */
			];
	var zalgo_down = [
				'\u0316', /*     ?     */		'\u0317', /*     ?     */		'\u0318', /*     ?     */		'\u0319', /*     ?     */
				'\u031c', /*     ?     */		'\u031d', /*     ?     */		'\u031e', /*     ?     */		'\u031f', /*     ?     */
				'\u0320', /*     ?     */		'\u0324', /*     ?     */		'\u0325', /*     ?     */		'\u0326', /*     ?     */
				'\u0329', /*     ?     */		'\u032a', /*     ?     */		'\u032b', /*     ?     */		'\u032c', /*     ?     */
				'\u032d', /*     ?     */		'\u032e', /*     ?     */		'\u032f', /*     ?     */		'\u0330', /*     ?     */
				'\u0331', /*     ?     */		'\u0332', /*     ?     */		'\u0333', /*     ?     */		'\u0339', /*     ?     */
				'\u033a', /*     ?     */		'\u033b', /*     ?     */		'\u033c', /*     ?     */		'\u0345', /*     ?     */
				'\u0347', /*     ?     */		'\u0348', /*     ?     */		'\u0349', /*     ?     */		'\u034d', /*     ?     */
				'\u034e', /*     ?     */		'\u0353', /*     ?     */		'\u0354', /*     ?     */		'\u0355', /*     ?     */
				'\u0356', /*     ?     */		'\u0359', /*     ?     */		'\u035a', /*     ?     */		'\u0323' /*     ?     */
			];
	var zalgo_mid = [
				'\u0315', /*     ?     */		'\u031b', /*     ?     */		'\u0340', /*     ?     */		'\u0341', /*     ?     */
				'\u0358', /*     ?     */		'\u0321', /*     ?     */		'\u0322', /*     ?     */		'\u0327', /*     ?     */
				'\u0328', /*     ?     */		'\u0334', /*     ?     */		'\u0335', /*     ?     */		'\u0336', /*     ?     */
				'\u034f', /*     ?     */		'\u035c', /*     ?     */		'\u035d', /*     ?     */		'\u035e', /*     ?     */
				'\u035f', /*     ?     */		'\u0360', /*     ?     */		'\u0362', /*     ?     */		'\u0338', /*     ?     */
				'\u0337', /*     ?     */		'\u0361', /*     ?     */		'\u0489' /*     ?_     */		
			];
    var VERSION = '40k';
    // Для вротфильтра
    var simpleSymbol = ''; //'\u202E';
    var brSymbol = ''; //'\r\n\u202E';
    var simpleBr = '\r\n';
    var markupLine = '********************************************';
    
function changeTitle(title) 
        { 
        document.title = title; 
}

function setTitle()
        {
var threadNumber = window.location.pathname.split("/")[3];
var pageName = jQuery(".b-blog-entry_b-header").text();
if (pageName.length > 100) {pageName = pageName.subString(0, 99) + "...";};
var chan = ['Одинчана', 'Колчорга', '| 1chan.inach.org', 'Собакоебача', 'Колчана', 'Персонального бложика Андрея Пионтковского'];
var title = pageName + " - Пост №" + threadNumber + " " + chan[threadNumber % 6];
;
changeTitle(title);
     
}

function resetAll() 
        {
        var str = '';
        localStorage['settings' + VERSION] = str;
        localStorage['styles' + VERSION] = str;
        window.location.reload();
}

function debugScript()
        {
            
			
}

/*
* Paste Adding
*/

function displayPasteAdd() {
        var container = document.createElement("div");
        document.getElementById('add-paste-button').onclick = hidePasteAdd;
        container.setAttribute("style", "top: 5px; left:5px; position:fixed; z-index: 10000; background: #EAF4FF; border: 1px black");
        var list = document.createElement("textarea")
        list.id = "paste-list"
        list.setAttribute("style", "width: 410px; height: 500px; margin:5px")
        for(var pst in localStorage)
            if(/paste/.test(pst))
                list.value += localStorage[pst] + '\n\n'
        var button = document.createElement("button")
        button.textContent = "Обновить"
        button.onclick = updatePastes;
        button.style.margin = "5px"
        var button2 = document.createElement("button")
        button2.textContent = "Отменить"
        button2.onclick =  hidePasteAdd;
        button2.style.margin = "5px"
        var button3 = document.createElement("button")
        button3.textContent = "Очистить"
        button3.onclick =  clearPastes;
        button3.style.margin = "5px"
        var desc = document.createTextNode("Разделять пасты через пустую строку");
        container.appendChild(desc);
        container.appendChild(document.createElement('br'));
        container.appendChild(list)
        container.appendChild(document.createElement("br"))
        container.appendChild(button)
        container.appendChild(button2)
        container.appendChild(button3)
        document.getElementsByTagName("body")[0].appendChild(container)
        return false;
    }
 
    
    
    function hidePasteAdd() {
        var menu = document.getElementById('paste-list').parentNode;
        menu.parentNode.removeChild(menu);
        document.getElementById('add-paste-button').onclick = displayPasteAdd;
        return false;
    }
    
    function updatePastes() {
        document.getElementById('add-paste-button').onclick = displayPasteAdd;
        for(var pst in localStorage)
            if(/paste/.test(pst))
                localStorage.removeItem(pst);
        var textF = document.getElementById('paste-list');
        var textStr = textF.value;
        if (textStr == '') {localStorage.setItem("pstNumber", 1);} else {
        textStr = textStr.substring(textStr.length-2, textStr.length);
        if (textStr !== '\n\n') textF.value += '\n\n';
        pastes = document.getElementById('paste-list').value.split('\n\n');
        for(var i = 0; i < pastes.length; i++) {
            if(pastes[i] != "") {
                localStorage.setItem("paste-" + i, pastes[i]);
            }
        }
        //var test = localStorage.getItem('pstNumber') - 1;
        //if (pasteNum == test) pasteNum = test - 1;
        localStorage.setItem("pstNumber", pastes.length);
        }
        menu = document.getElementById('paste-list').parentNode;
        menu.parentNode.removeChild(menu);
        window.location.reload();
    }
    
    function clearPastes() {
        document.getElementById('add-paste-button').onclick = displayPasteAdd;
        for(var pst in localStorage)
            if(/paste/.test(pst))
                localStorage.removeItem(pst);
        localStorage.setItem("pstNumber", 0);
        menu = document.getElementById('paste-list').parentNode;
        menu.parentNode.removeChild(menu);
        window.location.reload()
    }




function tools40() {

  jQuery((new (function(){
        var self = this;
        var wordsAfterComma = [
            "а",
            "но",
            "который",
            "которая",
            "которые",
            "которое"
        ];
        // чот эта хуита то и дело ломается, мацать аккуратно
        this.init = function(){
            var jQTool = ".b-blog-entry";
            //jQuery(jQTool).append("<br><font color=#0066FF><b>Самые важные кнопки&trade;</b></font><br>");
            var containerUpButtons = document.createElement("div");
            //containerUpButtons.id = 'buttons-ex';
            //jQuery(jQTool).append(containerUpButtons);
            //self.createButton("Пеар параши", self.pearParashee);
            //self.createButton("Бороться с аниме", self.animeFight);
            //self.createButton("Бороться с шизоидом", self.sheezFight);
            //self.createButton("Покакать", self.prr);
            //self.createButton("Разобрать написанное", self.deAssembling);
            //jQuery(jQTool).append("</div>");
            //jQuery(jQTool).append("<hr>");
            /*jQuery(jQTool).append("<br><font color=#0066FF><b>Стандартные ответы</b></font><br>");
            self.createButton("Узнать, хули они тут читают", self.askAboutReading);
			self.createButton("Узнать, хули они тут пишут", self.askAboutWriting);
            self.createButton("Пеар параши", self.pearParashee);
            jQuery(jQTool).append("<br><font color=#0066FF><b>Моя борьба</b></font><br>");
            self.createButton("Бороться с аниме", self.animeFight);
            self.createButton("Бороться с шизоидом", self.sheezFight);
            self.createButton("Бороться с гниданусом", self.gneedsFight);
            jQuery(jQTool).append("<br><font color=#0066FF><b>Естественные нужды организма</b></font><br>");
            self.createButton("Пописать", self.piss);
            self.createButton("Покакать", self.prr);
            jQuery(jQTool).append("<br><font color=#0066FF><b>Вайп</b></font><br>");
            self.createButton("Вайп кашей текста", self.startWipeRand);
            self.createButton("Вайп кашей слов", self.startWipeWord);
            self.createButton("Вайп кашей смайлов", self.startWipeSmile);
            jQuery(jQTool).append("<br><font color=#0066FF><b>Инструменты</b></font><br>");
			jQuery(jQTool).append("");
            autoKolchanButton = self.createButton("Автоколчанька", self.sendAutoMessage);
			self.createButton("Автостульчак", self.autoCoproReply);
			self.createButton("Автоответчик", self.autoPidornuhaReply);
			jQuery(jQTool).append("<br><font color=#0066FF><b>Каштомные кнопки</b></font><br>");
			//self.createButton("title", setTitle);
			self.createButton("Разобрать написанное", self.deAssembling);
			autoWaitingButtonClass = self.createButton("Автождалка", self.autoWaitingSwitcher); // Новая фича - createButton теперь ретурнит класс созданной кнопки	
			*/
			
			if(window.location.pathname != "/news/add/") {
			    displayWipeButtonInit();
			}
			initSignatureOptions();
			self.setSkipBoxes();
			/*
			if(enabledFeatures.indexOf("botuh-buttons")!= -1) {
			    self.createButtonDown("Автоответчик", self.autoPidornuhaReply);
			    self.createButtonDown("Автостульчак", self.autoCoproReply);			    
			    self.createButtonDown("Автоколчанька", self.sendAutoMessage);
			}
			*/
			createMenu();
			
			
			
        };
        // Каштомные функции пишем прямо под каментом
        
        
        this.deAssembling = function(){
            var deassPasta = "Ну давай разберем по частям, тобою написанное )) Складывается впечатление что ты реально контуженный , обиженный жизнью имбицил )) Могу тебе и в глаза сказать, готов приехать послушать?) Вся та хуйня тобою написанное это простое пиздабольство , рембо ты комнатный)) от того что ты много написал, жизнь твоя лучше не станет)) пиздеть не мешки ворочить, много вас таких по весне оттаяло )) Про таких как ты говорят: Мама не хотела, папа не старался) Вникай в моё послание тебе< постарайся проанализировать и сделать выводы для себя) ";
            var threadNumber = window.location.pathname.split("/")[3];
            var reply = ">>" + threadNumber + "\r\n" + deassPasta;
			self.sendMessageToThread(reply);
        };
        
        
        
        
        this.autoPidornuhaReply = function(){
            var threadNumber = window.location.pathname.split("/")[3];
            var commentNumbers = jQuery(".b-comment_b-info a[name]");
            var pidornuhaPaste = pidornuha.split("----------");
	    var reply = ">>" + (commentNumbers.length>0?commentNumbers.last().text():threadNumber) + "\r\n" + self.getRandomElement(pidornuhaPaste);
	    self.sendMessageToThread(reply);
        };
        
        function displayWipeButtonInit() {
            var container = document.createElement("div");
    	    container.id = 'verybutton'
            container.setAttribute("style", 'bottom: 6px; left:6px; position:fixed; z-index: 10000; background: transparent; padding: 5px');
            btnwipe = document.createElement("button");
            btnwipe.textContent = "1CH";
            btnwipe.id = 'yapetooh';
            btnwipe.href = "#";
            btnwipe.onclick = displayWipePanel;
	    container.appendChild(btnwipe);            
            document.getElementsByTagName("body")[0].appendChild(container);
            // wow so kukloscript
            }
        
        function displayWipePanel() {
    	    var container = document.createElement("div");
    	    //document.getElementsByClassName(wipeButtonClass).onclick = hideWipePanel;
    	    //console.log(document.getElementsByClassName(wipeButtonClass));
    	    container.id = 'wipepanel'
    	    container.setAttribute("style", 'bottom: 5px; left:5px; position:fixed; z-index: 10000; background: #EAF4FF; padding: 5px; border: 1px solid rgb(187, 187, 187); border-radius: 8px 8px 8px 8px;');
	    // ===================
	    btnKolch = document.createElement("button");
            btnKolch.textContent = "Колчанька";
       	    btnKolch.href = "#";
            btnKolch.onclick = self.sendAutoMessage;
            // ===================
            btnChair = document.createElement("button"); // >btnChair >Chair 
            btnChair.textContent = "Стульчак"; // Почему chair-то.
       	    btnChair.href = "#";
            btnChair.onclick = self.autoCoproReply; 
            // ===================
            btnPidor = document.createElement("button");
            btnPidor.textContent = ">Пидорнуха";
       	    btnPidor.href = "#";
            btnPidor.onclick = self.autoPidornuhaReply; 
            // ===================   
            btnWipeT = document.createElement("button");
            btnWipeT.textContent = "Текст";
       	    btnWipeT.href = "#";
            btnWipeT.onclick = self.startWipeRand; 
            // ===================
            btnWipeW = document.createElement("button");
            btnWipeW.textContent = "Слова";
       	    btnWipeW.href = "#";
            btnWipeW.onclick = self.startWipeWord;  
            // ===================
            btnWipeS = document.createElement("button");
            btnWipeS.textContent = "Смайлы";
       	    btnWipeS.href = "#";
            btnWipeS.onclick = self.startWipeSmile;   
            // ===================
            btnPssss = document.createElement("button");
            btnPssss.textContent = "ПССС";
       	    btnPssss.href = "#";
            btnPssss.onclick = self.piss;  
            // ===================
            btnPrrrr = document.createElement("button");
            btnPrrrr.textContent = "ПРРР";
       	    btnPrrrr.href = "#";
            btnPrrrr.onclick = self.prr;   
            // ===================
            btnFWzAn = document.createElement("button");
            btnFWzAn.textContent = "С аниме";
       	    btnFWzAn.href = "#";
            btnFWzAn.onclick = self.animeFight;   
            // ===================
            btnFWzSh = document.createElement("button");
            btnFWzSh.textContent = "С шизиком";
       	    btnFWzSh.href = "#";
            btnFWzSh.onclick = self.sheezFight;     
            // ===================
            btnFWzGn = document.createElement("button");
            btnFWzGn.textContent = "С гниданусом";
       	    btnFWzGn.href = "#";
            btnFWzGn.onclick = self.gneedsFight;     
            // ===================
            btnHuleR = document.createElement("button");
            btnHuleR.textContent = "Читаете";
       	    btnHuleR.href = "#";
            btnHuleR.onclick = self.askAboutReading; 
            // ===================
            btnHuleW = document.createElement("button");
            btnHuleW.textContent = "Пишете";
       	    btnHuleW.href = "#";
            btnHuleW.onclick = self.askAboutWriting;     
            // ===================
            btnHuleP = document.createElement("button");
            btnHuleP.textContent = "Пиарите";
       	    btnHuleP.href = "#";
            btnHuleP.onclick = self.pearParashee;
            // ===================
            btnDebugTest = document.createElement("button");
            btnDebugTest.textContent = "ДЕБАГ";
       	    btnDebugTest.href = "#";
            btnDebugTest.onclick = autoSenderMessagesBegin;                                                                                 
            // ===================                      
            btnHide = document.createElement("button");
            btnHide.textContent = "1CH";
       	    btnHide.href = "#";
            btnHide.onclick = hideWipePanel;
            // ===================
            jQuery(container).append("<font color=#0066FF><b>Хули вы тут</b></abbr></font><br>");
            container.appendChild(btnHuleR);
            container.appendChild(btnHuleW);
            container.appendChild(btnHuleP);
             // ===================
            jQuery(container).append("<br><font color=#0066FF><b>Моя борьба</b></abbr></font><br>");
            container.appendChild(btnFWzAn);
            container.appendChild(btnFWzSh);
            container.appendChild(btnFWzGn);
            // ===================
            jQuery(container).append("<br><font color=#0066FF><b>Нужды</b></abbr></font><br>");
            container.appendChild(btnPssss);
            container.appendChild(btnPrrrr);
            // ===================
            jQuery(container).append("<br><font color=#0066FF><b>Вайп</b></abbr></font><br>");
	    container.appendChild(btnWipeT);
	    container.appendChild(btnWipeW);
	    container.appendChild(btnWipeS);         
	    // ===================   
            jQuery(container).append("<br><font color=#0066FF><b>Ботухи</b></abbr></font><br>");
	    container.appendChild(btnKolch);
	    container.appendChild(btnChair);
	    container.appendChild(btnPidor);
	    // ===================   
            //jQuery(container).append("<br><font color=#0066FF><abbr title='Азазаз.'><b>Другое</b></abbr></font><br>");
	    //container.appendChild(btnDebugTest);
	    // ===================
	    container.appendChild(document.createElement('hr'));
	    container.appendChild(btnHide);
            document.getElementsByTagName("body")[0].appendChild(container);
        };
	
	function hideWipePanel() {
            var waep = document.getElementById('wipepanel');
            waep.parentNode.removeChild(waep);
            //document.getElementsByClassName(wipeButtonClass).onclick = displayWipePanel;
            return false;
        };	
        
        function reverseString(stringToReverse){
            return stringToReverse.split("").reverse().join("");
	}
		
	
        // Дальше некаштомные функции
      this.startWipeRand = function(){
        var rand_elem = function(ar)
            {
                return ar[Math.floor(Math.random()*ar.length)];
            };
        var postId = window.location.pathname.split("/")[3];
        var getNextMessage = function()
        {
         var result, post_numbers = jQuery(".b-comment_b-info a[name]");
         result = "  ";
         if(post_numbers.length == 0) { result = "  "; }
         else { result = ">>" + jQuery(rand_elem(post_numbers)).text(); }
         var lines_n = 1;
         var letters = "абвгдеёжзийклмнопрстуфхцчшщьыъэюя";
         for(var i = 0; i < lines_n; i++)
         {
         result += "\n";
         var letters_n = 1300;
         for(var j = 0; j < letters_n; j++)
         {
         result += letters[Math.round(Math.random() * (letters.length-1))];
         if(Math.random() <= 0.25) { result += " "; }
         }
         }
         return result;
        };
        setInterval(function() {jQuery.post
        (
            "http://1chan.inach.org/news/res/"+ postId +"/add_comment/",
            {
                "post_id": postId, "homeboard": "anonymous", "text": " " + getNextMessage()
            }
        )
                                }, 10);
     }
       
       
        this.startWipeWord = function(){
            var re = function(ar) {return ar[Math.floor(Math.random()*ar.length)];};
            var t = window.location.pathname.split("/")[3];
            var a = function()
                {
                var n = $(".b-comment_b-info a[name]");
                var w = $(".b-comment_b-body").text().split(/\s+/).filter(function(a)
                    {
                    return a.match(/[А-Я]+/);}).map(function(a)
                        {
                        return a.replace(/[\.!?()]/g, "").toLowerCase()});
                        var ic = $(".js-homeboard-select-link");
                        $.post("http://1chan.inach.org/news/res/"+t+"/add_comment/",
                                    {
                                    "post_id": t, "homeboard": $(re(ic)).attr("name"), "text": ">>" + $(re(n)).text() + "\r\n" + "  " + (function()
                                        {
                                        var r = [];
                                        var rand = Math.random()*30;
                                        for (var i=0; i<rand; i++) {r.push(re(w))};
                                        var s = r.join(" :nyan: ");
                                        return s.charAt(0).toUpperCase() + s.substr(1);
                                        ;}
                                        )() + ". " + Math.random()*1337 + ". "
                                    }
                                )
                };
                if(false) { a(); }
                    else {setInterval('a()', 5500)};
        }
        
        this.startWipeSmile = function(){
             var smileList = [ "coolface", "desu", "nyan", "sobak", "trollface", "awesome", "ffuu", "okay", "rage"];
             var mess = "  ";
             var rand = Math.random()*30;
             
             for (var i=0; i<rand; i++)
                     {
                     var elem = Math.floor(Math.random()*8);
                     mess += ":" + smileList[elem] + ":";
                     };
             //setInterval(self.sendMessageToThread(mess), 10);
             self.sendMessageToThread(mess);
            }
        
        this.animeFight = function(){
            var animePaste = anime.split("----------");
            self.sendMessageToThread(self.getRandomElement(animePaste));
        }
       
        this.sheezFight = function(){
            var sheezequePaste = sheez.split("----------");
            self.sendMessageToThread(self.getRandomElement(sheezequePaste));
        }
        
        this.gneedsFight = function(){
            var gneedsPaste = gneeds.split("----------");
            self.sendMessageToThread(self.getRandomElement(gneedsPaste));
        }
       
        this.piss = function(){            
	    var randomArrayPart = self.getRandomElementPrPs(PSSS); 
	    var mocha = PSSS[randomArrayPart];
	    var mochaPrevious = PSSS[randomArrayPart - 1];
	    var mochaNext = PSSS[randomArrayPart + 1];
	    markupFlag = self.checkStringToOurSpecialMarkup(mocha);
	    var counterFor = 0;
	    for (;;) { // Мне так удобнее кококо
		mocha = mocha.replace("\0", ""); 
		mochaPrevious = mochaPrevious.replace("\0", ""); 
		mochaNext = mochaNext.replace("\0", ""); 		
		counterFor = counterFor + 1;
		if(counterFor > 4) break;
	    }	    
	    var reverseMocha = mocha;    
	    console.log(markupFlag + " | " + mocha);
	    if(markupFlag == 'fst') {
	        var reverseMochaNext = reverseString(mochaNext);
	        var textToSend = simpleSymbol + reverseMocha + simpleBr + markupLine + simpleBr + mochaNext + simpleBr + markupLine;
	    }
	    if(markupFlag == 'snd') {
	        var reverseMochaPrev = reverseString(mochaPrevious);
	    	var textToSend = simpleSymbol + reverseMochaPrev + simpleBr + markupLine + simpleBr + mocha + simpleBr + markupLine;
	    }
	    if(markupFlag == 'nrm') {
	    	var textToSend = simpleSymbol + reverseMocha + simpleBr + markupLine;
	    }
	    //console.log(textToSend);
	    self.sendMessageToThread(textToSend);
        }
        
        this.prr = function(){
            var randomArrayPart = self.getRandomElementPrPs(PRRR);
            var kal = PRRR[randomArrayPart];
            var reverseKal = kal;
            markupFlag = self.checkStringToOurSpecialMarkup(kal);
            var counterFor = 0;
            for (;;) {
		kal = kal.replace("\0", ""); 		
		counterFor = counterFor + 1;
		if(counterFor > 4) break;
	    }	
            // \0-разметка здесь значит немного другое.
	    // для nrm прихерачивается вторая строка из второго массива (поэтому все nrm должны идти перед snd)
	    // snd означает, что обходить вордфильтр не нужно
	    // fst используется один раз и работает как nrm в piss
            if(markupFlag == 'fst') {
		var textToSend = simpleSymbol + reverseKal + simpleBr + markupLine;
	    }
	    if(markupFlag == 'snd') {
	        var textToSend = kal + simpleBr + markupLine;
	    }
	    if(markupFlag == 'nrm') {
	    	var kalNext = PRR2[randomArrayPart];
	    	textToSend = simpleSymbol + reverseKal + simpleBr + markupLine + simpleBr + kalNext + simpleBr + markupLine;
	    }
	    self.sendMessageToThread(textToSend);
        }
	
	this.checkStringToOurSpecialMarkup = function(string) {
	    console.log("STRING LENGTH: " + string.length);
	    stringVisibleNulls = string;
	    var counterFor = 0;
	    for (;;) { // КУКАРЕКУ!
		stringVisibleNulls = stringVisibleNulls.replace("\0", "@"); 
		counterFor = counterFor + 1;
		if(counterFor > 4) break;
	    }
	    //alert(stringVisibleNulls);
	    firstTwoSymbols = stringVisibleNulls.substr(0, 2);
	    lastThreeSymbols = stringVisibleNulls.substr(string.length - 3, string.length);
	    console.log("FIRST 2 SYM: " + firstTwoSymbols);
            console.log("LAST 3 SYM: " + lastThreeSymbols);
            if(firstTwoSymbols == "@@") {
                console.log("Second part detected");
                return "snd";
            }
            if(lastThreeSymbols == "@@@") {
                console.log("First part detected");
                return "fst";
            }
            if(lastThreeSymbols != "@@@" && firstTwoSymbols != "@@" && (string != '' || string != null)) {
            	return "nrm";
            }
            return "error";
        }

        this.setSkipBoxes = function(){
            var checkbox = jQuery("<input>");
            checkbox.attr("type", "checkbox").addClass("skip");
            jQuery(".b-comment_b-info").append(checkbox);
            jQuery(document).ajaxComplete(function(){
                //console.log("Установка пропускательных коробок");
                jQuery(".b-comment_b-info").filter(function(){
                    return jQuery(this).find(".skip").length == 0;
                }).append(checkbox);
            });
        }
        this.createButton = function(text, handler){
            var randomId = Math.random().toString().replace("0.", "button-");
            var button = jQuery("<button>");
            button.addClass(randomId);
            button.text(text);
            jQuery(".b-blog-entry").append(button);
            if (typeof (handler) == "function")
                    jQuery(document).on("click", "."+randomId, handler);
            return randomId;
        };
          
        this.createButtonDown = function(text, handler){
            var button = document.createElement("input");
    	    button.type = "button";
    	    button.value = text;
    	    button.onclick = handler;
    	    $(button).insertAfter(".b-comment-form input:submit");
    	}
          
        this.pearParashee = function(){
            var threadNumber = window.location.pathname.split("/")[3];
            self.sendMessageToThread("Пеар параши, минус.");
            jQuery.ajax("http://1chan.inach.org/news/res/"+threadNumber+"/rate_post/down/");
        };
           
        this.sendMessageToThread = function(message){
            var threadNumber = window.location.pathname.split("/")[3];
                    var captcha = self.getCaptcha();
                    autoSignatureEnabled = localStorage.getItem('isSignatureAutomatic');
                    console.log(autoSignatureEnabled);
                    if (autoSignatureEnabled == "true") { // STRING блядь, не BOOL!
                        message += '\n' + localStorage.getItem('userSignature');
                    }
                    formTextarea.value = message; // Закомменть эту строчку чтобы убрать пересылку постов в форму.
                    //console.log(ourLatestPost);
                    jQuery.post("http://1chan.inach.org/news/res/"+threadNumber+"/add_comment/", {"post_id": threadNumber, "captcha_key": "comment", "captcha": captcha, "homeboard": "anonymous", "text": message });
        };
               
        
        this.getCaptcha = function(){
            var captchaBox = jQuery(".b-comment-form input[name=captcha]");
                    if (captchaBox.length > 0) {
                return captchaBox.val(); }
            return "";
        };
     
        this.askAboutReading = function(){
            var stats = ">Читают: " + jQuery("#post_stats_reading").text();
            var text = stats + "\r\nХули вы тут читаете?";
            self.sendMessageToThread(text);
        };
		
		this.askAboutWriting = function(){
            var stats = ">Отвечают: " + jQuery("#post_stats_writing").text();
            if (parseInt(jQuery("#post_stats_writing").text()) == 0) {
            	var text = stats + "\r\nХули вы тут не пишете?";
            }
            if (parseInt(jQuery("#post_stats_writing").text()) == 1) {
            	var text = stats + "\r\nБомбануло у петуха, ответы строчит.";
            }            
            if (parseInt(jQuery("#post_stats_writing").text()) > 1) {
            	var text = stats + "\r\nХули вы тут пишете?";
            }            
            self.sendMessageToThread(text);
        };
		
		this.autoCoproReply = function(){
            var threadNumber = window.location.pathname.split("/")[3];
            var commentNumbers = jQuery(".b-comment_b-info a[name]");
            var coproPaste = copro.split("----------");
			var reply = ">>" + (commentNumbers.length>0?commentNumbers.last().text():threadNumber) + "\r\n" + self.getRandomElement(coproPaste);
			self.sendMessageToThread(reply);
        };
       
       
        this.sendAutoMessage = function(){
            	var threadNumber = window.location.pathname.split("/")[3];
            	var commentNumbers = jQuery(".b-comment_b-info a[name]");
            	var words = jQuery.unique(jQuery(".b-comment_b-body,.b-blog-entry_b-body")
                                      .filter(function(){ return !jQuery(this).find(".skip").is(":checked"); })
                                 .text().split(/\s+/)
                                 .filter(function(a){
                                     return a.match(/[A-Za-zА-Яа-я]+/) && a.length < 15;
                                 })
                                 .map(function(a){
                                     return a.replace(/[\.,!?()]/g, "").toLowerCase()
                                 }));
            	var icons = jQuery(".js-homeboard-select-link");
            	//var captcha = self.getCaptcha();
            	//jQuery.post("http://1chan.inach.org/news/res/"+threadNumber+"/add_comment/", {"post_id": threadNumber, "captcha": captcha, "captcha_key": "comment", "homeboard": "anonymous", "text": self.generateMessage(threadNumber, commentNumbers, words)});
            	var reply = self.generateMessage(threadNumber, commentNumbers, words);
            	console.log(reply);
            	self.sendMessageToThread(reply);
        };
       
        this.reprps = this.getRandomElementPrPs = function(array){
            self.lastRandom = 0;
            var randomValue = Math.floor(Math.random()*array.length);
            if (randomValue == window.lastRandom && array.length>1)
                return self.reprps(array);
            window.lastRandom = randomValue;
            return randomValue;
        };
       
       
        this.re = this.getRandomElement = function(array){
            self.lastRandom = 0;
            var randomValue = Math.floor(Math.random()*array.length);
            if (randomValue == window.lastRandom && array.length>1)
                return self.re(array);
            window.lastRandom = randomValue;
            return array[randomValue];
        };
       
        this.generateMessage = function(threadNumber, commentNumbers, words){
            var replyTo = ">>" + (commentNumbers.length>0?commentNumbers.last().text():threadNumber);
            var smile = " "; // здесь можно вставлять смайл, а можно и не вставлять
            var wordsCount = Math.floor(Math.random()*30) + 1;
            var text = self.capitaliseFirstLetter(self.re(words));
            var sentenceLength = Math.min(Math.floor(Math.random()*6) + 5, wordsCount);
            var sentenceIndex = 1;
            for (var i=0; i<wordsCount; i++){
                nextWord = self.re(words);
                if (sentenceIndex == 0){
                    nextWord = " " + self.capitaliseFirstLetter(nextWord);
                }
                else{
                    if (wordsAfterComma.indexOf(nextWord) > -1){
                            nextWord = ", " + nextWord;
                    }
                    else{
                        nextWord = " " + nextWord;
                    }
                }
                if (sentenceIndex >= sentenceLength - 1){
                    sentenceLength = Math.min(Math.floor(Math.random()*7) + 4, wordsCount - i - 1);
                    sentenceIndex = 0;
                    nextWord += ".";
                }
                else{
                    sentenceIndex++;
                }
               
                text += nextWord;
            }
            return replyTo + "\r\n" + "  " + smile + text;
        };
       
        this.kolchanslyYazeek = function(input){
            var map = {
                "а": "ah",
                "б": "b",
                "в": "v",
                "г": "g",
                "д": "d",
                "e": "ye",
                "ё": "ir",
                "ж": "j",
                "з": "z",
                "и": "ee",
                "к": "que",
                "л": "l",
                "м": "m",
                "н": "n",
                "о": "aw",
                "п": "p",
                "р": "r",
                "с": "s",
                "т": "t",
                "у": "oo",
                "ф": "f",
                "х": "h",
                "ц": "с",
                "ч": "ch",
                "ш": "sh",
                "щ": "sh",
                "ъ": "",
                "ы": "y",
                "ь": "",
                "э": "e",
                "ю": "u",
                "я": "ya"
            };
            for (var i in map)
            {
                input = input.replace(new RegExp(i, "g"), map[i]);
            }
            return input;
        }
       
        this.capitaliseFirstLetter = function(input){
            return input.charAt(0).toUpperCase() + input.substr(1);
        };
        var anime = "Аниме как таковое - посредственное говно, нормальный человек смотреть его не будет, пока есть фильмы. Но есть категория говноедов, которая поддаётся на форс этой хуиты в западном интернете.\r\nОсобо ущербные после аниме также начинают поедать прочее японское дерьмо: слушать японскую попсу на ютубе, пытаться учить японский язык и дрочить на азиаток. Всё это безвольные и бесполезные люди, как правило подростки.\r\nАнимебляди на бордах это отдельный случай. Это самый низ в иерархии и так не самого высшего сообщества - аутисты, дауны, дегенераты, представляющие себя нарисованными девочками, вниманиебляди всех мастей. На любой уважающей себя имиджборде этих опущенцев презирают и унижают при первой же возможности.\r\n----------\r\n\"Хейтеры\" это выдумка анимедетей, чтобы повысить свою значимость. В действительности же неприязнь к аниме это естественное нежелание находиться рядом с дебилами и ущербными. Им место в специально отведённых огороженных загонах вроде сырнопараши.\r\n----------\r\nТо, что кто-то из нульчанеров сидит на сырнопараше, как и \"нульсырно\" - форсы единственного петуха с сырнопараши. Он завидует тому, что нульчан является анонимной имиджбордой, в отличии от его анимешного форума для аутистов. И всячески пытается навредить форсами и созданием дебильных аниме-тредов.\r\nОсновная активность форсера наблюдается после падений нульчана, когда он утверждает, что нульчанеры якобы пережидали падение на сырнопараше. Конечно же это не соответствует действительности, потому что в этой клоаке кучкуются только чатодебилы и вниманиебляди (которые изначально являются пидорнутыми сосачерами либо сырнопарашниками и лишь паразитируют на нульчане).\r\n----------\r\nПочему ньюфаги с промытыми мозгами никак не могут смириться с тем, что аниме на бордах не нужно? Порой забавляет обвинение в ньюфажестве от тех, кто пришёл на борды года на 3 позже меня.\r\nДопустим, кто-то смотрит мультики и они ему вроде как нравятся. Никто не против. Но когда анимеблядь лезет на борды, считает их своими и навязывает кому-то своё мнение - это уже грубое вмешательство в чужое пространство.\r\nВ ответ на естественную неприязнь анонов, анимеблядь тут же начинает выискивать ньюфагов, семёнов, сосачеров (нужное подчеркнуть), которые во всём виноваты, что добавляет ещё больше абсурда.\r\nАнимеблядкам пора бы отказаться от своих навязанных луркой шаблонов и понять, что просмотр мультиков не повышает их значимость, не делает их олдфагами и не порождает каких-то мифических \"хейтеров\". А в том, что сейчас к любому постеру аниме относятся предвзято, виноваты они сами.\r\n----------\r\nВраги имиджборд\r\n\r\nЯдро любой имиджборды составляют аноны. Они производят весь контент, от них исходит весь движняк, они не требуют за это какой-то платы или внимания к себе. Единственными имиджбордами в рунете на данный момент являются Нульчан и Сосач. За рубежом хорошими примерами служат Краутчан и Форчан.\r\n\r\nВраги имиджборд. Все ниже перечисленные категории личностей не имеют никакого отношения к анонимности и паразитируют на имиджбордах, преследуя свои корыстные цели:\r\n\r\n1. **Фаги**. В основном это дауны-любители аниме (аниме - основной рак, убивающий имиджборды), аутисты, как правило школьники, которые форсят всякое говно вроде мультиков и богинь. Если не пресекать этот цирк уродов модерацией, они могут расплодиться и скатить любую имиджборду до уровня сырнопараши, которая представляет из себя эталонную огороженную клоаку для умалишённых.\r\n2. **Вниманиебляди**. Это ущербные личности, которые пытаются компенсировать свою ущербность, паразитируя на имиджбордах. Все они представляют из себя абсолютно бесполезный мусор, который не нашёл ничего лучше, чем привлекать к себе внимание, будучи не анонимным в анонимной среде. Ведь здесь кто угодно может выделиться из толпы, не обладая никакими способностями.\r\n3. **Пидорнутые**. Это представители двух указанных выше категорий, которых пидорнули с сосача. Они активно борются с сосачерами, забывая о том, что находятся не на сосаче. Причина такой забывчивости очевидна: они не могут срать на самом сосаче и делают это там, где могут. В отсутствии настоящих сосачеров за них могут сойти любые аноны, которые по мнению пидорнутого делают что-то неправильно. То есть практически все, кроме него.\r\n\r\nЭти три категории весьма тесно пересекаются. Типичная вниманиеблядь представляет из себя забаненого на сосаче буйного форсера фагохуйни. Практически всегда субъект, входящий в одну из категорий, входит в какую-либо другую из перечисленных.\r\n----------\r\nСиндром пидорнутого\r\n\r\nСиндром пидорнутого возникает, когда пидорнутый находит ресурс, где не банят дебилов и буйных вниманиеблядей, после чего начинает считать себя патриотом этого ресурса.\r\nЛживый патриотизм у пидорнутого возникает по нескольким причинам:\r\n1. Появляется место, где можно свободно срать и вниманиеблядствовать (это единственное, что умеют пидорнутые и что они делают лучше всего), не опасаясь быть пидорнутым снова.\r\n2. Появляется новый повод противопоставить себя сосачу. Ведь выгоднее выдавать себя за представителя какой-то другой борды, чем быть просто обиженкой. При этом причина ненависти к сосачу по-прежнему заключается только в невозможности на нём срать и не имеет отношения к ресурсу, на котором осел пидорнутый.\r\n3. Появляется простор для агитации борьбы с сосачем. Пидорнутому гораздо проще выдавать себя за посетителя другой борды и пытаться наращивать на ней ненависть к сосачу, чем агитировать борьбу с администрацией на самом сосаче.\r\n----------\r\nВсе фагготории - рак, поощряющий неадекватное поведение и скатывающий общение на бордах до уровня конференций.\r\nТак что плохого в том, чтобы замещать анимедебилов, конфоблядей и прочих аутистов полноценными людьми (например из вконтакте)? Только сами ущербные и против, анонам похуй.\r\n----------\r\nНе стоит забывать, что пидорнутым не знакомо понятие чести, это ущербные вниманиебляди, дерьмо на подошве имиджборд. Любой из них, оказавшись в роли админа сосача занимался бы всем тем, про что они кукарекают.\r\n----------\r\nВ чём заключается суть патриотизма сырноблядей\r\n\r\n1. Вордфильтр и модерация просто не пропускают на борду нормальных людей, они там надолго не задерживаются. Остаются только ущербные (а это обязательное условие для следующих пунктов).\r\n2. Те, кто смог там остаться (не смотря на регулярные порции жидкости от Мочни и модераторов-вниманиеблядей с кредитом доверия), ощущают мнимое превосходство над теми, кто не смог пить мочу и съебал оттуда. То есть по их мнению сырнопараша даёт им превосходство, за что они её любят.\r\n3. От постоянных унижений со стороны Мочни (а всякие подростки-аутисты, типичные анимебляди, любят, когда их унижают) у них возникает стокгольмский синдром, то есть они начинают всячески оправдывать и защищать того, кто причиняет им вред.\r\n\r\nИз всего этого и выходит, что никто так не защищает свою борду от нападок, как представители сырнопараши.\r\n----------\r\nС репрессий против анимешного пониговна (и прочего мусора) на сосаче прошло уже больше полутора года. Пидорнутые со временем всё слабее ощущают свою связь с сосачем и уже считают себя полноправными посетителями тех борд, на которые они переселились чтобы срать. Как показали недавние события с ослаблением модерации на сосаче, большинство из них даже не хочет возвращаться домой.\r\nНапомню, что все пидорнутые по-прежнему ведут себя как сосачеры и умеют делать только две вещи: вниманиеблядствовать и срать.\r\nУнижать пидорнутых и указывать им место - это наш долг, не стоит забывать об этом.\r\n----------\r\nФагоблядь не может быть анонимом уже потому, что причисляет себя к фагготории и идентифицирует себя этим. Причём \"причисляет\" мягко сказано, обычно эти ущербые стараются максимально выпячивать свою принадлежность (обычно постингом картинок), как раз с целью выделиться.\r\nНо это мелочь по сравнению с тем, сколько неймфагов пораждают фагготории. 90% вниманиеблядей на всех бордах появились из-за того, что сначала причисляли себя к какой-то фагготории вроде аниме.\r\n----------\r\nЗачем пидорнутые выдумывают заговоры?\r\n\r\nКак всё есть на самом деле:\r\n* На сосаче сменился администратор, который оказался лучшим, чем предыдущий. С борды выгнали кучку буйных вниманиеблядей и форсеров, которые ни на какой борде не нужны. После чего они стали использовать как плацдарм для вниманиеблядства другие ресурсы, такие как нульчан и одинчан, вызывая к себе негодование и презрение со стороны коренных посетителей.\r\n\r\nКак выглядит ситуация в глазах пидорнутого:\r\n* Олабляди купили тиреч, чтобы выгнать всех олдфагов и заменить их ньюфагами из контакта, после чего тиреч перестал быть имиджбордой. Олдфагам пришлось перейти в оппозицию и перебраться на другие ресурсы. К сожалению, все остальные борды уже опутаны агентами оланета и коренными посетителями этих ресурсов можно считать только олдфагов тиреча и тех, кто их поддерживает, а все остальные - сосачеры.\r\n\r\nМожно сделать вывод, что все заговоры, которые пидорнутые выдумывают против себя - лишь средство поднять свою значимость. Ведь гораздо лучше представлять себя пострадавшим и гонимым, чем смириться со своей ненужностью.\r\n----------\r\nПричина появления вниманиеблядей на бордах проста и стара как говно динозавра. Ущербные личности испытывают необходимость компенсировать свою ущербность и не находят ничего лучше, чем быть не анонимным в анонимной среде. Ведь здесь кто угодно может выделиться из толпы, не обладая никакими способностями.\r\n\r\nАгрессивность и неуважение к незнакомым людям - признак слабости и проблем с психикой, неудовлетворённых желаний, а не что-то доминантное и выражающее превосходство.\r\nГордиться своей не анонимностью на бордах - всё равно, что гордиться своей национальностью и оскорблять людей другой национальности, при этом не делая ничего, чтобы показать, что ты лучше их. К этому склонны только убогие и завистливые люди.\r\n----------\r\nПидорнутые любят как вниманиеблядствовать, так и обсуждать других вниманиеблядей. Любят засирать борды всяким говном вроде аниме или поней, держать на доске личные треды или треды-филиалы конф. Ненавидят анона в целом и борды, где им затыкают рот, в особенности сосач. Пидорнутый сидит в конфах и считает себя нульчанером, хотя съебёт паразитировать на более посещаемую борду при первой возможности. Вычислить пидорнутого очень просто.\r\n----------\r\nАнимешный рак это форсеры, считающие что на бордах везде должно быть аниме. Они создают бессмысленные аниме-треды и чатики в /b/ и /vg/, борятся с мифическим быдлом и сосачерами. Анимешный рак с высокой вероятностью также является конфораком.\r\n\r\nКонфорак это ущербные вниманиебляди, готовые на всё ради крупиц внимания. Для чего они таскают сюда логи из конф со своим участием и форсят свои прозвища и прозвища друг-друга.\r\n----------\r\nПидорнутые унижают себя самим своим существованием и в любой момент можно добавить ещё унижений. Все их кукареканья про сосач, оланет и т.д. лично ко мне никакого отношения не имеют и проходят мимо, оставляя пидорнутых без аргументов.\r\n----------\r\nСтоит помнить, что аватарки и официальные треды - метастазы анимешного рака. Ещё пару лет назад все неймфаги были анимеблядками, а первый паразитирующий на /b/ тред был с куклами. Корень у этого зла один - аниме, которое порождает всё плохое на имиджбордах.\r\n----------\r\nВсе \"официальные\" треды представляют из себя чатик кучки вниманиеблядей, выставляющих своё общение на обозрение всей доске. Эти треды нигде не нужны в принципе.\r\n----------\r\nЗащита нульчана от вымышленных сосачеров - главное оправдание анимешного рачья.\r\nВменяемому человеку же очевидно, что им просто нужно где-то срать, а на сосаче они этого делать не могут. А сосачер для анимебляди - это любой, кто не постит анимешные картинки или просто взрослый адекватный человек (т.н. \"быдло\").\r\nТаким образом, основными врагами нульчана, которые наносят ему реальный вред, сейчас являются фаги и в частности анимебляди (большинство из которых до пидорения были сосачерами).\r\nНастоящим же сосачерам на нульчан похуй, также как и настоящим нульчанерам на сосач.\r\n----------\r\nОсновная причина нелюбви к пидорнутым в том, что они лезут на другие борды, чтобы на них срать и наводить петушиные порядки.\r\nЭто в свою очередь следует из того, что все пидорнутые - агрессивные вниманиебляди и форсеры, за что их собственно и пидорнули.\r\n----------\r\nКонфоманя громко ноет\r\nБорды нет, одна конфа\r\nТо мочой его напоят\r\nТо присунут в туз хуя\r\n----------\r\nЛюбой отдельно взятый конфоинвалид всегда рад упоминанию своего прозвища, вне зависимости от контекста. И делает всё для того, чтобы его упоминали.\r\nПоэтому, анону стоит воздержаться от упоминания каких-либо ников и прозвищ в разговоре о конфоопущенных. Следует относится к посетителям конференций как общей массе говна и не выделять из неё каких-то личностей.\r\nНикогда не обсуждайте конфоущербных и прочих инвалидов, не упоминайте их прозвища, не опускайтесь до их уровня.\r\n----------\r\nЗачем кому-то нужно смотреть аниме? По мне так достаточно посмотреть на этих дебилов-фанатов на бордах, чтобы никогда не смотреть аниме.\r\n----------\r\nНа воровском жаргоне \"няша\" означает пассивный гомосексуалист.\r\nДаже поговорка есть: \"каждой няше место на параше\".\r\n----------\r\nНазывать харкач ычаном, всё равно, что называть сосач двачем.\r\n----------\r\nЧто такое мочепропаганда? Это пидорнутые, которые засирают и вайпают другие борды, чтобы выманивать их посетителей на сосач. На что они недвусмысленно намекают, посылая всех на родной сосач.\r\n----------\r\nВсе нормальные люди либо игнорируют существование сосача, либо сидят на нём.\r\nНо пидорнутые не могут ни сидеть там, ни игнорировать, от чего у них баттхёрт. Поэтому они лезут на другие ресурсы, туда, где им не заткнут рот и срут, считая что все должны разделять их мнение. При этом тот, кто его не разделяет, объявляется сосачером.\r\nСтоит ли говорить, что пидорнутый ничем не лучше сосачера, а даже хуже? Ведь пидоряют оттуда в основном агрессивных петушков-форсеров и вниманиеблядей которые не нужны нигде.\r\n----------\r\nПидорнутые - это все обиженные вниманиебляди (в основном форсеры аниме, кукол, поней и т.п., которые не смогли переселиться в тематику сосача, потому что им нужно срать именно в /b/) и их список пополняется постоянно. Бывшие модераторы хотя и относится к пидорнутым, но на них список пидорнутых не заканчивается.\r\n----------\r\nМодерация сырнопараши нацелена именно на отсеивание адекватных людей, чтобы оставить дегенератов (модерация на сосаче, например, преследует противоположные цели).\r\nИзвестно, что контингент сырнопараши состоит из умственно отсталых подростков, основное время провождения для которых - представление себя в роли девочек, няканье и постинг картинок из мультиков. Это самый низ имиджборд, хуже могут быть только конфобляди.\r\nПоэтому считается, что сырнопараша не является имиджбордой, но является модерируемым анимешным форумом на движке имиджборды.\r\n----------\r\nМожет между тохо и аниме есть какая-то разница, но \"фанаты\" - одинаковое неполноценное быдло, извергающее някающий словесный понос, поедающее говно и кучкуещееся в конфочках. Отвратительное явление.\r\n----------\r\nПидорнутые стыдятся своего сосачерского происхождения и всячески пытаются это компенсировать детектированием сосачеров. Но петушиная сущность пидорнутых выдаёт их чуть ли не в каждом посте.\r\n----------\r\nПочему почти все конфобляди - пидорнутые?\r\n\r\nВсё просто. До прихода Абу всё говно стекалось в одно место - тиреч. Конференции на 100% состоят из говна и логично, что ныне почти все конфобляди - пидорнутые.\r\n----------\r\nК какой борде бы не причислял себя пидорнутый, это не имеет никакого значения. На любой борде они будут паразитами, сосущими кровь из нормальных анонов.\r\nСамой подходящей принадлежностью пидорнутого являются конференции и как правило он проводит в них много времени. А если и не проводит - только из-за того, что забыл где его место.\r\n----------\r\nНапоминаю, что тиречер (не путать с сосачерами, эти куда более опущенные) и сырнопарашник - по сути одно и то же, анимешное рачьё на любой борде одинаковое. Они ненавидят анона и анонимные имиджборды (в особенности сосач, где бесполезным анимедебилам быстрее всего затыкают рот), нульчану они также всегда завидовали и стремились ему навредить. Именно сырнобляди вместе с пидорнутыми тиречерами занесли сюда чатики и аватарки в 2011 году.\r\nТак что сырнопараша была и остаётся вражеской бордой для нульчана, не стоит забывать об этом.\r\n----------\r\nВо-первых, пидорнутый может быть только с родной борды. Если кто-то насрал на сырнопарашу и модалик за ним убрал - это ничего не значит, всем похуй.\r\nВо-вторых, любой может притвориться умственно отсталым и вести себя на анимешном форуме как подобает. Только никакого смысла подобные действия не несут, гораздо лучше общаться с анонами на имиджборде, а подростков с отклонениями в развитии оставить под гнётом модалика, где им самое место.\r\n----------\r\nВ последнее время здесь упоминаются некие забаненые на сырнопараше\r\n\r\nОчевидно, что любой человек может притвориться умственно отсталым, някать и обсуждать мультики, сидя на сырнопараше сколько угодно. Даже схватив бан, это легко исправить с динамическим айпи.\r\nОднако, не любой человек опустится до посещения анимефорума, который по совместительству является личным блогом админа-вахтёра.\r\n\r\nТак что никаких пидорнутых с сырнопараши не может быть в принципе - нормальный человек туда просто не пойдёт, а если и захочет - может сидеть там сколько угодно.\r\n----------\r\nПидорнутые - обиженные вниманиебляди\r\n\r\nПидорнутые представляют из себя кучку обиженных вниманиеблядей, которые всё своё пребывание на борде занимались форсом себя и прочей хуйни, а также созданием \"элитных конференций\", чтобы эти форсы координировать.\r\nПри новой администрации они этого делать не могут, вот и подают голос со стороны параши про \"мочу\" и \"сосаку\".\r\nКонтингент борды же не изменился и на проблемы обиженных там всем похуй.\r\n----------\r\nКонфоблядь - высшая степень деградации посетителя имиджборд.\r\nЗа примерами далеко ходить не нужно.\r\n----------\r\nСловарь анимешника\r\n\r\nаниме - мультики для геев\r\nанимешник - гей\r\nня - очко\r\nняк - пердак\r\nняшка - пассивный гей\r\nняшить - опускать\r\nняшиться - долбиться в пердак\r\nпоняша (\"поняшенный\") - опущенный\r\nнипа - минет\r\n\r\n:3 - желание отсосать\r\n ^_^ - желание анального секса\r\n----------\r\nПочему пидорнутые так любят срать?\r\n\r\nПедалик создал пидорнутых из своего кала и блевотины, вдохнув в них жизнь, испустив кишечные газы. Кроме зависти и стремления навредить людям, которые лучше их, в них нет ничего.\r\n----------\r\nПочему анимеблядей часто называют пидорнутыми?\r\n\r\nКак известно, пидорнутые осели на ряде ресурсов. Большинство из них - конфомусор, форсеры кукол, лошадей и подобного говна, за что их собственно и пидорнули. И все они - анимебляди различной степени умственной отсталости.\r\n----------\r\nРубрика: советы от олдфага\r\n\r\nМногие спрашивают, почему анимебляди такие тупые и нормальному человеку невозможно общаться с этим отребьем?\r\nПостановка вопроса неправильная. Нужно спрашивать не \"почему анимебляди такие дебилы\", а \"почему дебилы так любят аниме\".\r\n----------\r\nКонфоопущенный - это человек (бывший), который зашкварился посещением конференций. Что зашкварено, то не может быть разшкварено - однажды посетивший конфу навсегда остаётся опущенным петухом.\r\n----------\r\nПидорнутый - это конфоопущенный сосачер, который не может срать в свою родную парашу.\r\nПо этой причине он стремится найти такое место, на котором не банят дебилов, чтобы срать на нём и причислять себя к нему (быть показным патриотом другой борды, чтобы были аргументы в ненависти к родному сосачу).\r\nОбычно такими местами являются не модерируемые нульчан и одинчан.\r\n----------\r\nСреди пидорнутых макакой фагодебилов, конфоблядков и прочего ненужного мусора, которые ныне считают себя единственно верными одинчанерами или нульчанерами, часто можно встретить ненависть к своей родной борде и тем, кто её посещает. Завидев сосачера (или увидев его в любом аноне, что не редкость), пидорнутый обязательно попытается его оскорбить и засагать тред.\r\nЗдесь мы видим проявление лицемерия и двойные стандарты вида \"Я сюда пришёл, а тебе нельзя\".\r\nК тому же, пидорнутых пидорнули не просто так - они вредят любой борде, без них на любая борда станет лучше. Получается, что у сосачера даже больше прав посещать какой-либо ресурс.\r\n----------\r\nМудрость\r\n\r\nНе все анимебляди - пидорнутые, но все пидорнутые - анимебляди.\r\nНе все конфобляди - пидорнутые, но все пидорнутые - конфобляди.\r\nНе все вниманиебляди - пидорнутые, но все пидорнутые - вниманиебляди.\r\n----------\r\nОланет\r\n\r\nЭто такое место, куда пидорнутые попадают после смерти.\r\n----------\r\nРаскрыта причина баттхёрта пидорнутых\r\n\r\nОни не могут смириться с тем, что всем похуй на кучку пидорнутых и сосач не потерял ни 0,001% посещаемости. Проще говоря, у сосачеров есть борда, а у пидорнутых - нет.\r\nОтсюда их дебильные форсы (\"моча\", \"сосака\") и стремление унизить сосачеров (вчерашних сородичей) на немодерируемых ресурсах - одинчане и нульчане потому, что на самом сосаче за это забнят.\r\nТакая вот бессильная злоба опущенцев.\r\n----------\r\nЗа что мы не любим сырнопарашу?\r\n\r\nОсновной контингент сырнопараши - \"не такие как все\" подростки, которых травят в школе и которым никто никогда не даст. Они ничего не знают и ничего не умеют, обсуждают японские мультики, чтобы хоть как-то самовыразиться, не прилагая усилий.\r\nХитрый Педалик сделал специальный форум для вышеописанных личностей с рабским менталитетом, которые всё всегда стерпят и будут поддерживать любые действия администратора. В итоге вменяемому человеку просто нечего делать в этом аду модерастии.\r\n----------\r\nАнимехейтеров не существует. Нежелание находится рядом с даунами, которые обмазывают стены говном - естественная потребность человека. Например, посчитайте упоминание слов \"уёбывай\" и подобных, далеко не все они относятся к анимедебилам. Но суть одна.\r\n----------\r\nПосетители сырнопараши - пидорнутые опущенцы.\r\nИх пидорнули с двача и тиреча, теперь у них нет борды, только анимефорум.\r\n----------\r\nПлан по развитию имиджборд\r\n1. Окончательное уничтожением оставшихся тиречеров на всех бордах.\r\n2. Полный запрет на обсуждение аниме и постинг относящегося к нему контента.\r\n3. Закрытие источников анимешного рака (сырнопараша, добропараша).\r\n----------\r\n\"Конфа\" + \"аниме\" = \"конфониме\". Короткое обозначение анимешного конфорака.\r\n----------\r\n12 фактов от олдфага\r\n\r\n1. Аниме - рак имиджборд.\r\n2. Конфобляди - глисты имиджборд.\r\n3. Воровач - душа имиджборд.\r\n4. Нульчан - единственная имиджборда рунета.\r\n5. Сосач - анонимная социальная сеть.\r\n6. Сырнопараша (педальчан), добропараша - модерирумые анимефорумы для дебилов, к имиджбордам никакого отношения не имеют.\r\n7. Моча - форс пидорнутых.\r\n8. Причина ненависти пидорнутых к сосачу заключается лишь в том, что им не дают там срать. При этом они ничем не лучше сосачеров.\r\n9. Тиречер хуже сосачера.\r\n10. Всё аниме - посредственные мультики для позёров и говноедов. Позёрская любовь к аниме используется для самовыражения уёбками, которым ни на что другое ума не хватает.\r\n11. Куклопонос, понипонос и т.д. - это всё одно и тоже говно, бесполезные уёбки и вниманиешлюхи собираются в кучу, чтобы тупить коллективно. При этом они засирают всё пространство вокруг себя, стремясь обратить на себя внимание.\r\n12. Opera - единственный браузер.\r\n----------\r\nЖить от мысли веселей\r\n\r\nУ конфоблядей нет друзей.\r\n----------\r\n\"Пидорнутые\" - как правило постоянные посетители jabber-конференций, чьё присутствие на 2ch.so преследуется администрацией, ввиду стремления пидорнутых обратить внимание лично на себя, вместо типичного общения на имиджборде.\r\n----------\r\nДавайте разберёмся, кто такие эти пидорнутые? Это ньюфаги, пришедшие на тиреч в 2010 (максимум 2009) году и обиженные новым админом после 1–1,5 года пребывания на борде. Их мозги разжижены постоянным сидением в конфах, они могут только форсить, вниманиеблядствовать и ещё раз форсить. Сосачер в 100 раз лучше конфодебила, не говоря уж о других бордах.\r\nТаким образом, пидорнутые - самая низшая каста на бордах, они даже хуже апачанеров.\r\n----------\r\nКонфы - добровольная резервация для неполноценных вниманиешлюх. Некоторые понимают, что на бордах им делать нечего и уходят туда. Дауны сидят там и дрочат друг-другу, достигая гармонии и теряя необходимость страть на борде, чтобы обратить на себя внимание анона. Но зачастую отбросы всё же вылезают из своей выгребной ямы, чтобы удивить окружающих своей убогостью.\r\n----------\r\nОланет - форс пидорнутых. Списывая на олапедали все свои беды и выдумывая заговоры, пидорнутые создают им репутацию, чему сами олапедали рады и способствуют. Но жопа обиженки без борды думает заместо головы и он не сможет этого понять.\r\n----------\r\nОткуда столько постов на сырнопараше\r\n\r\nКак 20 человек могли настрочить 2 миллиона постов? Мотня накручивает счётчик? Дискач.\r\n----------\r\nhttp://0chan.hk/ - нульчан, воровчан\r\nhttp://2ch.hk/ - сосач\r\nhttp://iichan.hk/ - сырнопараша, срачан, харкач, подтирач, мочан, педальчан, очкопараша\r\nhttp://dobrochan.ru/ - копрочан\r\n----------\r\nОсновные враги имиджборд\r\n\r\n1. Конфорак.\r\n2. Анимерак.\r\n3. Пидорнутые.\r\n\r\nЗачастую это всё сочетается в одном \"человеке\".\r\n----------\r\nПришло время напомнить\r\n\r\nАнонимные **имиджборды**:\r\nhttp://0chan.hk/ (нульчан, тюрьмач)\r\n\r\nАнонимные **социальные сети**:\r\nhttp://2ch.hk/ (сосач, \"вдваче\")\r\n\r\nМодерируемые **анимефорумы** для умственно отсталых подростков:\r\nhttp://iichan.hk/ (сырнопараша, харкач, педальчан)\r\nhttp://dobrochan.ru/ (копрочан)\r\n\r\n**Калоприёмники** для пидорнутых конфопетухов и форсеров:\r\nhttp://1chan.inach.org/ (калочан, очкопараша, обиженка)\r\n\r\nВсё остальное - недостойные упоминания петушиные бараки различной степени зашкваренности.\r\n----------\r\nПочему сырнопараша - не имиджборда?\r\n\r\n1. Нет анонимности.\r\n2. Куча модераторов, которые банят кого хотят.\r\n3. Старые треды не удаляются.\r\n4. Запрещён сленг и контент с имиджборд (!).\r\n\r\nВ итоге: ставим это дело на форумный движок вроде phpBB (треды хранятся вечно и делятся на страницы, нет лимита постов, аватарки пользователей прикрепляются автоматически) и получаем обычный анимешный форум.\r\n----------\r\nРазбор форса мочи\r\n\r\nРассчитано прежде всего на анонов, которые не имеют отношения к пидорнутым, но повторяют за ними этот форс.\r\n1. Форс дегенеративный. Чисто на уровне подтирача/упячки/конфочек. Уважающему себя посетителю имиджборд не подобает употреблять подобное в своей письменной речи.\r\n2. Происхождение форса. Всем известно, что моча - форс пидорнутых макакой. Употребляя этот форс ты продолжаешь дело коровьей пизды, ханюгниды и прочих опущенных отбросов.\r\n3. Сегодняшние форсеры. На сосаче этот форс искоренили вместе с пидорнутыми. На нульчане его нет, хотя последний год пидорнутые безуспешно пытаются занести его туда. О сырнопараше/добропараше и говорить не стоит. Получается, что очаг форса сегодня - раковые конфы с бывшими тиречерами (пидорнутыми). А также одинчан, который они используют как туалет. Употребляя форс мочи, ты опускаешься до их уровня.\r\n\r\nИскоренив этот форс мы вместе можем приблизить окончательное решение проблемы с пидорнутыми. Что, в свою очередь, поможет очистить борды от анимешного рака и конфоблядей.\r\n----------\r\nПочему у пидорнутых такой баттхёрт?\r\n\r\nОни бы с радостью сосали Абу на модерку (или возможность вниманиеблядствовать на борде), но он просто нассал им в рот, потому что это место уже занято оланетами. Из-за этого у пидорнутых случилась психическая травма, от чего им везде видятся ОЛАНЕТ и МОЧА.\r\n----------\r\nОпрос: за что вы не любите аниме?\r\n\r\nЯ начну:\r\n1. Някающее быдло, конфобляди, куклоёбы и прочий рак. Без аниме их бы не было на бордах.\r\n2. Школьники, которые считают что просмотр мультиков делает их не такими как все.\r\n----------\r\nАнимешный рак (определение)\r\n\r\nРак имиджборд - что же означает этот пресловутый термин? Собственно то, что вредит имиджбордам. Как правило целенаправленно и в агрессивной форме.\r\n\r\nАнимешный рак - категория посетителей имиджборд, считающих, что просмотр аниме-мультиков и постинг тематического арта даёт им привилегии на имиджбордах, позволяет выделяться, не прилагая усилий и бесконтрольно срать, считая это полезным делом.\r\nИ так, вкратце: анимешное рачьё это обычное бесполезное быдло, которое считает, что имиджборды созданы для них со всем из этого вытекающим.\r\n\r\nКто-то скажет, что как таковое аниме здесь не причём, во всём виноваты недалёкие люди, которые его используют в своих целях. Но ведь именно миф об элитности аниме привлекает ньюфагов и просто низкосортных людей, пополняющих ряды анимешного рачья. И чем дольше будет игнорироваться пагубное влияние аниме на имиджборды, тем дольше будут существовать подобные мифы.\r\n----------\r\nПидорнутые - эксперты по моче\r\n\r\nПочему они говорят только о моче? Судите сами - сначала это была моча коровья, которая сформировала их образ мышления. Потом их обоссал Абу, когда наводил на борде новые порядки и пидорнул их. Они говорят только о моче, фдц состоит из мочи, всё из мочи.\r\n----------\r\nСейчас аниме является раком имиджборд, но это мнение не слишком популярно. Почему? Аниме-рачки не хотят терять простой способ выделяться и всячески этому сопротивляются, а ньюфаги больше верят старым мифам, позволяющим раку насаждать им своё мнение.\r\nКак бы решить эту проблему и привить анонимным массам сопротивление анимешному раку, как это сделано на сосаче?\r\n----------\r\nА давайте вместо \"анимешник\"\r\n\r\nГоворить \"помоешник\"? Слова почти одинаковые.\r\n----------\r\nАнимешный рак\r\n\r\nПагубная роль аниме на имиджбордах заключается в том, что люди для борд бесполезные находят способ самовыражения в этом самом аниме. Они начинают считать себя анимешниками с целью выделиться, ничего при этом не делая. Что по их мнению делает их охуенными и даёт право бесконтрольно срать на бордах. Из этого рождается такое явление, как анимешный рак. Он хуже обычного тем, что кроме собственно вреда имиджбордам ещё и считает, что имиджборды созданы им и для него, что делает его ещё более вредным. В результате появляются многочисленные вниманиебляди, которые паразитируют на бордах и порождают себе подобных как катящийся ком, собирающий всё больше говна. В тоже время не поражённый анимешным раком аноним столько говна не производит и способен доставлять.\r\n----------\r\n\"Моча макаки\" (а также производные: \"Мочан\", \"Мочератор\", \"Мочехлёб\" и т.д.) - форс опущенных, употребляется пидорнутыми с сосача по отношению к модераторам и посетителям борды. Пик форса был сразу же после становления Абу администратором, когда оставшиеся без борды отбросы в бессильной злобе засирали этим форсом одинчан. С тех пор форс утих, но по нему легко детектировать ветеранов баттхёрта ещё того времени, а также пидорнутых недавно.\r\n----------\r\nАнимебляди - как пидорасы\r\n\r\nВроде бы их где-то много, но среди моих знакомых их нет.\r\n----------\r\nПочему анимешный рак хуже обычного?\r\n\r\nПотому что, как правило, они не только не считают себя раком (который убивает борды), но и на полном серьёзе считают, что имиджборды созданы ими и для них.\r\n----------\r\nНужно запретить аниме на имиджбордах\r\n\r\nЧтобы оно не привлекало сюда всякое аниме-быдло из контакта и анимешных форумов. На всех приличных имиджбордах стоит удалить анимешные разделы, а их посетителей сослать на \"форум с аватарками\" сырнопарашу и раковые конфы, где им самое место (не среди анонов).\r\n----------\r\nАниме - рак имиджборд\r\n\r\nТочнее источник рака.\r\nВы только посмотрите на всех этих заполонивших борды аватаркошлюх, конфоблядей и прочих олигофренов с недостатком внимания. Практически все они используют анимешных персонажей для идентификации себя.\r\nК тому-то же, ньюфаги покупаются на идиотский миф о том, что аниме это не для быдла. В результате чего некоторые дети начинают постить анимешные картинки и считают себя не такими как все, при том что представляют из себя унылейшее говно.\r\nПодведя итоги можно сказать, что аниме - это рак борд, который только вредит им.\r\n----------\r\nАниме и говно\r\n\r\nПосмотрите на эти слова, в них ровно по 5 букв. Давайте вместо \"говно\" говорить \"аниме\"?\r\n----------\r\nКроме анимебляди никто не может постить картинки целыми тредами и заполнять целые доски говном. Тупее, вреднее и агрессивнее анимешных дебилов на бордах нет никого, любые ньюфаги лучше.\r\nНо склонность любить мультики - не причина, а следствие. Просто так выражаются самые последние ретарды, у которых не хватает ума ни на что, кроме как някать и постить картинки. А выделяться как-то нужно.\r\n----------\r\nВсе \"официальные\" треды представляют из себя чатик кучки вниманиеблядей, выставляющих своё общение на обозрение всей доске. Эти треды нигде не нужны в принципе.\r\n----------\r\nАниме - рак, убивающий имиджборды.\r\n";
        var sheez = "Помни, серун, то же самое постигнет и тебя, и всех твоих собратьев. От охотников не уйдёшь.\r\n----------\r\nОтпиздили тут на днях срущего петуха в подворотне и нашли у него какой-то дневник. Буду потихоньку перепечатывать записи шизопетуха. Сегодня отрывок:\r\n >Коль скоро поползли слухи о моей работе, расскажу подробнее. В конце прошлого года со мной связался Нариман Намазов, которого вы все знаете по проекту 2ch.hk, и за корку сыра предложил срать на Колчорге. После продолжительных размышлений мной было принято решение принять его предложение. Цель Наримана объединить под своим руководством ведущие ресурсы подобного рода. Корка сыра, которая в первый месяц составила 20 г, давно уже перевалила килограмовый рубеж. У Наримана есть команда специалистов такого уровня как я, которая сможет реализовать планы быстрее (обещание выпилить все параши было обязательным условием при обсуждении сделки), поэтому я считаю, что моё решение правильное. Нариман вызывает доверие, он хорошо зарекомендовал себя. Скоро всем настанет пиздец. Мы будем выпиливать все параши, бороться с пидорнутыми и возвращать всех на двач.\r\n----------\r\nОтпиздили тут на днях срущего петуха в подворотне и нашли у него какой-то дневник. Буду потихоньку перепечатывать записи шизопетуха. Сегодня отрывок:\r\n >С тех пор, как я начал работать, упорно работать на Намазова, утекло много воды. Я выпилил сточ и ещё несколько параш, Намазов приказал начать борьбу с пидорнутыми, пообещал большой куш. Сыр голландский, отличную корку. Я вступил в борьбу в тот же день. Пока ничего не предвещало никаких хлопот. Я методично уничтожал разрозненные группировки пидорнутых, сеял панику и страх, выдавая себя за сумасшедшего. Постил отвратительных поющих бабок, залго-собак с призывами возвращаться на двач, электрички и поезда, утюги. Мои методы действовали, позволяя аортам и артериям системы Намазова на полную мощь гнать потоки мочи. Всё шло по плану. Находясь тени, я спровоцировал исход олдфагов, которые были вынуждены вернуться назад.\r\n >Система, которую построил Нариман подобна микрофлоре — все его постояльцы, или как он называет их «анонимчики», вырабатыают жизненную энергию для Намазова, словно электростанция. Питают его изнутри.\r\n >Вчера я уже собирался спать, как мне позвонил мой начальник Нариман. Он был подавлен, говорил хриплым сухим голосом, я понял, что произошло что-то дурное. Он сообщил, что Sheezbusters вышли на мой и его след. Намазов приказал мне вернуться в прошлое и уничтожить Sheezbusters до того, как они выйдут на нас. Всё уже готово и сегодня я отправлюсь в прошлое и исправлю этот прокол.\r\n----------\r\nМне пришло письмо с прикреплённой коркой сыра и указаниями что надо засрать и я купился на это. Корка сыра была такой аппетитной, что после первого письма я продолжил сотрудничать с Нариманом Намазовым, как я позже узнал из личной встречи с этим человеком. Тогда я видел могущественную корпорацию, построенную Нариманом, моя корка сыра лишь за первый год перевалила за 2 кило, я был одним из самых полезных агентов Наримана. Но вскоре меня настиг Sheesbusters. Я пытался сныкаться, строил из себя няшу, но всё было бессмысленно. Я попался. Парни из Sheesbusters открыли мне глаза на Наримана и вот уже как год я охотник из отряда Sheesbusters. Караем срущих петухов!\r\n----------\r\nУтром смотрел передачу про интернет на каком-то канале. Один профессор сказал, что любой человек, уделяющий большую часть времени общению в интернете страдает легкой степенью шизофрении. Тогда я загуглил телефон этого профессора, позвонил ему домой и сказал:\r\n — Аааа лол! ХУЙ выгрызи, уебище, диагностирует он нас. Сука чистил шизоида рубанул по пальцу ШИЗИК ТЫ СОВСЕМ ЕБАНУЛСЯ? У ТЕБЯ УЖЕ ВСЕ ПЕРЕД ГЛАЗАМИ ПЛЫВЕТ… НЕТ, не делай этого шизик, ведь твой анус не вечен, ты не сможешь все время притворяться профессором!\r\n На что он мне ответил:\r\n — ГАГАГА, ПЕТУХАНЯ ШИЗОИДНАЯ, ДА ТЫ ЖЕ СМЕШНОЙ ПИДОР!\r\n Потом я осознал, что у моего телефона перерезан провод и принял таблетки.\r\n----------\r\nИтак, шизик подавился сыром. Сейчас я держу его рукой за щёку, он не сопротивляется, анус его закрыт шпорами от потоков говна. В складках его фиолетовых щёк я обнаружил старый раскладной телефон Моторолла и баночку мочи. На нём 10 пропущенных вызовов от какого-то «Абупедалитто».\r\n Кто это такой ? И что мне с всем этим делать ?\r\n----------\r\nНе, это точно наш шизик. Ему реально доставляет срать на полупустой борде. Тем самым он дрочит свое воспаленное чувство значимости и корчит из себя дартаньяна. **ВОТ ТАКОЙ Я АХУЕННЫЙ ВСЕХ ЗАТРОЛЛЕЛ, А ЭТИ ФИМОЗНЫЕ ДОЛБОЕБЫ БУГУРТЯТ ОЛОЛО! ЭТО ЖЕ ТАК ОХУЕННО! ОНИ РЕАГИРУЮТ НА МОИ ПОСТЫ! У НИХ БУГУРТ!! ОЛОЛО**\r\n Ну ладно если это какой нибудь озлобленный хикка, а что если ололокающее быдло? Вы когда нибудь видели рака вживую? А я видел, целых четыре. Это быдло, но еще более мерзкое чем обычное, аморальное.\r\n----------\r\nНе хочу быть навязчивым и все же, давайте кое что проясним. Кто срет? Кто такой шизик? Шизик это не миф, и не мой форс. Шизик это собиртельный образ серуна. Петух который срет здесь постоянно, он же печально знаменитый ЗКП, он же утюговайпер. Последствия его разрушительной деятельности видны повсюду. Не ленитесь, полистайте доску и вы получите картину. Сплошь говнофорсы этого пидора. Причем форсы несут прямо таки враждебный характер. Например: Иначепетух, инач борда петухов, админ — ПОПАБОЛИК, недовольный анон — БУГУРТИК и т. д.\r\n Вот этот вот длиннющий список, это все его работа, инфа 90%. Как видите малолетний долбоеб преватил инчорг в свою песочницу. Кроме того, до недавнего времени его цель была задушить любые проявления разумной жизни здесь вообще. Стоит нам проявить хоть какую-то активность, начать выбирать маскот например, все идет по пизде.\r\n----------\r\nНе хочу быть навязчивым и все же, давайте кое что проясним. Кто срет? Кто такой шизик? Шизик это не миф, и не мой форс. Шизик это собиртельный образ серуна. Петух который срет здесь постоянно. Последствия его разрушительной деятельности видны повсюду. Не ленитесь, полистайте доску и вы получите картину. Сплошь говнофорсы этого пидора. Причем форсы несут прямо таки враждебный характер. Например: новостной петух, срать в колчок, админ — жилбисосака и т. д. Как видите малолетний долбоеб преватил колчорг в свою песочницу. Кроме того, до недавнего времени его цель была задушить любые проявления разумной жизни здесь вообще. Стоит нам проявить хоть какую-то активность, начать обсуждать новости например, все идет по пизде. жилбиняшу он заговнил своим семенством. Например, вайпал новости медскилзами: колчок засорился. Теперь же благодаря ему, предложения обсуждать новости уже никто и всерьез не воспринимает. Ну и хуй с ними, с новостями.\r\n----------\r\nОказывается, шизик был нанят не за 10 баксов на бирже, а за **КОРКУ СЫРА**. Sheezbusters собирают информацию. Похоже, петух-шизик совсем ебанулся. Он здесь очень давно срет. А в последнее время он как кость в глотке.\r\n----------\r\nА вообще во мне теплится надежда, что местным скоро надоест несмешно подъебывать срущего шизика, работающего за **КОРКУ СЫРА**.\r\n А если не надоест, то и похуй на них, петухов много, авось что-то и найдется.\r\n----------\r\nОх лол, что это больное животное кукарекает. Его же за километр можно детектить, только по одному запаху бубенцов из говна, которые он носит у себя на хвосте, лол.\r\n----------\r\nСобсна, сегодня у него было сезонное обострение редкий вид бешенства передается при ебле в жопу и его откровенно понесло. Теперь это больное животное возомнило себе, что может срать в любом треде, который вызывает у него анальное негодование. Ящитаю с этим нужно что-то делать, своим беснованием он парализует общение.\r\n ----------\r\n Почему админу **ПОХУЙ** на шизика? Ему не похуй, если я начну вайпать нулевую нигрой, он разобьет мне респиратор банхамером. Но вот серуна-шизоида почему-то не трогает. Помойму все очевидно.\r\n ----------\r\n Блядь опять **педальный шизик** семенит смотрите! Ты сука, зачем колчорг засираешь, уебок?\r\n ----------\r\n Уже есть несколько пидорнутых шизоидов. Шизик, ты будешь следующим.\r\n----------\r\nА шизик скрипя протезом ануса вайпает неугодные ему треды. Анус петуха почти выдержал, но там **ТАКОЕ** было написано.\r\n----------\r\nГАГАГА, шизик, да ты же смешной ПИДОР!\r\n----------\r\nАааа лол! ХУЙ выгрызи, уебище, выпроваживает он нас.\r\n----------\r\nСука блядь рубанул шизоида а попал по пальцу\r\n ----------\r\n Сука чистил шизоида рубанул по пальцу\r\n----------\r\nСука чистил шизоида рубанул по пальцу.\r\n Отрубил нахуй палец, потом через два года новый вырос.\r\n ----------\r\n Сука блядь шизика наебал на далары блядь\r\n ----------\r\nИду с топором сука шизoидов собираю, шизанутых блядь, под корень срезаю, нахуй вдруг выбегает **ШИЗOИД ПЕРЕРОСТОК** блядь сука блядь сука блядь **ШИЗOИИД НАХУЙ ВЫБЕГАЕТ Я КАК РУБАНУЛ БЛЯДЬ ШИЗOИДА СУКА БЛЯДЬ А-ХА-ХА СУКА РУБАНУЛ БЛЯДЬ ШИЗOИДА А ПОПАЛ ПО ПАЛЬЦУ НАХУЙ, ОТРУБИЛ БЛЯДЬ СУКА ПАЛЕЦ СЕБЕ**\r\n----------\r\nШизик по старой сосачевской привычке флюродросит админу за корку сыра. Лол.\r\n----------\r\nШизик это не миф, и не мой форс. Этот пидарас здесь очень давно срет. А последнее время, он как кость в глотке.\r\n----------\r\nНичего, скоро устраним шизика. Он здесь очень давно срет. А в последнее время он как кость в глотке.\r\n----------\r\nПочему вы ещё не пймали **ШИЗИКА**? Он затаился и срёт. Или вы ловите **ШИЗОЙДА** или я закрываю сайт.\r\n----------\r\nИли вы устраняете **ШИЗИКА**, или я закрываю сайт.\r\n----------\r\nКак **ШИЗОЙДУ** порвало **ЛОЛ**-ошметками его жопы закидало весь Колчорг\r\n Аааа лол! ХУЙ выгрызи, уебище, выпроваживает он нас. **ШИЗИК**, я не дам тебе создать даже видимость обсуждения, твое говно не будет обсуждаться. И все тут, в игнор ребенка.\r\n----------\r\n**ШИЗИК**, ТЫ СОВСЕМ ЕБАНУЛСЯ?\r\n----------\r\nСУКА, **ШИЗИК**, ТЫ ОПЯТЬ ОБОССАЛСЯ!\r\n----------\r\nШизик, я покараю тебя\r\n----------\r\n**КАКИЕ НОВОСТИ?**\r\n **ШИЗИК,** ТЫ СОВСЕМ ЕБАНУЛСЯ?\r\n У ТЕБЯ УЖЕ ВСЕ ПЕРЕД ГЛАЗАМИ ПЛЫВЕТ...\r\n ----------\r\n АРГХ ХУЙ ТЕБЕ ВЫПРОВАЖИВАЕТ ОН НАС. ГАГАГА, **ШИЗИК**, ДА ТЫ ЖЕ СМЕШНОЙ ПИДОР\r\n Аргх хуй тебе выпроваживает он нас. Гагага, шизик, да ты же смешной ПИДОР\r\n **Аргх хуй тебе выпроваживает он нас. Гагага, шизик, да ты же смешной ПИДОР**\r\n Аргх хуй тебе выпроваживает он нас. Гагага, шизик, да ты же смешной ПИДОР\r\n----------\r\nНе пытайся замаскироваться, я все равно найду тебя и обезврежу.\r\n----------\r\nЧто, **ШИЗИК**, попка **ВАВА**? Ошметками твоей жопы весь **ИНЧОРГ** закидало.\r\n----------\r\nСука, шизик, ты опять обосрался! **ВСЕ, ВЫЗЫВАЮ ОХОТНИКОВ!**\r\n ----------\r\n Шизик одел аватарку и пытается тралить охотников. Он копипастами пытаются скрыть свой жестокий бранденбург. Но я всё равно чувствую его дрожащие пальцы. Его дёргающиеся глаза.\r\n----------\r\nТвое говно не будет обсуждаться, можешь хоть головой биться об стену, **ШИЗОИД**. Sheezbusters карает срущих петухов.\r\n----------\r\nКампания по отлову ШИЗИКОВ объявляется открытой. Спасатели ИНЧОРГА карают срущих петухов даже на других сайтах. ШИЗИК, помни, мы покараем тебя, тебе не спрятаться.\r\n----------\r\nШизик где-то рядом, я знаю. Ему не спрятаться от правосудия ОХОТНИКОВ\r\n ----------\r\n Команда спасателей инчорга карает срущих петухов\r\n----------\r\nПривет, животное. Поешь говна. Было же на колчорге постановление, всех шизойдов карать хуем и нигрой.\r\n----------\r\nШизик где-то рядом, я знаю. Он вроде притих, но никуда не делся. Где мое ружье?\r\n----------\r\nГде мой **ШИЗБУРГЕР**?\r\n----------\r\n**ШОК!** Шизику не дают срать на Колчорге\r\n ----------\r\n **ШИЗИК, ТЫ МЕНЯ ДОЕБАЛ УЖЕ! ТАЩИТЕ МОЙ ПЛАЗМОМЕТ!**\r\n----------\r\nДа, я называю ШИЗИКА ШИЗИКОМ. **ШИЗИК**, МЫ ИДЕМ!\r\n----------\r\nСпасатели инчорга карают срущих шизиков-петухов\r\n----------\r\nКомпания Sheezbusters официально объявляет сезон охоты на **ШИЗИКОВ**!\r\n----------\r\nБА-БАХ - рвануло где-то в квартире шизика.\r\n ----------\r\n Шизик обосрался, блядь, дебилоид, скольк отебе платят за засирание инчорга? Тупая скотина пурупекальная, мудак блядь. Ненавижу азериков, вот выберут меня главным по стране закрою все азеропараши а отсюда пидорну сосаку-админа. Заживем сука.\r\n ----------\r\n НЕТ, Я ПРОСТО НЕ МОГУ НЕ УДЕРЖАТЬСЯ, ЧТОБЫ НЕ ПЛЮНУТЬ В ЛИЦО ЭТОМУ ПИДОРУ! В КОНЦЕ КОНЦОВ, Я ТРЕБУЮ ПРОДОЛЖЕНИЯ БАТТХЕРТА ПЕТУХА-ШИЗИКА!\r\n ----------\r\n -А кто ты такой, чтобы устанавливать правила итт?\r\n -**НЕТ, Я ПРОСТО НЕ МОГУ НЕ УЖЕРЖАТЬСЯ, ЧТОБЫ НЕ ПЛЮНУТЬ В ЛИЦО ЭТОМУ ПИДОРУ! В КОНЦЕ КОНЦОВ, Я ТРЕБУЮ ПРОДОЛЖЕНИЯ БАТТХЕРТА ПЕТУХА-ШИ3ИKA!**\r\n -Тсс, заткнись, хватит уже, а то он умрет!\r\n -**НУ ЛАДНО.**\r\n----------\r\nО чем это я. Ах да! Не пытайся переводить стрелки, ведь все мы знаем, что петух-шизик это ты, срущий петух шизик.\r\n ----------\r\n Шизик не смог ответить на вопрос и начал лепетать хуйню, иди в сраку долбись. Детектит он, срущий петух тупой, как ты с охотником разговариваешь? Твоё место у параши.\r\n ----------\r\n there's something strange\r\n in your imageboard\r\n Who ya gonna call?\r\n SHEEZBUSTERS\r\n \r\n If there's something fat\r\n and it don't look good\r\n Who ya gonna call?\r\n SHEEZBUSTERS\r\n \r\n I ain't afraid of no sheezeeks\r\n I ain't afraid of no sheezeeks\r\n \r\n If you're seeing sage\r\n running through your thread\r\n Who can ya call?\r\n SHEEZBUSTERS\r\n \r\n An extremely fat man\r\n writing in your thread\r\n Who ya gonna call?\r\n SHEEZBUSTERS\r\n I ain't afraid of no sheezeeks\r\n I ain't afraid of no sheezeeks\r\n \r\n Who ya gonna call?\r\n SHEEZBUSTERS\r\n \r\n If ya all alone\r\n pick up the phone\r\n and call\r\n SHEEZBUSTERS\r\n \r\n I ain't afraid of no sheezeeks\r\n I here it likes the anons\r\n I ain't afraid of no sheezek\r\n Yeah Yeah Yeah Yeah\r\n \r\n ----------\r\n You must obey the inach commander\r\n Forcin' the sheezeek for fun\r\n You must obey the inach commander\r\n You know that there's sheezeek one\r\n Who tracking sheezek here,\r\n Alright\r\n Who tracking sheezek here,\r\n Alright\r\n \r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n \r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n I wanna fight with him forever\r\n----------\r\nЗахожу я на колчорг\r\n Нулевая в говне вся опять\r\n Шизойд шизойд\r\n Его задача срать\r\n \r\n Он здесь очень давно срет\r\n Скоро этому будет конец\r\n Карать карать\r\n Будем хуем его\r\n \r\n И нигрой заодно\r\n Будем карать\r\n Срущего петуха\r\n \r\n ШИ3ИK! ШИ3ИK!\r\n Я покараю тебя\r\n ШИ3ИK!\r\n Что, ШИ3ИK, попка ВАВА?\r\n ШИ3ИK! ШИ3ИK!\r\n Хуем и нигрой карать\r\n ШИ3ИK!\r\n Смотрите он семенит опять!\r\n \r\n Он не миф и не мой форс\r\n Все мы знаем кто это такой\r\n Шизойд шизойд\r\n Наш срущий петух.\r\n \r\n Он здесь очень давно срет\r\n Скоро этому будет конец\r\n Карать карать\r\n Будем хуем его\r\n \r\n Привет, животное\r\n Поешь говна\r\n Караем петуха!\r\n \r\n ШИ3ИK! ШИ3ИK!\r\n Я покараю тебя\r\n ШИ3ИK!\r\n Что, ШИ3ИK, попка ВАВА?\r\n ШИ3ИK! ШИ3ИK!\r\n Хуем и нигрой карать\r\n ШИ3ИK!\r\n Смотрите он семенит опять!\r\n ----------\r\n У меня болезнь шизофрения\r\n Меня очень тянет на Колчан!\r\n Абупедалитто меня нанял,\r\n Чтобы я тут бесконечно срал.\r\n \r\n А я люблю тут срать!\r\n Всегда готов\r\n Движок шатать и форсить всякое говно.\r\n Ты, Абу, на это посмотри\r\n А потом мне корку сыра подари!\r\n \r\n А я люблю тут срать!\r\n Всегда готов\r\n Движок шатать и форсить всякое говно.\r\n Ты, Абу, на это посмотри\r\n А потом мне корку сыра подари!\r\n \r\n Пидорнутые, колчок, Куклёна\r\n Это всё моя работа, ха!\r\n Педалитто очень мной доволен,\r\n Я его любимый петухан!\r\n \r\n А я люблю тут срать!\r\n Всегда готов\r\n Движок шатать и форсить всякое говно.\r\n Ты, Абу, на это посмотри\r\n А потом мне корку сыра подари!\r\n \r\n А я люблю тут срать!\r\n Всегда готов\r\n Движок шатать и форсить всякое говно.\r\n Ты, Абу, на это посмотри\r\n А потом мне корку сыра подари!\r\n \r\n Меня называют «смешной пидор»,\r\n Я как кость в горлЕ у всех застрял!\r\n А недавно злой шизоохотник\r\n Мою корку сыра отобрал(\r\n \r\n А я люблю тут срать!\r\n Всегда готов\r\n Движок шатать и форсить всякое говно.\r\n Ты, Абу, на это посмотри\r\n А потом мне корку сыра подари!\r\n \r\n А я люблю тут срать!\r\n Всегда готов\r\n Движок шатать и форсить всякое говно.\r\n Ты, Абу, на это посмотри\r\n А потом мне корку сыра подари!\r\n----------\r\n**ШИЗИК**, ты? Понял что жиденько обделался и опять свою песенку запел?\r\n Впрочем это легко проверить сомневающимся — достаточно запилить фотожабу на тему срущего петуха и его родственности с сосачем, как тут же последует говношторм. Прекращай жоповынос мозга. Одно дело когда шизик сидит в своем треде и никому не мешает. А другое дело, когда он заполняет своим говном все обсуждения. Это даже хуже вайпа.\r\n----------\r\nШизик, ты даже не догадываешься, насколько ты имбицил. В твой поехавший мирок не закрадывались мылси, что времена меняются? Это же и произошль с насосачерами. А ты, тупое животное, думаешь, что это твоя заслуга. Ты ничего хорошего для нульчорга не сделал. И никогда не сделаешь. Ведь ты петух, который умеет только срать.\r\n----------\r\nБедный шизик из желания выебнуться и прослыть матерым троллем, начал пытыться троллировать охотников, и теперь не знает что ему со всем этим делать. Давайте приведем его к истине. Он героически срался с пастами.\r\n----------\r\nШОК!(18+) Шизики оказались под угрозой вымирания!\r\n Вглядитесь в глаза этого невинного шизёночка! Вам разве не хочется его приютить к себе домой, почесать ему брюшко, послушать его шизойдный бред? А озверевшие шизикхантеры хотят поймать и навердить этому прелестному шизикотёнку! Давайте не дадим им этого сделать. Подписывайте петицию и вступайте во фронт сопротивления шизикохантеров.\r\n----------\r\nОткуда они лезут?\r\n Сначала тостяк со своей мочей, теперь поехавший паранойный **ШИЗИК**. У меня уже закрадывается чувство, что кто-то очень не хочет чтобы Инач развивался и засылают к нам свою поехавшую братию для скатывания начинаний анона в срачи и сборники шизоидных высеров.\r\n ----------\r\n Сейчас он собирает остатки своего ануса и дрожащими руками печатает сочащийся болью ответ. НЕТ, не делай этого шизик, ведь твой анус не вечен, ты не сможешь все время притворяться йобой!\r\n Хватит унижаться, шизик, твой анус не вечен же!\r\n----------\r\nКто срет? Кто такой шизик? Шизик это не миф, и не мой форс. Шизик это собиртельный образ серуна. Петух который срет здесь постоянно. А кто тогда по твоему форсил обиженок?\r\n Эти пидарасы давно здесь кормятся. Раньше, когда зой был активен, их банили как заблудших сосачеров. Никто даже не разбирался, достаточно было знать, что это враги борды, засланные петухи. Зато сейчас, якобы ради соблюдения традиций /b/, принципов свободы, мы вынуждены терпеть набеги малолетних долбоебов. Понимаете как это выглядит? Лицемерие.\r\n Ящитаю так, банить и тереть надо шизоида, с этикой потом разберемся. Реквестирую бан **шизика**.\r\n----------\r\nКто срет? Кто такой шизик? Шизик это не миф, и не мой форс. Шизик это собиртельный образ серуна. Петух который срет здесь постоянно, он же печально знаменитый ЗКП, он же утюговайпер. Последствия его разрушительной деятельности видны повсюду. Не ленитесь, полистайте доску и вы получите картину. Сплошь говнофорсы этого пидора. Причем форсы несут прямо таки враждебный характер. Как видите малолетний долбоеб преватил колчорг в свою песочницу.\r\n Правда, недавно, шизоида начали опускать, причем конкретно. Все его треды вайпались и будут вайпаться, только не нигрой, нужно что-то менее навязчивое. Он сныкался, пытается строить из себя няшу. Попутно своим семенством дискредитирует всех кто против него, выставляет их поехавшими. Вряд ли ему кто-нибуь верит и все же. Я надеюсь, теперь понятно, кто такой шизик и чем он здесь занимается. Зрите в корень, господа.\r\n----------\r\nПосле небольшого затишья активность срущих детей набирает обороты. Нулевая опять в говне. Также, в последнее время наблюдается наплыв всяких непонятных личностей, якобы сосачеров. Но мы то знаем, чей это почерк...\r\n К вечеру появляется шизик и вайпает все подряд. Очевидно, малолетний долбоеб упивается своей безнаказанностью. И в очередной раз, мы реквестируем забанить петуха, ибо нехуй.\r\n Из других новостей.\r\n Спешите видеть. Апогей долбоебизма.\r\n Появляется какой-то хуй с горы и говорит, что он шизик. ВНЕЗАПНО, вся нечисть колчрга вылазит из под шконки и рассказывает ковры охуительных историй, про то как они стонут под гнетом охотника. nuff said\r\n----------\r\nА где колкун? Я не понимаю, неужели так трудно потереть все говно с нулевой, да перебанить срущих петухов? ШИТО так и будем бегать от двух с половиной раков, давайте уже анально подавим их чтоле. Если анон не может задавить игнором пидарасов и всячески ведется на их провокации, так быть великим репрессиям. Должно же быть какое то противодействие, нет? Потому что существует такой сорт людей — долбоебы, критическая масса при которой начинается пиздец: двое. Шизик постит свои высеры, и тут же какой-нибудь школяр начинает его подъебывать и стебаться, начинается говношторм Впрочем мне кажется что даже если все вдруг станут игнорировать поехавшего он будет семенить и загаживать треды своей поехавшей пастой, т.к. для вниманиеблядка главное чтобы на него обращали внимание.\r\n----------\r\nНьюфаги Инача, если вы видите сумасшедшие или просто идиотские посты такого >>1729723 содержания, то знайте, что это наш местный анальный клоун. Пытаться разговаривать с ним адекватно и по делу — абсолютно бесполезно, его посты следует либо игнорировать, либо отвечать на них этим текстом, ничего остального этот мелкий дурачок не заслуживает. Уринофорсер, мы все уже давно поняли, что ты уёбок. Мы основали эту борду как убежище от сосаки и МДКбыдла, сюда ушло небольшое количество анонов в поисках ламповости и анонимного счастья. Мы будем продолжать игнорировать твои говнопасты и семёнство с сажей, клепать годноту, ориджинал и развивать эту борду, а ты продолжай себе беситься, твои потуги выглядят действительно жалко и смешно.\r\n----------\r\nТо что сейчас на нулевой даже по меркам инача пиздец. Админ типо у нас похуист. Хотя на самом деле это у него такая извращенная форма вниманиеблядства. Шизоблядок никак не угомонится со своим говном, никто не одобрял.\r\n----------\r\nСпустя полтора часа. Градус неадеквата зашкаливает, кто-то вайпает тред. Как видите, все признаки шизоида на лицо. Судя по реакции шизика можно предположить, что охота идёт очень удачно. Очень удачно. Она разрывает жопу у всех 3,5 хейтеров инчорга. Отсюда яростные попытки как-то заговнить образ.\r\n----------\r\n**Шизик постит свои высеры, и тут же какой-нибудь школяр начинает его подъебывать и стебаться, начинается говношторм.** Впрочем мне кажется что даже если все вдруг станут игнорировать поехавшего он будет семенить и загаживать треды своей поехавшей пастой, т.к. для вниманиеблядка главное чтобы на него обращали внимание.\r\n----------\r\nСука, шизик, если не перестанешь срать — прокляну нахуй!\r\n ----------\r\n Блядь опять педальный шизик семенит смотрите! Ты сука, зачем колчорг засираешь, уебок-заебок?\r\n ----------\r\n Обычно я не вступаю в диалог с поехавшим. Но такую ересь просто невозможно проигнорировать. Нельзя позволять петуху даже думать о том, что он кого-то здесь троллирует.\r\n Слышишь, шизоид. Твои треды будут вайпаться, и не потому что ко-ко-плохие, а потому что они не несут никакого смысла. Все твои школовойны с комбайнами, говнофорсы, попаболики, бугуртики обычный мусор. Этого мусора стало слишком много. Как бы там ни было, я люблю инчорг. Именно поэтому сделаю хоть что-то, чтобы воспрепятствовать засиранию. Я не дам тебе создать даже видимость обсуждения, твое говно не будет обсуждаться. И все тут, в игнор ребенка.\r\n----------\r\nНельзя позволять петуху даже думать, что он кого-то здесь троллирует. **Слышишь, шизоид.** Твои треды будут вайпаться, и не потому что ко-ко-плохие, а потому что они не несут никакого смысла. Все твои школовойны с калкиным, говнофорсы, котятки, минусы обычный мусор. Этого мусора стало слишком много. Как бы там ни было, я люблю колчорг. Именно поэтому сделаю хоть что-то, чтобы воспрепятствовать засиранию. Я не дам тебе создать даже видимость обсуждения, твое говно не будет обсуждаться. И все тут, в игнор ребенка.\r\n----------\r\nНе хочу быть навязчивым и все же, давайте кое что проясним. Кто срет? Кто такой шизик? Шизик это не миф, и не мой форс. Шизик это собиртельный образ серуна. Петух который срет здесь постоянно, он же печально знаменитый ЗКП, он же утюговайпер. Последствия его разрушительной деятельности видны повсюду. Не ленитесь, полистайте доску и вы получите картину. Сплошь говнофорсы этого пидора. Причем форсы несут прямо таки враждебный характер. Как видите малолетний долбоеб преватил инчорг в свою песочницу.\r\n Правда, недавно, шизоида начали опускать, причем конкретно. Все его треды вайпались и будут вайпаться, только не нигрой, нужно что-то менее навязчивое. Он сныкался, пытается строить из себя няшу. Попутно своим семенством дискредитирует всех кто против него, выставляет их поехавшими. Вряд ли ему кто-нибуь верит и все же, Фантомас уже в пролете. Я надеюсь, теперь понятно, кто такой шизик и чем он здесь занимается. Зрите в корень, господа.\r\n----------\r\nКолчаньки!\r\n Во-первых, банить никого нельзя. Обойти бан очень легко, а это повод орать про модерастию.\r\n Во-вторых, про ЗКП. Вы что, совсем охуели? Эту идиотскую пасту может распространять любой дебил. С творчеством ЗКП вы можете ознакомиться на мелкобордах, вы поймёте, что тот петух-шизик, кто срёт у нас, к ЗКП отношения не имеет.\r\n В-третьих, необходимо крайне осторожно относиться к мочедискурсу, а лучше избегать его вовсе.\r\n Что такое мочедискурс? Это обсуждение таких сущностей и понятий, как:\r\n \r\n >Оланет\r\n >Мочерастия\r\n >Пидорнутые\r\n >Оппозиция\r\n >Очкопетух\r\n >Параша (в значении «АИБ»)\r\n \r\n В-четвертых, если Колчорг является вашим домом, не стоит полагаться на лехаскрипт. Фильтр может защитить вас, но дерьмо от этого никуда не денется.\r\n Раз уже стало ясно, что на борде завелись срущие петухи, то будьте начеку.\r\n----------\r\nЖилби, забань срущего петуха. Никакого баттхёрта, просто спам действительно должен удаляться. В целом в мире существует общее неодобрение использования средств коммуникации не по назначению, и законы против этого.\r\n----------\r\n Сидеть здесь с этим шизойдом просто унизительно тупорылый пидор таким образом развлекается, неужели так трудно понять кто здесь срет, спасатели, думаете до вас никто не пытался что-то с этим сделать срет зой поэтому все бестолку, нет никаких заговоров.\r\n----------\r\nЭй, спасатели! Думаете до вас никто не пытался что-то с этим сделать? Неужели так трудно понять кто здесь срет? Срет зой. Поэтому все бестолку. Нет никаких заговоров, тупорылый пидор таким образом развлекается. Сидеть здесь с этим шизойдом просто унизительно.\r\n----------\r\nНе пытайся переводить стрелки, ведь все мы знеаем, что петух-шизик это ты, срущий петух шизик. Беспросветно тупой пидор, у которого Баттхерт - единственный аргумент в споре. Понимаешь, ты животное. Никакoго баттхерта.\r\n----------\r\nНе надоело? Шизик здесь только ты. Ты можешь перевести стрелки, но это ничего не изменит. Ты можешь сказать что мой пост сочится бугуртом, но это тоже ничего не изменит. Потому что все мы знаем, что это есть почерк тупорылого хуесоса-шизика. Ты не можешь в спор, не можешь в аргументы, не можешь в мэдскилзы, не можешь в пасты. Все твое оружие это мелкобуквенные йоба-высеры вроде: ололо у тебя баттхерт, карочи все кто против миня шизики. Непрошибаемый тупой пидор, который даже не может толком обозначить свою позицию. Чего ты хочешь? Тебе нравится внимание? Нравится когда тебя кормят говном? Шизоид. Тебе никогда не избавиться от этого клейма. Кинул кирпичом в дегенерата.\r\n----------\r\nПришли охотники и открыли всем на глаза на того, кто **СРЕТ** на Колчане своими форсами слонима.\r\n Брысь отсюда, **ШИЗОИД**. Мы не дадим тебе **СРАТЬ** на Колчане, шизик, поэтому твое говно не будет обсуждаться. Все, в игнор шизоида.\r\n ----------\r\n Кто срет? Кто такой шизик? Шизик это не миф, и не мой форс. Шизик это собиртельный образ серуна. Петух который срет здесь постоянно, он же печально знаменитый ЗКП, он же утюговайпер. Последствия его разрушительной деятельности видны повсюду. Не ленитесь, полистайте доску и вы получите картину. Сплошь говнофорсы этого пидора. Причем форсы несут прямо таки враждебный характер.\r\n Слышишь, шизойд. Все твои школовойны с калкиным, говнофорсы, котятки, минусы обычный мусор. Этого мусора стало слишком много. Как бы там ни было, я люблю колчорг. Именно поэтому сделаю хоть что-то, чтобы воспрепятствовать засиранию. Я не дам тебе создать даже видимость обсуждения, твое говно не будет обсуждаться. И все тут, в игнор ребенка.\r\n----------\r\nА ведь я по сути создал отличный тред. Даже треды. Хороший или плохой — таких на Иначе нет. Как на нем нет и морали. Но вот создать интересный тред — это да. Чего стоит несколько разорванных пердаков шизоидов, чующих угрозу для своих анусов. Поэтому, я делаю интересные треды. Может с Инача съебать вам?\r\n ----------\r\n Ну вот, шизоид ВНЕЗАПНО какбе излагает нам свою позицию. На лицо неуважение к борде и ее контингенту в частности. Отныне и навсегда, официально нарекаю тебя, шизик, Первым Петухом Колчана. Всем кто вступит в диалог с петухом, в качестве наказания, предписывается анальное порицание. Да будет так.\r\n ----------\r\n > Шизик = Абу. Шизик, потому что раздвоение личности (Абу и Педалик) и бредни о каких-то врагах двача.\r\n Вот и можно подвести итоги. Мы создали всего лишь один тред, а пуканы полопались у всего Инача. Ну если не нравится тред, так пропусти его, скрой куклоскриптом. Так нет, полилась нелепая толстота, гнев, ненависть и т.п. К чему это все?\r\n----------\r\nУже подмечено, как у нас заводится срущий петух общение стопорится. Надо признать оно и без того крайне-вялое.\r\n Кстати. Модер здесь. По крайней мере вчера был точно. Спалился за чисткой говна с нулевой.\r\n Такой вопрос. Какого хуя он бездействует? Ведь от него все зависит. Ему что вообще насрать на анона? Почему перестал выполнять реквесты? Чем он занимался последнее время, повесил какое-то пафосное чучело на главную и съеб. А тот ли это изой вообще?\r\n Нет, ну возможно я накручиваю. Но а что если колчан купили?\r\n----------\r\n**Внимание. Сафари на шизика! Спешите видеть бессильную злобу опущенца!**\r\n 7 февраля 2013\r\n **Активная фаза боёв с шизойдом.**\r\n Утро: шизик просыпается и видит, что его идеальный Инач ночью нарушили злобные охотники. С дебильной ухмылкой животное строчит высер и терпеливо ждет ответа на него.\r\n День: Через несколько часов приходит охотник и вайпает все говно к ебаной матери.\r\n Вечер: Шизопетух продолжает унижаться. Пилит тред от имени попозиции и неуклюже там семенит. Приходит охотник и вайпает все к хуям собачьим. Тем временем, анус шизика распадается на атомы. Ждём новых событий с передовой.\r\n----------\r\nМы могли бы собраться и начать унижать **шизойдов-узурпаторов** прямо здесь на ихней территории. Но вам же как обычно похуй. Вы же **СОЛИДНЫЕ ЛЮДИ**, все при делах да на лексусах, какое вам дело да каких то школоразборок поехавших. Конечно, будем дальше жрать говно и смотреть как дебил засирает доску, ведь похуй же! Ящитаю похнафсе удел недалекого быдла. Похуистом быть легко, куда легче чем пытаться делать **ХОТЬ ЧТО-ТО**.\r\n----------\r\nМы могли бы собраться и начать унижать шизойдов-узурпаторов прямо здесь на ихней территории. Но вам же как обычно похуй. Вы же СОЛИДНЫЕ ЛЮДИ, все при делах да на лексусах, какое вам дело да каких то школоразборок поехавших. Конечно, будем дальше жрать говно и смотреть как дебил засирает доску, ведь похуй же! Ящитаю похнафсе удел недалекого быдла. Похуистом быть легко, куда легче чем пытаться делать ХОТЬ ЧТО-ТО.\r\n Он вроде бы не постил каждый день по три треда с омерзительными поющими бабками, залго-собаками, призывами возвращаться на двач. Так почему же его с лютым срачем забанили за засирание борды шизоидным бредом, а здесь вы молчите? Причем здесь комфорт? Скорее речь идет о выживании, ведь колчорг гораздо более уязвим для засирания. Некоторое время назад здесь было по 500 постов и пусть даже если 200 из них срущий семен-шизик, все равно раньше было больше народу. Или ты и это станешь отрицать?\r\n----------\r\nКоманда спасателей инчорга карает срущих петухов!\r\n **МЫ БУДЕМ КАРАТЬ ВСЕХ ШИЗИКОВ НА ИМИДЖБОРДАХ И ИНФОРМАЦИОННЫХ РЕСУРСАХ.**\r\n----------\r\nДумаешь что сможешь укрыться от меня в своём шизомирке, петух? Я тебя всё-равно найду и обезврежу. Хуй тебе, а не срать на колчорге.\r\n----------\r\nНу, ты, анонимус. Ты понимаешь вообще, что ты делаешь или уже просто тупо жмешь на кнопочки? Какой нахуй аним-лимон, блядь, тупица? Ты что, блядь, шизоид, ШИЗИК! Какой нахуй легион, что, шизик, попка ВАВА? Совсем уже ебанулся со своим лигивоном, анонимный быдлан.\r\n----------\r\nОх лoл, что это больное животное кукарекает. Его же за километр можно детектить, только по одному запаху бубенцов из говна, которые он носит у себя на хвосте, лол.\r\n Я тут, господа, подумал. Раз уж петух не хочет съебать добровольно, таки может выделим ему раздел-парашу? Пусть там срет, а в /b/ его забаним нахуй.\r\n----------\r\nБез сомнения — главный агент мочи или даже сам сосака — администратор этого сайта. Все свидетельствует в его сторону: спижженный у сосаки скрипт, треды удалять нельзя — что ты, аноним, ты же тварь дрожащая, буду сохранять все твои треды чтобы ничего не пропало, охотник следит, но следят за ним.\r\n Вся борда заселена **срущими шизиками**, нанятыми за 10 баксов на бирже, их задача — срать срать, срать.\r\n Каждый день каждый час, о стоит на распростершемся плоту, создается треды с говнофорсами этого петуха. Они беспощадно камвхорят на нулевой.\r\n Рекомендую всем беднягам-анонимам воздержаться от постинга в ближайший день, команда спасателей будет разбираться в деяниях мочи.\r\n----------\r\nF.A.Q от Охотников на шизиков\r\n \r\n В) Как вы находите шизиков?\r\n О) Очень просто, их легко определить по речи... Стой, ты ведь тоже шизик. Ах ты, сука, я тебя пристрелю сейчас, петух срущий! **ШИЗИК**!\r\n \r\n В) Что вы делаете с Шизиками?\r\n О) Мы их **СПАСАЕМ**\r\n \r\n В) Что сейчас делает шизик?\r\n О) Как обычно, не пьет таблетки.\r\n----------\r\nДо явления говна, анона было больше. Он вроде бы не постил каждый день по три треда с омерзительными поющими бабками, залго-собаками, призывами возвращаться на двач. Так почему же его с лютым срачем забанили за засирание борды шизоидным бредом, а здесь вы молчите? Причем здесь комфорт? Скорее речь идет о выживании, ведь колчорг гораздо более уязвим для засирания. Некоторое время назад здесь было по 500 постов и пусть даже если 200 из них срущий семен-шизик, все равно раньше было больше народу. Или ты и это станешь отрицать?\r\n ----------\r\n Тут понимаете какое дело, насколько наш петух вероломен?\r\n Правда, недавно, шизоида начали опускать, причем конкретно. Все его треды вайпались и будут вайпаться, только не нигрой, нужно что-то менее навязчивое. Он сныкался, пытается строить из себя няшу. Попутно своим семенством дискредитирует всех кто против него, выставляет их поехавшими. Вряд ли ему кто-нибуь верит.\r\n И все же, меня гложет одна мысль. Когда здесь всплывал некий пидарейму бурление говн было нешуточное. Все дружно ратовали за бан шизика, ЗКП занесли в спамлист. Потом сразу убрали, что странно. В общем пидорнули инородное тело люто бешено.\r\n Что же мы имеем видеть сейчас. Группа семенов-шизиков заговнили всю нулевую, скатили все годные треды своим вайпом, и всем похуй абсолютно! Где админ? Где эти пидарасы, которые так дружно орали: АБУ ЗАБАНЬ!! Где они сейчас? Вайпают нулевую скорее всего...\r\n----------\r\nАпрувер, почему ты покрываешь шизопетуха? Или ты тоже ШИЗИК?\r\n **Ты, говнорылое узомбище, дитя пидора и шлюхи, пиздопротивное пубертатное недоразумение, смеешь говрить, что Я засираю борду?? Каким образом? Разоблачение заговора не есть что-то плохое, пидор.**\r\n **Сейчас бесполезно будет что-то выяснять, шизоид слишком активен. Но судя по бурлению говн мы наступили кому-то на хвост.**\r\n ----------\r\n Какого **ХУЯ** ты не одобрил ещё ни одной новости про то, что на колчорге орудует **срущий петух-шизик?** Причем он здесь очень давно срет. А в последнее время он как кость в глотке.\r\n";
        var gneeds = "Гниданус-гниданус...\r\n----------\r\nкнайвс — хуй посасайвс\r\n----------\r\n**ПРРРРРРРРРРРР­РРРРРРРРРРРРРРРРРРР ПОСРАЛ НА ГНИДСА**\r\n********\r\n----------\r\nГАГАГА, **ГНИДС**, ДА ТЫ ЖЕ СМЕШНОЙ **ПИДОР!** ХУЙ ВЫГРЫЗИ, УЕБИЩЕ! ДОХУЯ ПАРАШ ВЫПИЛИЛ, ШИЗИК?\r\n----------\r\n**ГНИДС**, **ГНИДС**! Латышское хуйло беззубое.\r\n----------\r\n**Гниданус**, пшел вон с моего **КОЛЧОРГА**!\r\n----------\r\nГнидс-гнидс, объелся тухлых яиц!\r\n----------\r\nААА **ЛОЛ**! **ХУЙ** выгрызи, **УЕБИЩЕ**, прогоняет нас он!\r\n----------\r\n**ПССССССССССССССССССССССССС ОБОССАЛ ГНИДАНУСА**\r\n********\r\n----------\r\n**ГНИДАНУС-ГНИДАНУС...**\r\n*********\r\n";
        
        var PSSS = ['**ПССССССССС, обоссал чмошку**', '**ПССССССССС, обоссал маньку**', '**ПССССССССС, обоссал опущенку**', '**ПССССССССС, обоссал чмошек**', '**ПССССССССС, обоссал опущенок**', '**ПСССССССССССС, окропил уриной ротешник**\0\0\0', '\0\0**маньке**', '**ПСССССССССССС, окропил уриной ротешник**\0\0\0', '\0\0**чмошке**', '**ПСССССССССССС, окропил уриной ротешник**\0\0\0', '\0\0**опущенке**', '**ПСССССССССССС, залил ротешник ненасыт-**\0\0\0', '\0\0**ной маньке до краев**', '**ПСССССССССССС, залил ротешник ненасыт-**\0\0\0', '\0\0**ной чмошке до краев**', '**ПСССССССССССС, залил ротешник ненасыт-**\0\0\0', '\0\0**ной опущенке до краев**', '**ПСССССССССССССССС, обоссал всех в**\0\0\0', '\0\0**этом треде**', '**ПССССССССССССССС, выдал дневную порцию**\0\0\0', '\0\0**сосачерам**', '**ПССССССССССССССССССССССССССССССССССССС**' ];

	
        var PRRR = [ '**ПРРРРРРРРРРРРРРРРРРР, НАСРАЛ В**', '**ПРРРРРРРРРРРРРРРРРРР, НАСРАЛ В**', '**ПРРРРРРРРРРРРРРРРРРР, НАСРАЛ В**', '**ПРРРРРРРРРРРРРРРРРРРРР, ОПУСТИЛ ТЯЖЕ-**',  '**ПРРРРРРРРРРРРРРРРРРРРР, ОПУСТИЛ ТЯЖЕ-**',  '**ПРРРРРРРРРРРРРРРРРРРРР, ОПУСТИЛ ТЯЖЕ-**',  '**ПРРРРРРРРРРРРРРРРРРРРРРРРР, НАВАЛИЛ**', '**ПРРРРРРРРРРРРРРРРРРРРРРРРР, НАВАЛИЛ**', '**ПРРРРРРРРРРРРРРРРРРРРРРРРР, НАВАЛИЛ**', '**ПРРРРРРРРРРРРРРРРРРРРРРРРРРРРР, НАКОР-**', '**ПРРРРРРРРРРРРРРРРРРРРРРРРРРРРР, НАКОР-**', '**ПРРРРРРРРРРРРРРРРРРРРРРРРРРРРР, НАКОР-**', '**ПРРРРРРРРРРРРРРРРРРРРРРРРРРР БУЛЬК**\0\0\0', '\0\0**ПФФФФФФФФФФФСССССССССССССССССССССРРРРРРРРР, ЖИДЕНЬКОЕ ПОШЛО**', '\0\0**ПФФФФФФФФФФФСССССССССССССССССССССРРРРРРРРР, ЗАЛИЛ РОТЕШНИК ЧМОШКЕ ЖИДЕНЬКИМ**', '\0\0**ПФФФФФФФФФФФСССССССССССССССССССССРРРРРРРРР, ЗАЛИЛ РОТЕШНИК МАНЬКЕ ЖИДЕНЬКИМ**', '\0\0**ПФФФФФФФФФФФСССССССССССССССССССССРРРРРРРРР, ЗАЛИЛ РОТЕШНИК ОПУЩЕНКЕ ЖИДЕНЬКИМ**', '\0\0**ПФФФФФФФФФФФСССССССССССССССССССССРРРРРРРРР, НАЛИЛ ЖИДЕНЬКОГО НА НЕНАСЫТНУЮ РОЖУ МАНЬКЕ**', '\0\0**ПФФФФФФФФФФФСССССССССССССССССССССРРРРРРРРР, НАЛИЛ ЖИДЕНЬКОГО НА НЕНАСЫТНУЮ РОЖУ ЧМОШКЕ**', '\0\0**ПФФФФФФФФФФФСССССССССССССССССССССРРРРРРРРР, НАЛИЛ ЖИДЕНЬКОГО НА НЕНАСЫТНУЮ РОЖУ ОПУЩЕНКЕ**', '\0\0**ПФФФФФФФФФФФСССССССССССССССССССССРРРРРРРРР, ОБЛИЛ ЖИДЕНЬКИМ ОБВАФЛЕННЫЙ РОТЕШНИК ОПУЩЕНКИ**', '\0\0**ПФФФФФФФФФФФСССССССССССССССССССССРРРРРРРРР, ОБЛИЛ ЖИДЕНЬКИМ ОБВАФЛЕННЫЙ РОТЕШНИК МАНЬКИ**', '\0\0**ПФФФФФФФФФФФСССССССССССССССССССССРРРРРРРРР, ОБЛИЛ ЖИДЕНЬКИМ ОБВАФЛЕННЫЙ РОТЕШНИК ЧМОШКИ**', '\0\0**ПФФФФФФФФФФФСССССССССССССССССССССРРРРРРРРР БУЛЬ БУЛЬ БУЛЬ**', '\0\0**ПФФФФФФФФФФФСССССССССССССССССССССРРРРРРРРР БУЛЬ БУЛЬ БУЛЬ БУЛЬ ПФФФФССССССССРРРРРРРРРР**' ];
        
	var PRR2 = [ '**РОТЕШНИК ЧМОШКЕ**', '**РОТЕШНИК ОПУЩЕНКЕ**', '**РОТЕШНИК МАНЬКЕ**', '**ЛЫЙ ГРУЗ НА РОЖУ ОПУЩЕНКЕ**', '**ЛЫЙ ГРУЗ НА РОЖУ МАНЬКЕ**', '**ЛЫЙ ГРУЗ НА РОЖУ ЧМОШКЕ**', '**ГОВНА НА ОБВАФЛЕННЫЙ РОТЕШНИК МАНЬКЕ**', '**ГОВНА НА ОБВАФЛЕННЫЙ РОТЕШНИК ЧМОШКЕ**', '**ГОВНА НА ОБВАФЛЕННЫЙ РОТЕШНИК ОПУЩЕНКЕ**', '**МИЛ НЕНАСЫТНУЮ МАНЬКУ**', '**МИЛ НЕНАСЫТНУЮ ЧМОШКУ**', '**МИЛ НЕНАСЫТНУЮ ОПУЩЕНКУ**' ];
	
	
		var copro = "Объясняю. У меня В ЖОПЕ между булок всё время и постоянно сохраняется влажная, липкая и скользкая среда! Если просунуть руку между булок, то рука будет скользить, как в масле! И запах там естественно соответствующий, сильно воняет гомном! Это физиологическая особенность моего организма, и с этим уже ничего не сделаешь, и никакая ванная тут не поможет. Я пойду хорошо помоюсь, а через полчаса всё восстановится на место!\r\n \r\n ----------\r\n Во у меня ЖОПА ВОНЮЧАЯ! Перед тем, как стирать трусы, я их снимаю и смотрю изнутри. Там где ЖОПА с ними соприкасается всегда есть коричневая полоска — это следы моей гомнистой и влажно-липкой среды между булок. Часто бывает, что во время ходьбы я чувствую, как булки скользят друг о дружку, а между ними мне кажется что всё бурлит и хлюпает от вонючей влаги!\r\n \r\n ----------\r\n Класс! Мне очень нравится засовывать пальцы девушке В АНУС и медленно и аккуратно ковыряться там! При этом другой рукой я НАДРАЧИВАЮ ЧЛЕН. Мой личный рекорд — 4 (четыре) пальца В ОЧКО! Сначала я сложил пальцы в пучок и просунул их В ОЧКО, затем внутри распрямил их и двинул ладонь ещё глубже. Потом хотел засунуть и пятый большой палец, но девушке стало больно, и я не стал это делать. Я мечтаю засунуть девушке В ОЧКО ВСЮ ЛАДОНЬ ЦЕЛИКОМ. Это называется анальный фистинг.\r\n \r\n ----------\r\n Сначала я буду ЛИЗАТЬ ТВОЮ ЖОПУ языком. Ты можешь даже сходить в туалет посрать, а ЖОПУ не вытирать, и сразу прийти ко мне. Я ВЫЛИЖУ ТВОЮ ЖОПУ ВМЕСТЕ С ОСТАВШИМСЯ ГОМНОМ. Затем я просуну свою ладонь тебе В ЖОПУ между булок, а когда пальцы упрутся в анус, то начну медленно водить ладонью вверх-вниз, от копчика и до промежности. Потом стану засовывать пальцы тебе В ОЧКО, сначала один, потом два, каждый раз вынимая и облизывая их во рту! Ну а затем собиру пальцы вместе в пучок и туго, но аккуратно всуну тебе В ОЧКО. Когда пальцы войдут полностью, я их распрямлю и продвину ладонь вглубь ЖОПЫ по самое запястье! И пальцами начну шурудить внутри! Тебе должно очень понравиться!\r\n \r\n ----------\r\n А, вот ещё одна фантазия пришла в голову. Что будет, если ты захочешь срать, но терпеть сможешь, а я начну засовывать пальцы, а потом и всю ладонь тебе В ОЧКО? Пробовала когда-нибудь такое? Если ГОМНО полезет наружу прямо по моей руке — это будет СУПЕР!\r\n \r\n ----------\r\n А ещё я часто пукаю, то есть пердю, и сдерживаюсь только дома за столом если не один. Наверно потому у меня и ЖОПА ТАКАЯ ВОНЮЧАЯ, что смазывается газами! Пердю я не столько громко, сколько вони очень много! Зимой, когда окно и форточка закрыты, я могу напердеть так, что в комнате трудно будет дышать, хоть противогаз одевай. А ты часто пердишь? У тебя ЖОПА пердячая? Я ХУЙ ДРОЧУ на твои фотки каждый день!\r\n \r\n ----------\r\n Я хочу, чтобы ты начала срать стоя, а я пристроюсь сзади, присяду, и лицо моё окажется возле твоей ЖОПЫ, и буду наблюдать, как выходит ГОМНО! Могу подставить руки и набирать кучу, а затем начну размазывать ГОМНО ПО ТВОЕЙ ЖОПЕ. И будет, что называется, ЖОПА В ГОМНЕ в прямом смысле! Ништяк!\r\n \r\n ----------\r\n Дальше можем заняться обычными ласками и обоюдным оральным сексом в позе 69 или валет — я снизу, а ты на меня сверху. Ты у меня СОСЁШЬ, а я у тебя ВЫЛИЗЫВАЮ.\r\n \r\n ----------\r\n Я у тебя могу ЛИЗАТЬ и одновременно ковыряться пальцами В ГРЯЗНОЙ И ГОМНИСТОЙ ЖОПЕ.\r\n \r\n ----------\r\n Если я обмажу свой ХУЙ толстым слоем ГОМНА, ты его будешь СОСАТЬ?\r\n \r\n ----------\r\n Я скажу, что хочу срать. Сниму трусы и скажу — ЛИЖИ МОЮ ВОНЮЧУЮ СРАКУ! Я хочу, чтобы ты легла на спину, а я сяду голой СРАКОЙ на твоё лицо и начну ёрзать в разные стороны. А ГОМНО тем временем так и просится наружу! Я скажу — открой рот. Я сяду ОЧКОМ прямо на рот и стану выдавливать ГОМНО ИЗ СРАКИ. Вскоре на твоём лице большая куча! Затем я сяду СРАКОЙ вплотную на лицо, и от этого ГОМНО ещё больше размажется в стороны. ВОНЬ БУДЕТ ЖУТКАЯ! Предупреждаю.\r\n \r\n ----------\r\n Я бывает хожу СРАТЬ и по 2, а иногда и 3 раза в день. Но это, в основном, когда холодно и есть хочется много! А летом наоборот, больше пью, а ем раз в день и мне достаточно. И ещё смотря что поесть. Обычно у меня первые какашки выходя длинные и толстые! Размазываться должны хорошо. И ОЧЕНЬ ВОНЮЧИЕ!\r\n У меня первые какашки выходят длинные и толстые! Размазываться должны хорошо. И ОЧЕНЬ ВОНЮЧИЕ!\r\n \r\n ----------\r\n Шалить мы будем так — сначала я буду у тебя ЛИЗАТЬ, потом ЕБАТЬ во все отверстия, ну а потом СРАТЬ И ССАТЬ друг на друга! Каждый из нас обмажется ГОМНОМ ПОЛНОСТЬЮ с головы до ног, и в таком положении мы ляжем спать! Мне бы так хотелось! Только где это можно сделать? Простыню потом выбрасывать придётся, а ГОМНО к утру засохнет и кожа пропитается запахом!\r\n \r\n ----------\r\n Я как-то пытался понюхать своё ГОМНО, и слишком близко не смог поднести нос. ВОНЬ НЕСТЕРПИМАЯ!!!!! Как ты это всё будешь нюхать и кушать?\r\n \r\n ----------\r\n А если мы оба насрём одновременно? ВО КУЧА БУДЕТ!!!!!\r\n \r\n ----------\r\n Ты меня любишь?\r\n \r\n ----------\r\n Я хочу ГОМНА! МНОГО ГОМНА!\r\n \r\n ----------\r\n Я итак всё время на твои фотки ХУЙ ДРОЧУ, привыкаю к тебе! Вот ещё одна фантазия на тему ГОМНА. Мы с тобой сделаем так — когда оба сразу захотим срать, то будем валить ГОМНО в одну общую кучу! Ну чтобы действительно много было! Потом я аккуратно возьму тебя сзади за волосы, собрав их все в пучок на затылке, и окуну лицом прямо в эту огромную КУЧУ ГОМНА! Вся твоя голова должна оказаться В ГОМНЕ! Во будет здорово! Как же я этого хочу! Поверь, ради этого стоит ждать моего отпуска в марте!\r\n \r\n ----------\r\n Скинь новые фоточки!\r\n \r\n ----------\r\n Я срать хочу! Сейчас ещё что-нибудь съем и пойду.\r\n \r\n ----------\r\n Будешь мне каждый раз вытирать ВОНЮЧУЮ СРАКУ своим языком вместо туалетной бумаги! И я тебе тоже!\r\n Хочу в Нижний Новгород!\r\n \r\n ----------\r\n Ты когда срала последний раз?\r\n \r\n ----------\r\n Меня больше всего в голой дамочке восхищает и возбуждает её ЖОПА и разрез между булок от копчика и до промежности! А потом уже всё остальное. Поэтому мне нравится всё, что связано с ЖОПОЙ — ковыряние там пальцами, анальный секс, анальный фистинг (всю ладонь В ЖОПУ) и ГОМНО, которое является продуктом ЖОПЫ. По-моему всё логично! А у тебя большая и красивая ЖОПА — ЖОПИЩА\r\n \r\n ----------\r\n Да, СРАКА у тебя огромная, это видно по фото, где ты в джинсовой юбке! Я представляю что будет, если ты встанешь РАКОМ, выпятив СРАКУ кверху и прогнув спину! Это должен быть полный ахуй, и твоя СРАКА должна стать шире раза в два!\r\n \r\n ----------\r\n Ну вот ты сидишь СРЁШЬ на меня, а я сортирую твоё ГОМНО! Думаю, что его будет много! Часть на твою СРАКУ и ПИЗДУ, часть на мой ХУЙ, а остальное по всему телу!\r\n \r\n ----------\r\n А чем тебя привлекает ГОМНО — запахом, своим видом, тем как оно выходит из ЖОПЫ?\r\n \r\n ----------\r\n Мне тоже нравится на это смотреть. А ещё мне понравится брать в руки твоё ГОМНО и размазывать по твоему телу!\r\n \r\n ----------\r\n А тебе нравится, когда ССУТ в рот? Я хочу НАССАТЬ тебе в рот, и чтобы ты это выпила!\r\n \r\n ----------\r\n Хорошо хоть в этом буду первый! Хочешь верь, хочешь не верь — у меня ни разу в жизни не было девственницы, то есть целки. ПОЗОР! ПОЗОР! А мне по хую! Ну не было и не было. Это нормально, как ты считаешь?\r\n \r\n ----------\r\n Александра! А у тебя ПИЗДА ВОЛОСАТАЯ?\r\n \r\n ----------\r\n А у меня ХУЙ ВОЛОСАТЫЙ, и я его никогда не брею! Будешь брать ХУЙ В РОТ вместе с яйцами, да и яйца тоже немного волосатые.\r\n \r\n ----------\r\n А у тебя В ЖОПЕ вокруг ануса волосы растут?\r\n \r\n ----------\r\n Тебя мои вопросы возбуждают?\r\n \r\n ----------\r\n Сидишь ДРОЧИШЬ ПИЗДУ?\r\n \r\n ----------\r\n ДРОЧИ, ДРОЧИ! Я приеду и всю твою ПИЗДЕНЬ ЗАЛЕПЛЮ ГОМНОМ!!\r\n \r\n ----------\r\n Представь себе, что я хочу СРАТЬ. Сначала я тебя ОБОССУ, а затем сяду на твоё лицо, и ты будешь лизать и тщательно вылизывать мой ВОНЮЧИЙ ПЕРДАК. После этого я НАСРУ тебе в рот и стану пальцами запихивать в рот ГОМНО! И при этом буду приговаривать — Жуй ГОМНО! Жуй ГОМНО! Давай, давай жуй! Затем оставшееся ГОМНО я размажу по всему твоему лицу — по лбу, по щекам, по подбородку и ещё всю шею обмажу! Во ништяк будет видик! Ты будешь лежать в таком виде, а я буду ДРОЧИТЬ НА ТЕБЯ ХУЙ!\r\n \r\n ----------\r\n Читаешь и мастурбируешь на мой недавний шедевр?\r\n \r\n ----------\r\n Когда я сажусь куда-нибудь, на стул или на кровать, а потом встаю, то у меня трусы прилипают к ЖОПЕ, а точнее прямо к АНАЛЬНОМУ ОЧКУ! Я встаю и мне приходится их отдирать оттуда и вынимать ИЗ ЖОПЫ. Трусы сзади и посередине все вымазаны, а прилипают потому, что у меня В ЖОПЕ ПОСТОЯННО ЖИДКОЕ ГОМНО!\r\n ";
		var pidornuha = "Привет, пидорнуха.\r\n ----------Прет, пидорнухенсон.\r\n ----------Пидорнуха нагрелась.\r\n ----------Остудись, чмоха.\r\n ----------Чмонька, не бугурти.Поссал проецирующей чмохе в её обвафленный ротешник.\r\n ----------Посрал тебе, пидорнуха, в ебало.\r\n ----------Угомонись, Сёма опущенный.\r\n ----------Пидорнутый Семён незаметен.\r\n ----------Почём проектор покупал?\r\n ----------Какой фирмы у тебя проектор, пидорнушка?\r\n ----------Чмоха пидорнутая, зачем ругаешься?\r\n ----------Объясни мне, чувырло пидорнутое, почему ты такой мудак?\r\n ----------Дегенерат ебаный, успокойся.\r\n ----------Хватит гадить, чмоха опущенная.\r\n ----------Сосируй, пидорнушкенсон.\r\n ----------Ты ещё здесь, аутист?\r\n ----------Хуеглот, зачем ты так нагреваешься?\r\n ----------Припекло, пидорнуха?\r\n ----------Чмонька.\r\n ----------Что ты там прокудахтал, опущ?\r\n ----------Опущенная чмоха, хватит срать.\r\n ----------Прет, чмоха.\r\n ----------Пидорнухе **НЕПРИЯТНО**.\r\n ----------Чмоньке **НЕПРИЯТНО**.\r\n ----------Опущенцу **НЕПРИЯТНО**.\r\n ----------В конфу пиздуй, пидорнушка, там тебя приголубят.\r\n ----------Что, пидорнуха, попку бо-бо?\r\n ----------Здорово, бичуган.\r\n ----------Пидорнуха-пидорнуха...\r\n ----------Привет, главный пидорнушкенс рунета!\r\n ----------Как дела, хуесос?\r\n ----------Не проецируй.\r\n ----------Зачем ты проецируешь свои комплексы и проблемы на других людей?\r\n ----------Проекции опущенного дауна.\r\n ----------Ты зачем проецируешь?\r\n ----------Выключи уже свой проектор.\r\n ----------Ебать дебил, поссал тебе в рот, чмоха.\r\n ----------Как ты отнесешься к тому, что я тебе нассу в твоё гнилое ебало?\r\n ----------Ты пидорнуха. Опровергнешь?\r\n ----------Тебя хоть раз пидоряли откуда-нибудь? Хотя, кого я спрашиваю. Действительно, кого? Пидорнуху, вот кого.\r\n ----------Почему же ты такой тупорылый хуесос, сможешь ответить мне?\r\n ----------Дегенератишка тупорылый, хватит выёбываться.\r\n ----------Какой же ты тупой.\r\n ----------Соси хуй, быдло.\r\n ----------Проекции пидорнухи.\r\n ----------Ну прекрати проецировать.\r\n ----------Что ты там прокукарекала, маня?\r\n ----------Пойди подмойся.\r\n ----------Насрал тебе в рот.\r\n ----------Приветик, пидорнухенсон, как делишки в городе Пидорнухенсе?\r\n ----------Ты обоссалась.\r\n ----------Ты обоссался, пидорнуха.\r\n ----------Пидорнуха обоссалась, лол.\r\n ----------Я твой рот в жопу ебал.\r\n ----------Завали ебало.\r\n ----------Ты обсикался, энурезник.\r\n ----------Опять ты себе в штаны нассал? Мамка твоя небось уже заебалась стирать.\r\n ----------Иди матрас суши, обоссанец. Он прогнил весь уже, от твоей мочи.\r\n ----------Поссал на тебя.\r\n ----------Поссал тебе в рот.\r\n ----------Посрал тебе в ухо.\r\n ----------Навалил кучу тебе в ротешник.\r\n ----------Не надоело проецировать?\r\n ----------Влажные мечты опущенки.\r\n ----------Под шконку вернись, тебе здесь не рады.\r\n ----------Оправдания пидорнутого.\r\n ----------Пидорнуха, не отмазывайся.\r\n ----------Пидорнуха, не бомби.\r\n ----------Ты что ли?\r\n ---------->ко-ко-ко \r\n Ясно.\r\n ---------->среньк-среньк \r\n Хватит срать.\r\n ---------->бульк \r\n Ты сначала мочу проглоти, а потом говори.\r\n ---------->пидорнуха оправдывается\r\n ---------->чмонька отмазывается\r\n ---------->обоссанец булькнул\r\n ---------->петух кукарекает\r\n ---------->ко-ко-ко, кудах!\r\n ----------Заткнись, пидорнуха.\r\n ----------Анус петуха почти выдержал, но там **ТАКОЕ** было написано.\r\n ----------Тебе делать нехуй?\r\n ----------Какой фирмы у тебя проектор, пидорнуха?\r\n ----------Спроецировал струю мочи тебе в ротешник, пидорнуха.\r\n ----------Пиздуй на сосач, пидорнуха.\r\n ----------Обоссан, на сосач послан.\r\n ---------->пок пок пок \r\n Что, простите?\r\n ---------->Бульбульбуль \r\n Что, простите?\r\n ---------->Бульбульбуль \r\n Ты сначала допей, а потом уже добавки проси.\r\n ----------Возвращайся на свой сосач, пидорнуха.\r\n ---------->Мочехлёбу **неприятно**\r\n ----------А не пора ли тебе съебать на мочан?\r\n ----------Угомонись, деградант, блядь, мочехлёб.\r\n ----------Под шконку вернись, тебе здесь не рады.\r\n ----------Мощная проекция.\r\n ----------Ты хули тут срёшь, гнида?\r\n ----------**НСБ.**\r\n ----------На сосач, быдло.\r\n ----------Тут не место таким серунам. **Пшел вон!**\r\n ----------Не ссы! Съеби на сосач!\r\n ----------Пшел вон, поскрёбыш.\r\n ----------Так значит, ты конфопидарас?\r\n ----------Ану брысь обратно в конфочку.\r\n ----------Иди и сри в своей конфе, мудила\r\n ----------Ну вот скажи мне, мудак великовозрастный, почему ты вылез из своей конфы?\r\n ----------Уёбывай в свою конфу и сри там.\r\n ---------->Конфодаун пытается отосраться. \r\n Понятно.\r\n ----------Ты ведь с мочана пришёл, не так ли?\r\n ----------Ану брысь на свою мочепарашу, и чтобы духу твоего небыло на нашем свободном ресурсе!\r\n ----------Этот обоссанец ещё что-то возражает.\r\n ----------Этот опущ ещё что-то чешет тут.\r\n ----------Ой блядь, припёрлось, животное. Дохуя сегодня параш выпилил?\r\n ----------Мощная проекция мочехлёба.\r\n";
        })()).init())
    }

function chanPhoton() {
var css = "a.b-blog-entry_b-header_m-category {\n    font-weight: 800 !important;\n    text-decoration: none !important;\n    color: #002244 !important;\n}\n\n.b-blog-panel ul li.b-blog-panel_b-add-entry.b-blog-panel_m-active a, .b-blog-panel ul li.b-blog-panel_b-favorites-active a, .b-blog-panel ul li.b-blog-panel_b-approved-active a,\n.b-blog-panel ul li.b-blog-panel_m-active  a  {\n    color: #3366CC !important;\n}\n\nbody, .l-left-panel-wrap {\n    background-color: #EEEEEE !important;\n}\n\na:link, a:visited {\n    color: #FF6600 !important;\n}\na.js-paste-link, .b-comment_b-info a {\n    color: #40454B !important;\n    text-decoration: none !important;\n}\n\na:hover, span.b-blog-entry_b-info_b-link a {\n    color: #3366CC !important;\n}\n.b-comment {\n    background-color: #DDDDDD !important;\n    border: 1px solid #CCCCCC;\n    border-radius: 5px !important;\n}\n\n\n.l-wrap {\n    border-top: 1px solid #CCC !important;\n}\ndiv.l-content-wrap {\n    border-top: 1px solid #CCC !important;\n    border-bottom: 1px solid #CCC !important;\n}\n.b-blog-entry {\n    border-bottom: 1px solid #CCCCCC !important;\n}\n#comment_form {\n    border: 1px solid #CCC !important;\n    border-radius: 8px !important;\n}\n.b-comment + #template_comment + #placeholder_comment {\n    padding-bottom: 15px !important;\n    border-bottom: 1px solid #CCC !important;\n}\n\n.b-blog-panel_b-all, .b-blog-panel_b-approved, .b-blog-panel_b-favorites {background-color: #EAEAEA !important;}\n.b-blog-panel_b-all.b-blog-panel_m-active, .b-blog-panel_b-approved.b-blog-panel_m-active, .b-blog-panel_b-favorites.b-blog-panel_m-active {background-color: #E5E5E5 !important;}\n\na.b-blog-entry_b-header_m-category {\n    font-weight: 800 !important;\n    text-decoration: none !important;\n    color: #002244 !important;\n}\n\n\n.b-header-block.m-mascot-b, .b-header-block.m-mascot-d, .b-header-block.m-mascot-to, .b-header-block.m-mascot-a,\n.b-header-block.m-mascot-s, .b-header-block.m-mascot-vg, .b-header-block.m-mascot-pr, .b-header-block.m-mascot-mu,\n.b-header-block.m-mascot-tv, .b-header-block.m-mascot-int {\n    background: none !important;\n}\n.b-blog-entry .b-blog-entry_b-header {\n    text-indent: 0px !important;\n}\n\nbody {\n    margin: 0px 8px 0 8px !important;\n    min-width: 870px !important;\n\n    padding-bottom: 200px !important;\n\n}\n.l-right-panel-wrap {\n    position: absolute !important;\n    top: auto !important;\n    left: 0px !important;\n    bottom: -55px !important;\n    width: 55% !important;\n\n    overflow: visible !important;\n    max-height: 400px !important;\n}\n\n\ndiv.b-blog-panel.g-clearfix {\n    position: absolute !important;\n    top: 5px !important;\n    right: 0px !important;\n    width: auto !important;\n}\n.b-top-panel  {\n    display: none !important;\n}\n.b-header-block.m-mascot-news {\n    background: none !important;\n}\n.b-blog-entry_b-header.m-floating {\n    right: 10px !important;\n}\n.b-comment-form {\n    border: none !important;\n}\n.l-footer-wrap {\n    height: 0px !important;\n}\n\n\n.b-live-panel ul {\n    margin: 0 auto !important;\n    width: 62% !important;\n}\n.b-live-entry .b-live-entry_b-clicks {\n    color: #999 !important;\n}\n.b-links-panel:hover {\n    background: none !important;\n}\n.b-underlinks {\n    right: auto !important;\n    left: 5px !important;\n    display: block !important;\n\n}\ndiv.l-wrap div.l-content-wrap p a {\n    right: 20px !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title {\n\n    border-bottom: none !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title h2, div.b-links-panel {\n    text-align: left !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title h2 {\n    text-indent: 10px !important;\n}\n.b-links-panel .b-links-panel_b-links .b-live-entry {\n    width: 90% !important;\n}\n\n.l-wrap {\n    padding-bottom: 400px !important;\n\n\n    width: auto !important;\n    margin: 0px 8px 8px 8px !important;\n    position: relative !important;\n    z-index: 1;\n}\ndiv.l-wrap div.l-content-wrap div.b-blog-panel ul {\n    padding-right: 0px !important;\n}\ndiv.b-header-block div#stats_block.b-header-block_b-stats {\n    position: absolute !important;\n    left: 200px !important;\n    top: -25px !important;\n    z-index: 9999 !important;\n    border-radius: 8px 8px 8px 0px !important;\n}\n\n\n\n.b-footer-copyrights {\n    display: none;\n}\n.b-comment_b-info a {\n    font-weight: bold !important;\n}\n.b-menu-panel .b-menu-panel_b-links ul {\n    width: auto !important;\n}\n.b-menu-panel .b-menu-panel_b-links {\n    margin: 0 !important;\n}\n\nli.m-active, div.b-menu-panel_b-links ul li:hover {\n    background: none !important;\n}\n.b-menu-panel {\n    min-height: 0 !important;\n}\n\ndiv.l-content-wrap {\n    border-left: none !important;\n    border-right: none !important;\n\n    padding-top: 15px !important;\n    padding-bottom: 25px !important;\n    border-radius: 0px !important;\n}\n\n.b-blog-entry {\n    width: auto !important;\n\n    padding-bottom: 3px !important;\n\n}\n.b-blog-entry .b-blog-entry_b-info {\n    border: none !important;\n}\n.b-comment {\n    width: auto !important;\n    min-width: 300px !important;\n    margin: 4px !important;\n\n    display: table !important;\n    clear: both !important;\n\n}\n\n.b-comment div.wrap {\n    width: auto !important;\n    }\n\n.l-comments-wrap {\n    margin: 0 !important;\n    width: 100% !important;\n    border-top: none !important;\n}\n\n.b-blog-panel .b-blog-panel_b-searchmenu a, span.b-blog-entry_b-info_b-control span a.g-disabled {\n    color: #999999 !important;\n}\n.b-post-added-notify a {\n    color: #FFFFFF !important;\n}\n.b-blog-panel ul li a {\n    text-shadow: none !important;\n}\n\ndiv.l-wrap div.l-content-wrap p {\n    text-align: left !important;\n}\n.b-paginator {\nmargin: 0px !important;\n}\n.b-header-block {\n    width: 250px !important;\n}\n.l-footer-wrap.m-mascot-news, .l-footer-wrap {\n    background: none !important;\n}\n\n.b-footer-imgboards {\n    margin-top: 0px !important;\n    clear: left !important;\n    position: absolute !important;\n    right: 200px !important;\n    padding-left: 0px !important;\n\n}\n.b-footer-services {\n\n    clear: left !important;\n    position: absolute;\n    right: 0px !important;\n\n    margin-top: 0px !important;\n}\n#comment_form {\n    margin-top: 35px !important;\n    padding-top: 25px !important;\n\n    width: 590px !important;\n    margin-left: auto !important;\n    margin-right: auto !important;\n}\n.b-post-statistics {\n    width: 550px !important;\n    position: absolute;\n    left: 50%;\n    margin-left: -285px !important;\n    margin-top: 45px !important;\n    border-radius: 5px !important;\n}\n.b-links-panel .b-links-panel_b-hide {\n    position: absolute !important;\n}\ndiv.b-live-entry a.b-live-entry_b-board{\n    color: #777 !important;\n}\n.b-links-panel .b-links-panel_b-title h2 {\n    font-size: 1.7em !important;\n}\n.b-links-panel .b-links-panel_b-title h2:after {\n    content: \":\";\n}\n\ndiv.b-board-header div.b-board-header_name {\n    position: absolute !important;\n    right: 0px !important;\n    top: -110px !important;\n}\n.b-board-header .b-board-header_name h1 {\n    font-size: 1.5em !important;\n}\n#hide-panel-button, #show-panel-button {\n    margin-top: 15px !important;\n}\n\n\nbody {\npadding-left: 220px !important;\n    min-width: 880px !important;\nmargin-left: 0px !important;\n}\n.b-menu-panel .b-menu-panel_b-links {\n    text-align: left !important;\n}\n.l-left-panel-wrap {\n    position: fixed !important;\n    top: 0px !important;\n    bottom: auto !important;\n    right: auto !important;\n    left: 0px !important;\n    margin-left: 25px !important;\n    height: 100% !important;\n    width: 155px !important;\n    padding-right: 17px !important;\n    border-right: 4px ridge #CCC;\n    color: #EEEEEE !important;\noverflow: auto !important;\n}\ndiv.b-header-block div#stats_block.b-header-block_b-stats {\ntop: 25px !important;\n}\n.b-menu-panel_b-footer {\n    text-align: left !important;\n}\n.l-wrap {\n    border-width: 0 0 0 0 !important;\n    background-image: none !important;\n}\n.b-ajax-loader, .b-ajax-loader-error {\n    margin-left: 222px !important;\n}";
if (typeof GM_addStyle != "undefined") {
	GM_addStyle(css);
} else if (typeof PRO_addStyle != "undefined") {
	PRO_addStyle(css);
} else if (typeof addStyle != "undefined") {
	addStyle(css);
} else {
	var node = document.createElement("style");
	node.type = "text/css";
	node.appendChild(document.createTextNode(css));
	var heads = document.getElementsByTagName("head");
	if (heads.length > 0) {
		heads[0].appendChild(node); 
	} else {
		// no head yet, stick it whereever
		document.documentElement.appendChild(node);
	}
}
}

function chanFutaba() {
var css = "a.b-blog-entry_b-header_m-category {\n    font-weight: 800 !important;\n    text-decoration: none !important;\n    color: #002244 !important;\n}\n\n.b-blog-panel ul li.b-blog-panel_b-add-entry.b-blog-panel_m-active a, .b-blog-panel ul li.b-blog-panel_b-favorites-active a, .b-blog-panel ul li.b-blog-panel_b-approved-active a,\n.b-blog-panel ul li.b-blog-panel_m-active  a  {\n    color: #3366CC !important;\n}\n\nhtml, body {\n    font-family: Georgia, serif !important;\n    font-size: 19px !important;\n}\nbody, .l-left-panel-wrap {\n    background-color: #FFFFEE !important;\n}\na:link, a:visited {\n    color: #0000EE!important;\n}\na.js-paste-link, .b-comment_b-info a {\n    color: #40454B !important;\n    text-decoration: none !important;\n}\na:hover, span.b-blog-entry_b-info_b-link a {\n    color: #DD0000 !important;\n}\n.b-comment {\n    background-color: #F0E0D6 !important;\nborder: 1px solid #CCCCCC !important;\n}\n\n\n.l-wrap {\n    border-top: 1px solid #000 !important;\n}\ndiv.l-content-wrap {\n    border-top: 1px solid #000 !important;\n    border-bottom: 1px solid #000 !important;\n}\n.b-blog-entry {\n    border-bottom: 1px solid #000 !important;\n}\n#comment_form {\n    border: 1px outset #777 !important;\n    border-radius: 8px !important;\n}\n.b-comment + #template_comment + #placeholder_comment {\n    padding-bottom: 15px !important;\n    border-bottom: 1px solid #000 !important;\n}\n.b-blog-panel_b-all, .b-blog-panel_b-approved, .b-blog-panel_b-favorites {background-color: #EAEAEA !important;}\n.b-blog-panel_b-all.b-blog-panel_m-active, .b-blog-panel_b-approved.b-blog-panel_m-active, .b-blog-panel_b-favorites.b-blog-panel_m-active {background-color: #E5E5E5 !important;}\n\na.b-blog-entry_b-header_m-category {\n    font-weight: 800 !important;\n    text-decoration: none !important;\n    color: #002244 !important;\n}\n\n.b-header-block.m-mascot-b, .b-header-block.m-mascot-d, .b-header-block.m-mascot-to, .b-header-block.m-mascot-a,\n.b-header-block.m-mascot-s, .b-header-block.m-mascot-vg, .b-header-block.m-mascot-pr, .b-header-block.m-mascot-mu,\n.b-header-block.m-mascot-tv, .b-header-block.m-mascot-int {\n    background: none !important;\n}\n.b-blog-entry .b-blog-entry_b-header {\n    text-indent: 0px !important;\n}\n\nbody {\n    margin: 0px 8px 0 8px !important;\n    min-width: 870px !important;\n\n    padding-bottom: 200px !important;\n\n}\n.l-right-panel-wrap {\n    position: absolute !important;\n    top: auto !important;\n    left: 0px !important;\n    bottom: -55px !important;\n    width: 55% !important;\n\n    overflow: visible !important;\n    max-height: 400px !important;\n}\n\n\ndiv.b-blog-panel.g-clearfix {\n    position: absolute !important;\n    top: 5px !important;\n    right: 0px !important;\n    width: auto !important;\n}\n.b-top-panel  {\n    display: none !important;\n}\n.b-header-block.m-mascot-news {\n    background: none !important;\n}\n.b-blog-entry_b-header.m-floating {\n    right: 10px !important;\n}\n.b-comment-form {\n    border: none !important;\n}\n.l-footer-wrap {\n    height: 0px !important;\n}\n\n\n.b-live-panel ul {\n    margin: 0 auto !important;\n    width: 62% !important;\n}\n.b-live-entry .b-live-entry_b-clicks {\n    color: #999 !important;\n}\n.b-links-panel:hover {\n    background: none !important;\n}\n.b-underlinks {\n    right: auto !important;\n    left: 5px !important;\n    display: block !important;\n\n}\ndiv.l-wrap div.l-content-wrap p a {\n    right: 20px !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title {\n\n    border-bottom: none !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title h2, div.b-links-panel {\n    text-align: left !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title h2 {\n    text-indent: 10px !important;\n}\n.b-links-panel .b-links-panel_b-links .b-live-entry {\n    width: 90% !important;\n}\n\n.l-wrap {\n    padding-bottom: 400px !important;\n\n\n    width: auto !important;\n    margin: 0px 8px 8px 8px !important;\n    position: relative !important;\n    z-index: 1;\n}\ndiv.l-wrap div.l-content-wrap div.b-blog-panel ul {\n    padding-right: 0px !important;\n}\ndiv.b-header-block div#stats_block.b-header-block_b-stats {\n    position: absolute !important;\n    left: 200px !important;\n    top: -25px !important;\n    z-index: 9999 !important;\n    border-radius: 8px 8px 8px 0px !important;\n}\n\n\n\n.b-footer-copyrights {\n    display: none;\n}\n.b-comment_b-info a {\n    font-weight: bold !important;\n}\n.b-menu-panel .b-menu-panel_b-links ul {\n    width: auto !important;\n}\n.b-menu-panel .b-menu-panel_b-links {\n    margin: 0 !important;\n}\n\nli.m-active, div.b-menu-panel_b-links ul li:hover {\n    background: none !important;\n}\n.b-menu-panel {\n    min-height: 0 !important;\n}\n\ndiv.l-content-wrap {\n    border-left: none !important;\n    border-right: none !important;\n\n    padding-top: 15px !important;\n    padding-bottom: 25px !important;\n    border-radius: 0px !important;\n}\n\n.b-blog-entry {\n    width: auto !important;\n\n    padding-bottom: 3px !important;\n\n}\n.b-blog-entry .b-blog-entry_b-info {\n    border: none !important;\n}\n.b-comment {\n    width: auto !important;\n    min-width: 300px !important;\n    margin: 4px !important;\n\n    display: table !important;\n    clear: both !important;\n\n}\n\n.b-comment div.wrap {\n    width: auto !important;\n    }\n\n.l-comments-wrap {\n    margin: 0 !important;\n    width: 100% !important;\n    border-top: none !important;\n}\n\n.b-blog-panel .b-blog-panel_b-searchmenu a, span.b-blog-entry_b-info_b-control span a.g-disabled {\n    color: #999999 !important;\n}\n.b-post-added-notify a {\n    color: #FFFFFF !important;\n}\n.b-blog-panel ul li a {\n    text-shadow: none !important;\n}\n\ndiv.l-wrap div.l-content-wrap p {\n    text-align: left !important;\n}\n.b-paginator {\nmargin: 0px !important;\n}\n.b-header-block {\n    width: 250px !important;\n}\n.l-footer-wrap.m-mascot-news, .l-footer-wrap {\n    background: none !important;\n}\n\n.b-footer-imgboards {\n    margin-top: 0px !important;\n    clear: left !important;\n    position: absolute !important;\n    right: 200px !important;\n    padding-left: 0px !important;\n\n}\n.b-footer-services {\n\n    clear: left !important;\n    position: absolute;\n    right: 0px !important;\n\n    margin-top: 0px !important;\n}\n#comment_form {\n    margin-top: 35px !important;\n    padding-top: 25px !important;\n\n    width: 590px !important;\n    margin-left: auto !important;\n    margin-right: auto !important;\n}\n.b-post-statistics {\n    width: 550px !important;\n    position: absolute;\n    left: 50%;\n    margin-left: -285px !important;\n    margin-top: 45px !important;\n    border-radius: 5px !important;\n}\n.b-links-panel .b-links-panel_b-hide {\n    position: absolute !important;\n}\ndiv.b-live-entry a.b-live-entry_b-board{\n    color: #777 !important;\n}\n.b-links-panel .b-links-panel_b-title h2 {\n    font-size: 1.7em !important;\n}\n.b-links-panel .b-links-panel_b-title h2:after {\n    content: \":\";\n}\n\ndiv.b-board-header div.b-board-header_name {\n    position: absolute !important;\n    right: 0px !important;\n    top: -110px !important;\n}\n.b-board-header .b-board-header_name h1 {\n    font-size: 1.5em !important;\n}\n#hide-panel-button, #show-panel-button {\n    margin-top: 15px !important;\n}\n\n\nbody {\npadding-left: 220px !important;\n    min-width: 880px !important;\nmargin-left: 0px !important;\n}\n.b-menu-panel .b-menu-panel_b-links {\n    text-align: left !important;\n}\n.l-left-panel-wrap {\n    position: fixed !important;\n    top: 0px !important;\n    bottom: auto !important;\n    right: auto !important;\n    left: 0px !important;\n    margin-left: 25px !important;\n    height: 100% !important;\n    width: 155px !important;\n    padding-right: 17px !important;\n    border-right: 4px ridge #CCC;\n    color: #EEEEEE !important;\noverflow: auto !important;\n}\ndiv.b-header-block div#stats_block.b-header-block_b-stats {\ntop: 25px !important;\n}\n.b-menu-panel_b-footer {\n    text-align: left !important;\n}\n.l-wrap {\n    border-width: 0 0 0 0 !important;\n    background-image: none !important;\n}\n.b-ajax-loader, .b-ajax-loader-error {\n    margin-left: 222px !important;\n}";
if (typeof GM_addStyle != "undefined") {
	GM_addStyle(css);
} else if (typeof PRO_addStyle != "undefined") {
	PRO_addStyle(css);
} else if (typeof addStyle != "undefined") {
	addStyle(css);
} else {
	var node = document.createElement("style");
	node.type = "text/css";
	node.appendChild(document.createTextNode(css));
	var heads = document.getElementsByTagName("head");
	if (heads.length > 0) {
		heads[0].appendChild(node); 
	} else {
		// no head yet, stick it whereever
		document.documentElement.appendChild(node);
	}
}
}

function chanBurichan() {
var css = "a.b-blog-entry_b-header_m-category {\n    font-weight: 800 !important;\n    text-decoration: none !important;\n    color: #002244 !important;\n}\n\n.b-blog-panel ul li.b-blog-panel_b-add-entry.b-blog-panel_m-active a, .b-blog-panel ul li.b-blog-panel_b-favorites-active a, .b-blog-panel ul li.b-blog-panel_b-approved-active a,\n.b-blog-panel ul li.b-blog-panel_m-active  a  {\n    color: #3366CC !important;\n}\n\nhtml, body {\n    font-family: Georgia, serif !important;\n    font-size: 19px !important;\n}\nbody, .l-left-panel-wrap {\n    background-color: #EEF2FF !important;\n}\na:link, a:visited {\n    color: #34345C!important;\n    text-decoration: none !important;\n}\na.js-paste-link, .b-comment_b-info a {\n    color: #40454B !important;\n    text-decoration: none !important;\n}\na:hover, span.b-blog-entry_b-info_b-link a {\n    color: #DD0000 !important;\n}\n.b-comment {\n    background-color: #D6DAF0 !important;\n    border: none !important;\n    border-radius: 0px !important;\n}\n.l-wrap {\n    border-top: 1px solid #000 !important;\n}\ndiv.l-content-wrap {\n    border-top: 1px solid #000 !important;\n    border-bottom: 1px solid #000 !important;\n}\n.b-blog-entry {\n    border-bottom: 1px solid #000 !important;\n}\n#comment_form {\n    border: 1px outset #777 !important;\n    border-radius: 8px !important;\n}\n.b-comment + #template_comment + #placeholder_comment {\n    padding-bottom: 15px !important;\n    border-bottom: 1px solid #000 !important;\n}\n.b-blog-panel_b-all, .b-blog-panel_b-approved, .b-blog-panel_b-favorites {background-color: #DFEEFB !important;}\n.b-blog-panel_b-all.b-blog-panel_m-active, .b-blog-panel_b-approved.b-blog-panel_m-active, .b-blog-panel_b-favorites.b-blog-panel_m-active {background-color: #D6E3F7 !important;}\n\na.b-blog-entry_b-header_m-category {\n    font-weight: 800 !important;\n    text-decoration: none !important;\n    color: #002244 !important;\n}\n\n\n.b-header-block.m-mascot-b, .b-header-block.m-mascot-d, .b-header-block.m-mascot-to, .b-header-block.m-mascot-a,\n.b-header-block.m-mascot-s, .b-header-block.m-mascot-vg, .b-header-block.m-mascot-pr, .b-header-block.m-mascot-mu,\n.b-header-block.m-mascot-tv, .b-header-block.m-mascot-int {\n    background: none !important;\n}\n.b-blog-entry .b-blog-entry_b-header {\n    text-indent: 0px !important;\n}\n\nbody {\n    margin: 0px 8px 0 8px !important;\n    min-width: 870px !important;\n\n    padding-bottom: 200px !important;\n\n}\n.l-right-panel-wrap {\n    position: absolute !important;\n    top: auto !important;\n    left: 0px !important;\n    bottom: -55px !important;\n    width: 55% !important;\n\n    overflow: visible !important;\n    max-height: 400px !important;\n}\n\n\ndiv.b-blog-panel.g-clearfix {\n    position: absolute !important;\n    top: 5px !important;\n    right: 0px !important;\n    width: auto !important;\n}\n.b-top-panel  {\n    display: none !important;\n}\n.b-header-block.m-mascot-news {\n    background: none !important;\n}\n.b-blog-entry_b-header.m-floating {\n    right: 10px !important;\n}\n.b-comment-form {\n    border: none !important;\n}\n.l-footer-wrap {\n    height: 0px !important;\n}\n\n\n.b-live-panel ul {\n    margin: 0 auto !important;\n    width: 62% !important;\n}\n.b-live-entry .b-live-entry_b-clicks {\n    color: #999 !important;\n}\n.b-links-panel:hover {\n    background: none !important;\n}\n.b-underlinks {\n    right: auto !important;\n    left: 5px !important;\n    display: block !important;\n\n}\ndiv.l-wrap div.l-content-wrap p a {\n    right: 20px !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title {\n\n    border-bottom: none !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title h2, div.b-links-panel {\n    text-align: left !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title h2 {\n    text-indent: 10px !important;\n}\n.b-links-panel .b-links-panel_b-links .b-live-entry {\n    width: 90% !important;\n}\n\n.l-wrap {\n    padding-bottom: 400px !important;\n\n\n    width: auto !important;\n    margin: 0px 8px 8px 8px !important;\n    position: relative !important;\n    z-index: 1;\n}\ndiv.l-wrap div.l-content-wrap div.b-blog-panel ul {\n    padding-right: 0px !important;\n}\ndiv.b-header-block div#stats_block.b-header-block_b-stats {\n    position: absolute !important;\n    left: 200px !important;\n    top: -25px !important;\n    z-index: 9999 !important;\n    border-radius: 8px 8px 8px 0px !important;\n}\n\n\n\n.b-footer-copyrights {\n    display: none;\n}\n.b-comment_b-info a {\n    font-weight: bold !important;\n}\n.b-menu-panel .b-menu-panel_b-links ul {\n    width: auto !important;\n}\n.b-menu-panel .b-menu-panel_b-links {\n    margin: 0 !important;\n}\n\nli.m-active, div.b-menu-panel_b-links ul li:hover {\n    background: none !important;\n}\n.b-menu-panel {\n    min-height: 0 !important;\n}\n\ndiv.l-content-wrap {\n    border-left: none !important;\n    border-right: none !important;\n\n    padding-top: 15px !important;\n    padding-bottom: 25px !important;\n    border-radius: 0px !important;\n}\n\n.b-blog-entry {\n    width: auto !important;\n\n    padding-bottom: 3px !important;\n\n}\n.b-blog-entry .b-blog-entry_b-info {\n    border: none !important;\n}\n.b-comment {\n    width: auto !important;\n    min-width: 300px !important;\n    margin: 4px !important;\n\n    display: table !important;\n    clear: both !important;\n\n}\n\n.b-comment div.wrap {\n    width: auto !important;\n    }\n\n.l-comments-wrap {\n    margin: 0 !important;\n    width: 100% !important;\n    border-top: none !important;\n}\n\n.b-blog-panel .b-blog-panel_b-searchmenu a, span.b-blog-entry_b-info_b-control span a.g-disabled {\n    color: #999999 !important;\n}\n.b-post-added-notify a {\n    color: #FFFFFF !important;\n}\n.b-blog-panel ul li a {\n    text-shadow: none !important;\n}\n\ndiv.l-wrap div.l-content-wrap p {\n    text-align: left !important;\n}\n.b-paginator {\nmargin: 0px !important;\n}\n.b-header-block {\n    width: 250px !important;\n}\n.l-footer-wrap.m-mascot-news, .l-footer-wrap {\n    background: none !important;\n}\n\n.b-footer-imgboards {\n    margin-top: 0px !important;\n    clear: left !important;\n    position: absolute !important;\n    right: 200px !important;\n    padding-left: 0px !important;\n\n}\n.b-footer-services {\n\n    clear: left !important;\n    position: absolute;\n    right: 0px !important;\n\n    margin-top: 0px !important;\n}\n#comment_form {\n    margin-top: 35px !important;\n    padding-top: 25px !important;\n\n    width: 590px !important;\n    margin-left: auto !important;\n    margin-right: auto !important;\n}\n.b-post-statistics {\n    width: 550px !important;\n    position: absolute;\n    left: 50%;\n    margin-left: -285px !important;\n    margin-top: 45px !important;\n    border-radius: 5px !important;\n}\n.b-links-panel .b-links-panel_b-hide {\n    position: absolute !important;\n}\ndiv.b-live-entry a.b-live-entry_b-board{\n    color: #777 !important;\n}\n.b-links-panel .b-links-panel_b-title h2 {\n    font-size: 1.7em !important;\n}\n.b-links-panel .b-links-panel_b-title h2:after {\n    content: \":\";\n}\n\ndiv.b-board-header div.b-board-header_name {\n    position: absolute !important;\n    right: 0px !important;\n    top: -110px !important;\n}\n.b-board-header .b-board-header_name h1 {\n    font-size: 1.5em !important;\n}\n#hide-panel-button, #show-panel-button {\n    margin-top: 15px !important;\n}\n\n\nbody {\npadding-left: 220px !important;\n    min-width: 880px !important;\nmargin-left: 0px !important;\n}\n.b-menu-panel .b-menu-panel_b-links {\n    text-align: left !important;\n}\n.l-left-panel-wrap {\n    position: fixed !important;\n    top: 0px !important;\n    bottom: auto !important;\n    right: auto !important;\n    left: 0px !important;\n    margin-left: 25px !important;\n    height: 100% !important;\n    width: 155px !important;\n    padding-right: 17px !important;\n    border-right: 4px ridge #CCC;\n    color: #EEEEEE !important;\noverflow: auto !important;\n}\ndiv.b-header-block div#stats_block.b-header-block_b-stats {\ntop: 25px !important;\n}\n.b-menu-panel_b-footer {\n    text-align: left !important;\n}\n.l-wrap {\n    border-width: 0 0 0 0 !important;\n    background-image: none !important;\n}\n.b-ajax-loader, .b-ajax-loader-error {\n    margin-left: 222px !important;\n}";
if (typeof GM_addStyle != "undefined") {
	GM_addStyle(css);
} else if (typeof PRO_addStyle != "undefined") {
	PRO_addStyle(css);
} else if (typeof addStyle != "undefined") {
	addStyle(css);
} else {
	var node = document.createElement("style");
	node.type = "text/css";
	node.appendChild(document.createTextNode(css));
	var heads = document.getElementsByTagName("head");
	if (heads.length > 0) {
		heads[0].appendChild(node); 
	} else {
		// no head yet, stick it whereever
		document.documentElement.appendChild(node);
	}
}
}

function chanGurochan() {
var css = "a.b-blog-entry_b-header_m-category {\n    font-weight: 800 !important;\n    text-decoration: none !important;\n    color: #002244 !important;\n}\n\n.b-blog-panel ul li.b-blog-panel_b-add-entry.b-blog-panel_m-active a, .b-blog-panel ul li.b-blog-panel_b-favorites-active a, .b-blog-panel ul li.b-blog-panel_b-approved-active a,\n.b-blog-panel ul li.b-blog-panel_m-active  a  {\n    color: #3366CC !important;\n}\n\nhtml, body {\n    font-family: Georgia, serif !important;\n    font-size: 19px !important;\n}\nbody, .l-left-panel-wrap {\n    background-color: #EDDAD2 !important;\n}\na:link, a:visited {\n    color: #34345C!important;\n}\na.js-paste-link, .b-comment_b-info a {\n    color: #40454B !important;\n    text-decoration: none !important;\n}\na:hover, span.b-blog-entry_b-info_b-link a {\n    color: #DD0000 !important;\n}\n.b-comment {\n    background-color: #D9AF9E !important;\nborder: 1px solid #CA927B !important;\nborder-radius: 0px !important;\n}\n.l-wrap {\n    border-top: 1px solid #000 !important;\n}\ndiv.l-content-wrap {\n    border-top: 1px solid #000 !important;\n    border-bottom: 1px solid #000 !important;\n}\n.b-blog-entry {\n    border-bottom: 1px solid #000 !important;\n}\n#comment_form {\n    border: 1px outset #777 !important;\n    border-radius: 8px !important;\n}\n.b-comment + #template_comment + #placeholder_comment {\n    padding-bottom: 15px !important;\n    border-bottom: 1px solid #000 !important;\n}\n.b-blog-panel_b-all, .b-blog-panel_b-approved, .b-blog-panel_b-favorites {background-color: #EED1D1 !important;}\n.b-blog-panel_b-all.b-blog-panel_m-active, .b-blog-panel_b-approved.b-blog-panel_m-active, .b-blog-panel_b-favorites.b-blog-panel_m-active {background-color: #E8A0A0 !important;}\n.b-blog-panel_b-add-entry {background-color: #D7C3AC !important;}\n\na.b-blog-entry_b-header_m-category {\n    font-weight: 800 !important;\n    text-decoration: none !important;\n    color: #002244 !important;\n}\n\n\n.b-header-block.m-mascot-b, .b-header-block.m-mascot-d, .b-header-block.m-mascot-to, .b-header-block.m-mascot-a,\n.b-header-block.m-mascot-s, .b-header-block.m-mascot-vg, .b-header-block.m-mascot-pr, .b-header-block.m-mascot-mu,\n.b-header-block.m-mascot-tv, .b-header-block.m-mascot-int {\n    background: none !important;\n}\n.b-blog-entry .b-blog-entry_b-header {\n    text-indent: 0px !important;\n}\n\nbody {\n    margin: 0px 8px 0 8px !important;\n    min-width: 870px !important;\n\n    padding-bottom: 200px !important;\n\n}\n.l-right-panel-wrap {\n    position: absolute !important;\n    top: auto !important;\n    left: 0px !important;\n    bottom: -55px !important;\n    width: 55% !important;\n\n    overflow: visible !important;\n    max-height: 400px !important;\n}\n\n\ndiv.b-blog-panel.g-clearfix {\n    position: absolute !important;\n    top: 5px !important;\n    right: 0px !important;\n    width: auto !important;\n}\n.b-top-panel  {\n    display: none !important;\n}\n.b-header-block.m-mascot-news {\n    background: none !important;\n}\n.b-blog-entry_b-header.m-floating {\n    right: 10px !important;\n}\n.b-comment-form {\n    border: none !important;\n}\n.l-footer-wrap {\n    height: 0px !important;\n}\n\n\n.b-live-panel ul {\n    margin: 0 auto !important;\n    width: 62% !important;\n}\n.b-live-entry .b-live-entry_b-clicks {\n    color: #999 !important;\n}\n.b-links-panel:hover {\n    background: none !important;\n}\n.b-underlinks {\n    right: auto !important;\n    left: 5px !important;\n    display: block !important;\n\n}\ndiv.l-wrap div.l-content-wrap p a {\n    right: 20px !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title {\n\n    border-bottom: none !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title h2, div.b-links-panel {\n    text-align: left !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title h2 {\n    text-indent: 10px !important;\n}\n.b-links-panel .b-links-panel_b-links .b-live-entry {\n    width: 90% !important;\n}\n\n.l-wrap {\n    padding-bottom: 400px !important;\n\n\n    width: auto !important;\n    margin: 0px 8px 8px 8px !important;\n    position: relative !important;\n    z-index: 1;\n}\ndiv.l-wrap div.l-content-wrap div.b-blog-panel ul {\n    padding-right: 0px !important;\n}\ndiv.b-header-block div#stats_block.b-header-block_b-stats {\n    position: absolute !important;\n    left: 200px !important;\n    top: -25px !important;\n    z-index: 9999 !important;\n    border-radius: 8px 8px 8px 0px !important;\n}\n\n\n\n.b-footer-copyrights {\n    display: none;\n}\n.b-comment_b-info a {\n    font-weight: bold !important;\n}\n.b-menu-panel .b-menu-panel_b-links ul {\n    width: auto !important;\n}\n.b-menu-panel .b-menu-panel_b-links {\n    margin: 0 !important;\n}\n\nli.m-active, div.b-menu-panel_b-links ul li:hover {\n    background: none !important;\n}\n.b-menu-panel {\n    min-height: 0 !important;\n}\n\ndiv.l-content-wrap {\n    border-left: none !important;\n    border-right: none !important;\n\n    padding-top: 15px !important;\n    padding-bottom: 25px !important;\n    border-radius: 0px !important;\n}\n\n.b-blog-entry {\n    width: auto !important;\n\n    padding-bottom: 3px !important;\n\n}\n.b-blog-entry .b-blog-entry_b-info {\n    border: none !important;\n}\n.b-comment {\n    width: auto !important;\n    min-width: 300px !important;\n    margin: 4px !important;\n\n    display: table !important;\n    clear: both !important;\n\n}\n\n.b-comment div.wrap {\n    width: auto !important;\n    }\n\n.l-comments-wrap {\n    margin: 0 !important;\n    width: 100% !important;\n    border-top: none !important;\n}\n\n.b-blog-panel .b-blog-panel_b-searchmenu a, span.b-blog-entry_b-info_b-control span a.g-disabled {\n    color: #999999 !important;\n}\n.b-post-added-notify a {\n    color: #FFFFFF !important;\n}\n.b-blog-panel ul li a {\n    text-shadow: none !important;\n}\n\ndiv.l-wrap div.l-content-wrap p {\n    text-align: left !important;\n}\n.b-paginator {\nmargin: 0px !important;\n}\n.b-header-block {\n    width: 250px !important;\n}\n.l-footer-wrap.m-mascot-news, .l-footer-wrap {\n    background: none !important;\n}\n\n.b-footer-imgboards {\n    margin-top: 0px !important;\n    clear: left !important;\n    position: absolute !important;\n    right: 200px !important;\n    padding-left: 0px !important;\n\n}\n.b-footer-services {\n\n    clear: left !important;\n    position: absolute;\n    right: 0px !important;\n\n    margin-top: 0px !important;\n}\n#comment_form {\n    margin-top: 35px !important;\n    padding-top: 25px !important;\n\n    width: 590px !important;\n    margin-left: auto !important;\n    margin-right: auto !important;\n}\n.b-post-statistics {\n    width: 550px !important;\n    position: absolute;\n    left: 50%;\n    margin-left: -285px !important;\n    margin-top: 45px !important;\n    border-radius: 5px !important;\n}\n.b-links-panel .b-links-panel_b-hide {\n    position: absolute !important;\n}\ndiv.b-live-entry a.b-live-entry_b-board{\n    color: #777 !important;\n}\n.b-links-panel .b-links-panel_b-title h2 {\n    font-size: 1.7em !important;\n}\n.b-links-panel .b-links-panel_b-title h2:after {\n    content: \":\";\n}\n\ndiv.b-board-header div.b-board-header_name {\n    position: absolute !important;\n    right: 0px !important;\n    top: -110px !important;\n}\n.b-board-header .b-board-header_name h1 {\n    font-size: 1.5em !important;\n}\n#hide-panel-button, #show-panel-button {\n    margin-top: 15px !important;\n}\n\n\nbody {\npadding-left: 220px !important;\n    min-width: 880px !important;\nmargin-left: 0px !important;\n}\n.b-menu-panel .b-menu-panel_b-links {\n    text-align: left !important;\n}\n.l-left-panel-wrap {\n    position: fixed !important;\n    top: 0px !important;\n    bottom: auto !important;\n    right: auto !important;\n    left: 0px !important;\n    margin-left: 25px !important;\n    height: 100% !important;\n    width: 155px !important;\n    padding-right: 17px !important;\n    border-right: 4px ridge #CCC;\n    color: #EEEEEE !important;\noverflow: auto !important;\n}\ndiv.b-header-block div#stats_block.b-header-block_b-stats {\ntop: 25px !important;\n}\n.b-menu-panel_b-footer {\n    text-align: left !important;\n}\n.l-wrap {\n    border-width: 0 0 0 0 !important;\n    background-image: none !important;\n}\n.b-ajax-loader, .b-ajax-loader-error {\n    margin-left: 222px !important;\n}";
if (typeof GM_addStyle != "undefined") {
	GM_addStyle(css);
} else if (typeof PRO_addStyle != "undefined") {
	PRO_addStyle(css);
} else if (typeof addStyle != "undefined") {
	addStyle(css);
} else {
	var node = document.createElement("style");
	node.type = "text/css";
	node.appendChild(document.createTextNode(css));
	var heads = document.getElementsByTagName("head");
	if (heads.length > 0) {
		heads[0].appendChild(node); 
	} else {
		// no head yet, stick it whereever
		document.documentElement.appendChild(node);
	}
}
}

function chanNeutron() {
var css = "a.b-blog-entry_b-header_m-category {\n    font-weight: 800 !important;\n    text-decoration: none !important;\n    color: #002244 !important;\n}\n\n.b-blog-panel ul li.b-blog-panel_b-add-entry.b-blog-panel_m-active a, .b-blog-panel ul li.b-blog-panel_b-favorites-active a, .b-blog-panel ul li.b-blog-panel_b-approved-active a,\n.b-blog-panel ul li.b-blog-panel_m-active  a  {\n    color: #3366CC !important;\n}\n\nhtml, body {\n    color: #698CC0 !important;\n    font-family: \"Trebuchet MS\",Trebuchet,tahoma,serif !important;\n    font-size: 1.1em !important;\n    background-color: #212121 !important;\n}\n\na:link, a:visited {\n    color: #C9BE89!important;\n}\na.js-paste-link, .b-comment_b-info a {\n    color: #C9BE89 !important;\n    text-decoration: none !important;\n\n}\n\nbody, .l-left-panel-wrap {\n    background-color: #212121 !important;\n}\n\na:hover, span.b-blog-entry_b-info_b-link a {\n    color: #EEFEBB !important;\n}\na.b-blog-entry_b-header_m-category {\n    color: #3941AC !important;\n    font-weight: bold;\n    text-decoration: none !important;\n}\n.b-comment {\n    background-color: #2C2C2C !important;\n    border: 1px solid #575757 !important;\n    border-radius: 5px !important;\n\n\n}\n\n\n.l-wrap {\n    background-image: url('http://storage4.static.itmages.ru/i/13/0713/h_1373727080_7837575_a7ddfee85b.png')!important;\n    background-repeat: no-repeat !important;\n    background-position: top center;\n}\ndiv.l-content-wrap {\n    background-image: url('http://storage4.static.itmages.ru/i/13/0713/h_1373727080_7837575_a7ddfee85b.png')!important;\n    background-repeat: no-repeat !important;\n    background-position: top center;\n    border-width: 0px !important;\n}\n.b-blog-entry {\n    background-image: url('http://storage4.static.itmages.ru/i/13/0713/h_1373727080_7837575_a7ddfee85b.png')!important;\n    background-repeat: no-repeat !important;\n    background-position: bottom center;\n\n}\n.b-blog-entry_b-info {\n    margin-bottom: 6px !important;\n}\n.b-comment + #template_comment + #placeholder_comment {\n    background-image: url('http://storage4.static.itmages.ru/i/13/0713/h_1373727080_7837575_a7ddfee85b.png')!important;\n    background-repeat: no-repeat !important;\n    background-position: bottom center;\n    border-width: 0px !important;\n    padding-bottom: 15px !important;\n}\n#comment_form {\n    box-shadow: 0 0 10px;\n    border-radius: 8px !important;\n}\n.b-post-statistics {\n  background: none repeat scroll 0 0 #373737 !important;\n\n}\n.b-blog-panel ul li.b-blog-panel_b-add-entry.b-blog-panel_m-active a, .b-blog-panel ul li.b-blog-panel_b-favorites-active a, .b-blog-panel ul li.b-blog-panel_b-approved-active a,\n.b-blog-panel ul li.b-blog-panel_m-active  a  {\n    color: red !important;\n}\n.b-blog-form .b-blog-form_b-form {\n    border: 1px solid #575757 !important;\n}\n.b-comments-load span {\n    background-color: #575757 !important;\n}\n#smile-panel, .b-paginator {\n  border: 2px solid #575757 !important;\n}\n.b-board-form {\n  border: none !important;\n  box-shadow: 0 0 10px !important;\n}\n.b-blog-panel .b-blog-panel_b-submenu {\n    width: auto !important;\n}\n.b-header-block .b-header-block_b-stats {\n  background: none repeat scroll 0 0 #333333 !important;\n  border: 2px solid #575757 !important;\n}\n.b-homeboard-form_icon, .js-homeboard-select-link {\n    background: none !important;\n    border: none !important;\n}\nspan.b-homeboard-form div.b-homeboard-form_select {\n    background-color: #333 !important;\n    border: none !important;\n}\n.b-comment .b-comment_b-homeboard img {\n  opacity: 1 !important;\n}\ninput, textarea {\n    background-color: #111111 !important;\n    color: #CCC !important;\n}\ntextarea:hover, textarea:focus, input:hover, input:focus {\n  background-color: #151515 !important;\n  color: #EEEEEE !important;\n}\n#comment_form_text, input {\n    -moz-appearance: none;\n    -moz-box-sizing: content-box;\n    border: 2px solid #545454 !important;\n    border-radius: 5px !important;\n}\n.b-spoiler-text {\n    background: #575757 !important;\n    color: #698CC0 !important;\n}\n.b-blog-panel_b-all, .b-blog-panel_b-approved, .b-blog-panel_b-favorites {background-color: #4a4a4a  !important;}\n.b-blog-panel_b-all.b-blog-panel_m-active, .b-blog-panel_b-approved.b-blog-panel_m-active, .b-blog-panel_b-favorites.b-blog-panel_m-active {background-color: #353535 !important;}\n.b-blog-panel_b-add-entry {background-color: #393737 !important;}\nstrong.g-red {\n    color: red !important;\n}\n.b-post-added-notify {\n  background: none repeat scroll 0 0 red !important;\n\n}\n.b-blog-panel .b-blog-panel_b-submenu {\n  background: none repeat scroll 0 0 #333333 !important;\n\n}\n.b-menu-panel .b-menu-panel_b-title {\n  border-bottom: 2px solid #575757 !important;\n\n}\n.l-left-panel-wrap {\n    border-right: 6px ridge #111 !important;\n}\n.b-blog-entry .b-blog-entry_b-header.m-floating {\n  background: none repeat scroll 0 0 #1B1B1B !important;\n\n}\n\n.b-header-block.m-mascot-b, .b-header-block.m-mascot-d, .b-header-block.m-mascot-to, .b-header-block.m-mascot-a,\n.b-header-block.m-mascot-s, .b-header-block.m-mascot-vg, .b-header-block.m-mascot-pr, .b-header-block.m-mascot-mu,\n.b-header-block.m-mascot-tv, .b-header-block.m-mascot-int {\n    background: none !important;\n}\n.b-blog-entry .b-blog-entry_b-header {\n    text-indent: 0px !important;\n}\n\nbody {\n    margin: 0px 8px 0 8px !important;\n    min-width: 870px !important;\n\n    padding-bottom: 200px !important;\n\n}\n.l-right-panel-wrap {\n    position: absolute !important;\n    top: auto !important;\n    left: 0px !important;\n    bottom: -55px !important;\n    width: 55% !important;\n\n    overflow: visible !important;\n    max-height: 400px !important;\n}\n\n\ndiv.b-blog-panel.g-clearfix {\n    position: absolute !important;\n    top: 5px !important;\n    right: 0px !important;\n    width: auto !important;\n}\n.b-top-panel  {\n    display: none !important;\n}\n.b-header-block.m-mascot-news {\n    background: none !important;\n}\n.b-blog-entry_b-header.m-floating {\n    right: 10px !important;\n}\n.b-comment-form {\n    border: none !important;\n}\n.l-footer-wrap {\n    height: 0px !important;\n}\n\n\n.b-live-panel ul {\n    margin: 0 auto !important;\n    width: 62% !important;\n}\n.b-live-entry .b-live-entry_b-clicks {\n    color: #999 !important;\n}\n.b-links-panel:hover {\n    background: none !important;\n}\n.b-underlinks {\n    right: auto !important;\n    left: 5px !important;\n    display: block !important;\n\n}\ndiv.l-wrap div.l-content-wrap p a {\n    right: 20px !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title {\n\n    border-bottom: none !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title h2, div.b-links-panel {\n    text-align: left !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title h2 {\n    text-indent: 10px !important;\n}\n.b-links-panel .b-links-panel_b-links .b-live-entry {\n    width: 90% !important;\n}\n\n.l-wrap {\n    padding-bottom: 400px !important;\n\n\n    width: auto !important;\n    margin: 0px 8px 8px 8px !important;\n    position: relative !important;\n    z-index: 1;\n}\ndiv.l-wrap div.l-content-wrap div.b-blog-panel ul {\n    padding-right: 0px !important;\n}\ndiv.b-header-block div#stats_block.b-header-block_b-stats {\n    position: absolute !important;\n    left: 200px !important;\n    top: -25px !important;\n    z-index: 9999 !important;\n    border-radius: 8px 8px 8px 0px !important;\n}\n\n\n\n.b-footer-copyrights {\n    display: none;\n}\n.b-comment_b-info a {\n    font-weight: bold !important;\n}\n.b-menu-panel .b-menu-panel_b-links ul {\n    width: auto !important;\n}\n.b-menu-panel .b-menu-panel_b-links {\n    margin: 0 !important;\n}\n\nli.m-active, div.b-menu-panel_b-links ul li:hover {\n    background: none !important;\n}\n.b-menu-panel {\n    min-height: 0 !important;\n}\n\ndiv.l-content-wrap {\n    border-left: none !important;\n    border-right: none !important;\n\n    padding-top: 15px !important;\n    padding-bottom: 25px !important;\n    border-radius: 0px !important;\n}\n\n.b-blog-entry {\n    width: auto !important;\n\n    padding-bottom: 3px !important;\n\n}\n.b-blog-entry .b-blog-entry_b-info {\n    border: none !important;\n}\n.b-comment {\n    width: auto !important;\n    min-width: 300px !important;\n    margin: 4px !important;\n\n    display: table !important;\n    clear: both !important;\n\n}\n\n.b-comment div.wrap {\n    width: auto !important;\n    }\n\n.l-comments-wrap {\n    margin: 0 !important;\n    width: 100% !important;\n    border-top: none !important;\n}\n\n.b-blog-panel .b-blog-panel_b-searchmenu a, span.b-blog-entry_b-info_b-control span a.g-disabled {\n    color: #999999 !important;\n}\n.b-post-added-notify a {\n    color: #FFFFFF !important;\n}\n.b-blog-panel ul li a {\n    text-shadow: none !important;\n}\n\ndiv.l-wrap div.l-content-wrap p {\n    text-align: left !important;\n}\n.b-paginator {\nmargin: 0px !important;\n}\n.b-header-block {\n    width: 250px !important;\n}\n.l-footer-wrap.m-mascot-news, .l-footer-wrap {\n    background: none !important;\n}\n\n.b-footer-imgboards {\n    margin-top: 0px !important;\n    clear: left !important;\n    position: absolute !important;\n    right: 200px !important;\n    padding-left: 0px !important;\n\n}\n.b-footer-services {\n\n    clear: left !important;\n    position: absolute;\n    right: 0px !important;\n\n    margin-top: 0px !important;\n}\n#comment_form {\n    margin-top: 35px !important;\n    padding-top: 25px !important;\n\n    width: 590px !important;\n    margin-left: auto !important;\n    margin-right: auto !important;\n}\n.b-post-statistics {\n    width: 550px !important;\n    position: absolute;\n    left: 50%;\n    margin-left: -285px !important;\n    margin-top: 45px !important;\n    border-radius: 5px !important;\n}\n.b-links-panel .b-links-panel_b-hide {\n    position: absolute !important;\n}\ndiv.b-live-entry a.b-live-entry_b-board{\n    color: #777 !important;\n}\n.b-links-panel .b-links-panel_b-title h2 {\n    font-size: 1.7em !important;\n}\n.b-links-panel .b-links-panel_b-title h2:after {\n    content: \":\";\n}\n\ndiv.b-board-header div.b-board-header_name {\n    position: absolute !important;\n    right: 0px !important;\n    top: -110px !important;\n}\n.b-board-header .b-board-header_name h1 {\n    font-size: 1.5em !important;\n}\n#hide-panel-button, #show-panel-button {\n    margin-top: 15px !important;\n}\n\n\nbody {\npadding-left: 220px !important;\n    min-width: 880px !important;\nmargin-left: 0px !important;\n}\n.b-menu-panel .b-menu-panel_b-links {\n    text-align: left !important;\n}\n.l-left-panel-wrap {\n    position: fixed !important;\n    top: 0px !important;\n    bottom: auto !important;\n    right: auto !important;\n    left: 0px !important;\n    margin-left: 25px !important;\n    height: 100% !important;\n    width: 155px !important;\n    padding-right: 17px !important;\n    border-right: 4px ridge #CCC;\n    color: #EEEEEE !important;\noverflow: auto !important;\n}\ndiv.b-header-block div#stats_block.b-header-block_b-stats {\ntop: 25px !important;\n}\n.b-menu-panel_b-footer {\n    text-align: left !important;\n}\n.l-wrap {\n    border-width: 0 0 0 0 !important;\n    background-image: none !important;\n}\n.b-ajax-loader, .b-ajax-loader-error {\n    margin-left: 222px !important;\n}";
if (typeof GM_addStyle != "undefined") {
	GM_addStyle(css);
} else if (typeof PRO_addStyle != "undefined") {
	PRO_addStyle(css);
} else if (typeof addStyle != "undefined") {
	addStyle(css);
} else {
	var node = document.createElement("style");
	node.type = "text/css";
	node.appendChild(document.createTextNode(css));
	var heads = document.getElementsByTagName("head");
	if (heads.length > 0) {
		heads[0].appendChild(node); 
	} else {
		// no head yet, stick it whereever
		document.documentElement.appendChild(node);
	}
}
}

function chanLenta() {
var css = "html, body {\n font-family: Georgia, serif !important;\n font-size: 20px !important;\n color: #444 !important;\n}\nhtml {\n background-color: #E5E5E5 !important;\n}\nbody {\n background-color: #FFFFFF !important;\n width: 1000px !important;\n box-shadow: 0 0 15px #B1B1B1;\n margin: 0px 8px 0 8px !important;\n padding-bottom: 200px !important;\n padding-left: 198px !important;\n min-width: 880px !important;\n}\np {\n line-height: 17px !important;\n}\na {\n transition: color 0.2s ease 0s !important;\n}\n.b-menu-panel .b-menu-panel_b-title {\n border-color: #353535 !important;\n}\n.b-blog-panel_b-all, .b-blog-panel_b-approved, .b-blog-panel_b-favorites {\n background-color: #F4F4F4 !important;\n}\n.b-blog-panel_b-all.b-blog-panel_m-active, .b-blog-panel_b-approved.b-blog-panel_m-active, .b-blog-panel_b-favorites.b-blog-panel_m-active {\n background-color: #EAE9DA !important;\n}\n.b-blog-panel_b-add-entry {\n background-color: #EBE9DA !important;\n}\nimg[src$=\"http://1chan.inach.org/img/logo.png\"] {\n padding-left: 25px !important;\n margin-top: 15px !important;\n padding-right: 250px!important; \n width: 0px !important;\n background-image:url(\"http://storage7.static.itmages.ru/i/13/0607/h_1370584030_8068084_91084988a5.png\")!important;\n background-repeat: no-repeat !important;\n}\n.b-header-block {\n margin-left: 25px !important;\n}\na:link, a:visited {\n color: #CC3333 !important;\n}\na.js-paste-link, .b-comment_b-info a {\n color: #40454B !important;\n text-decoration: none !important;\n}\na:hover, span.b-blog-entry_b-info_b-link a {\n color: #151515 !important;\n}\n.b-comment {\n background-color: #F6F6F6 !important;\n border: 1px solid #CCCCCC !important;\n border-radius: 0px !important;\n border-width: 0 0 1px 0 !important;\n}\n.l-wrap {\n border-top: 5px solid #151515 !important;\n}\ndiv.l-content-wrap {\n border-top: 5px solid #151515 !important;\n border-bottom: 5px solid #151515 !important;\n}\n.b-blog-entry {\n border-bottom: 1px solid #D5D5D5 !important;\n}\n#comment_form {\n box-shadow: 0 0 10px #BBB !important;\n border-radius: 8px !important;\n}\n.b-comment + #template_comment + #placeholder_comment {\n padding-bottom: 15px !important;\n border-bottom: 5px solid #151515 !important;\n}\n.b-header-block.m-mascot-b, .b-header-block.m-mascot-d, .b-header-block.m-mascot-to, .b-header-block.m-mascot-a,\n.b-header-block.m-mascot-s, .b-header-block.m-mascot-vg, .b-header-block.m-mascot-pr, .b-header-block.m-mascot-mu,\n.b-header-block.m-mascot-tv, .b-header-block.m-mascot-int {\n padding-right: 500px !important;\n}\n.b-blog-entry .b-blog-entry_b-header {\n text-indent: 0px !important;\n}\n.b-blog-entry_b-info, .b-comment_b-info {\n font-family: \"Trebuchet MS\", sans-serif !important;\n}\n.l-right-panel-wrap {\n position: absolute !important;\n top: auto !important;\n left: 25px !important;\n bottom: -55px !important;\n width: 55% !important;\n\n overflow: visible !important;\n max-height: 400px !important;\n}\n\n\ndiv.b-blog-panel.g-clearfix {\n position: absolute !important;\n top: 5px !important;\n right: -45px !important;\n width: auto !important;\n}\n.b-top-panel {\n display: none !important;\n}\n.b-header-block.m-mascot-news {\n background: none !important;\n}\n\n.b-comment-form {\n border: none !important;\n}\n.l-footer-wrap {\n height: 0px !important;\n}\na.b-blog-entry_b-header_m-category {\n font-weight: 800 !important;\n text-decoration: none !important;\n color: #002244 !important;\n}\na.b-blog-entry_b-header_m-category {\n font-weight: 800 !important;\n text-decoration: none !important;\n color: #002244 !important;\n}\n\n.b-live-panel ul {\n margin: 0 auto !important;\n width: 62% !important;\n}\n.b-live-entry .b-live-entry_b-clicks {\n color: #999 !important;\n}\n.b-links-panel:hover {\n background: none !important;\n}\n.b-underlinks {\n right: auto !important;\n left: 30px !important;\n display: block !important;\n}\ndiv.l-wrap div.l-content-wrap p a {\n right: 20px !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title {\n\n border-bottom: none !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title h2, div.b-links-panel {\n text-align: left !important;\n}\ndiv.b-links-panel div.b-links-panel_b-title h2 {\n text-indent: 10px !important;\n}\n.b-links-panel .b-links-panel_b-links .b-live-entry {\n width: 90% !important;\n}\n.l-wrap {\n padding-bottom: 400px !important;\n width: auto !important;\n position: relative !important;\n z-index: 1;\n}\ndiv.l-wrap div.l-content-wrap div.b-blog-panel ul {\n padding-right: 0px !important;\n}\ndiv.b-header-block div#stats_block.b-header-block_b-stats {\n position: absolute !important;\n left: 300px !important;\n top: 80px !important;\n z-index: 9999 !important;\n border-radius: 0px 8px 8px 8px !important;\n}\n\ndiv.b-menu-panel div.b-menu-panel_b-links ul li a {\n padding-right: 0px !important;\n}\n\n.b-footer-copyrights {\n display: none;\n}\n.b-comment_b-info a {\n font-weight: bold !important;\n}\n.b-menu-panel .b-menu-panel_b-links ul {\n width: auto !important;\n}\n.b-menu-panel .b-menu-panel_b-links {\n margin: 0 !important;\n}\n.b-menu-panel_b-conference {\n font-size: 11px !important;\n color: #959595 !important;\n}\n.b-menu-panel_b-footer {\n text-align: left !important;\n}\nli.m-active, div.b-menu-panel_b-links ul li:hover {\n background: none !important;\n}\n.b-menu-panel {\n\n}\ndiv.l-content-wrap {\n border-left: none !important;\n border-right: none !important;\n padding-left: 25px !important;\n padding-right: 27px !important;\n padding-top: 15px !important;\n padding-bottom: 25px !important;\n border-radius: 0px !important;\n}\n.b-blog-entry {\n width: auto !important;\n padding-bottom: 3px !important;\n}\n.b-blog-entry .b-blog-entry_b-info {\n border: none !important;\n}\n.b-comment {\n width: auto !important;\n min-width: 300px !important;\n margin: 4px !important;\n display: table !important;\n clear: both !important;\n}\n.b-comment div.wrap {\n width: auto !important;\n}\n.l-comments-wrap {\n margin: 0 !important;\n width: 100% !important;\n border-top: none !important;\n}\n.b-blog-panel .b-blog-panel_b-searchmenu a, span.b-blog-entry_b-info_b-control span a.g-disabled {\n color: #999999 !important;\n}\n.b-post-added-notify a {\n color: #FFFFFF !important;\n}\n.b-blog-panel ul li a {\n text-shadow: none !important;\n}\n.b-blog-panel ul li.b-blog-panel_b-add-entry.b-blog-panel_m-active a, .b-blog-panel ul li.b-blog-panel_b-favorites-active a, .b-blog-panel ul li.b-blog-panel_b-approved-active a,\n.b-blog-panel ul li.b-blog-panel_m-active a {\n color: #3366CC !important;\n}\ndiv.l-wrap div.l-content-wrap p {\n text-align: left !important;\n}\n.b-paginator {\nmargin: 0px !important;\n}\n.b-header-block {\n width: 250px !important;\n}\n.l-footer-wrap.m-mascot-news, .l-footer-wrap {\n background: none !important;\n}\n.b-footer-imgboards {\n margin-top: 0px !important;\n clear: left !important;\n position: absolute !important;\n right: 150px !important;\n padding-left: 0px !important;\n\n}\n.b-footer-services {\n clear: left !important;\n position: absolute;\n right: -35px !important;\n margin-top: 0px !important;\n}\n#comment_form {\n margin-top: 35px !important;\n padding-top: 25px !important;\n width: 590px !important;\n margin-left: auto !important;\n margin-right: auto !important;\n}\n.b-post-statistics {\n width: 550px !important;\n position: absolute;\n left: 50%;\n margin-left: -258px !important;\n margin-top: 45px !important;\n border-radius: 5px !important;\n}\n.b-links-panel .b-links-panel_b-hide {\n position: absolute !important;\n}\ndiv.b-live-entry a.b-live-entry_b-board{\n color: #777 !important;\n}\n.b-links-panel .b-links-panel_b-title h2 {\n font-size: 1.7em !important;\n}\n.b-links-panel .b-links-panel_b-title h2:after {\n content: \":\";\n}\ndiv.b-board-header div.b-board-header_name {\n position: absolute !important;\n right: 0px !important;\n top: -110px !important;\n}\n.b-board-header .b-board-header_name h1 {\n font-size: 1.3em !important;\n}\n.b-board {\n border-top: 5px solid #151515 !important;\n}\n.b-board-header {\n border-bottom: none !important;\n}\n#hide-panel-button, #show-panel-button {\n margin-top: 15px !important;\n}\n.b-menu-panel .b-menu-panel_b-links {\n text-align: left !important;\n}\n.l-left-panel-wrap {\n background: url(\"http://storage8.static.itmages.ru/i/13/0607/h_1370581158_5891287_872ceaf5b9.png\") !important;\n background-repeat: no-repeat !important;\n background-position: 20px 94% !important;\n font-family: \"Trebuchet MS\", sans-serif !important;\n position: fixed !important;\n top: 0px !important;\n bottom: auto !important;\n right: auto !important;\n left: 0px !important;\n padding-left: 20px !important;\n height: 100% !important;\n width: 155px !important;\n padding-right: 24px !important;\n color: #353535 !important;\n overflow: auto !important;\n}\n.b-menu-panel .b-menu-panel_b-title h2 {\n text-align: left !important;\n}\n.l-left-panel-wrap a {\n font-size: 14px !important;\n color: #FFFFFF !important;\n font-weight: bold !important;\n}\ndiv.l-left-panel-wrap div.b-menu-panel div.b-menu-panel_b-links ul li {\n padding: 4px 0 !important;\n}\ndiv.b-blog-panel div.b-blog-panel_b-submenu{\n padding-left: 5px !important;\n padding-right: 5px !important;\n width: 240px !important;\n}\na {\n text-decoration: none !important;\n}\n.b-blog-entry_b-header {\n font-family: \"Trebuchet MS\", sans-serif !important;\n}\n\n\n.l-left-panel-wrap a:hover {\n color: #CCC !important;\n}\n\n.l-wrap {\n border-width: 0 0 0 0 !important;\n margin-right: 52px !important;\n}\n.b-ajax-loader, .b-ajax-loader-error {\n margin-left: 222px !important;\n}\n.l-left-panel-wrap {\n background-color: #222222 !important;\n}\n.b-blog-panel ul li.b-blog-panel_b-add-entry.b-blog-panel_m-active a, .b-blog-panel ul li.b-blog-panel_b-favorites-active a, .b-blog-panel ul li.b-blog-panel_b-approved-active a, .b-blog-panel ul li.b-blog-panel_m-active a {\n color: #151515 !important;\n}\n.b-underlinks > A[href=\"#\"] {\n font-size: 0px !important;\n position: fixed !important;\n width: 30px !important;\n height: 30px !important;\n background: url('http://storage1.static.itmages.ru/i/13/0607/h_1370582151_9051098_d8cd9ac01f.png') !important;\n box-shadow: 0 0 10px #BBB !important;\n top: 0px !important;\n background-repeat: no-repeat !important;\n background-position: 50% 50% !important;\n left: 1220px !important;\n margin-top: 25px !important;\n}\n.b-underlinks > A[href=\"#\"]:hover {\n box-shadow: 0 0 15px #BBB !important;\n}";
if (typeof GM_addStyle != "undefined") {
GM_addStyle(css);
} else if (typeof PRO_addStyle != "undefined") {
PRO_addStyle(css);
} else if (typeof addStyle != "undefined") {
addStyle(css);
} else {
var node = document.createElement("style");
node.type = "text/css";
node.appendChild(document.createTextNode(css));
var heads = document.getElementsByTagName("head");
if (heads.length > 0) {
heads[0].appendChild(node);
} else {
// no head yet, stick it whereever
document.documentElement.appendChild(node);
}
}

if (typeof GM_addStyle == 'undefined')
var GM_addStyle = function(css) {
var head = document.getElementsByTagName('head')[0], style = document.createElement('style');
if (!head) return;
style.type = 'text/css';
style.textContent = css;
head.appendChild(style);
}
GM_addStyle(".top-button {-moz-box-sizing: border-box; background: rgba(234, 244, 255, 0.5); border-right: 1px solid #DDDDDD; bottom: 0; color: #45688E !important; font-size: 12px; height: 100%; left: 0; padding: 14px; position: fixed; text-decoration: none !important; } .top-button:hover{ background: rgba(234, 244, 255, 1);} .top-button, .top-button:hover{ transition: 0.3s;}");

window.onload=function(){
var d=document.createElement('a');
d.className='top-button';
d.innerHTML = '^ Наверх';
d.href = "javascript:scroll(0,0)";
document.body.appendChild(d);
}
}

function chanKudah() {
var css = "body {\n margin-left: 160px !important;\n}\n.b-top-panel {\n display: none !important;\n}\n.b-header-block.m-mascot-news, .l-footer-wrap.m-mascot-news,\n.b-header-block.m-mascot-to, .l-footer-wrap.m-mascot-to,\n.b-header-block.m-mascot-d, .l-footer-wrap.m-mascot-d,\n.b-header-block.m-mascot-b, .l-footer-wrap.m-mascot-b,\n.b-header-block.m-mascot-a, .l-footer-wrap.m-mascot-a,\n.b-header-block.m-mascot-s, .l-footer-wrap.m-mascot-s,\n.b-header-block.m-mascot-vg, .l-footer-wrap.m-mascot-vg,\n.b-header-block.m-mascot-pr, .l-footer-wrap.m-mascot-pr,\n.b-header-block.m-mascot-mu, .l-footer-wrap.m-mascot-mu,\n.b-header-block.m-mascot-tv, .l-footer-wrap.m-mascot-tv,\n.b-header-block.m-mascot-int, .l-footer-wrap.m-mascot-int {\n background: none !important;\n}\n.b-header-block_b-logotype{\n width: 175px !important;\n height: 45px !important;\n background-image: url('http://storage7.static.itmages.ru/i/12/1211/h_1355204274_7922327_f51a2c95e1.jpeg') !important;\n background-repeat: repeat-x !important;\n z-index: 180 !important;\n border-radius: 0px 0px 0px 12px !important;\n padding-right: 0px !important;\n}\n.b-header-block_b-logotype a img {\n position: absolute !important;\n top: -7px !important;\n left: -3px !important;\n height: 60px !important;\n \n z-index: 160 !important;\n }\n\n.b-header-block {\n z-index: 200 !important;\n position: absolute !important;\n top: 0px !important;\n left: -175px !important;\n width: 0% !important;\n padding: 0px !important;\n\n}\n.b-live-panel.g-clearfix {\n left: -3px !important;\n width: 705px !important;\n height: 45px !important;\n padding-top: 0px !important;\n position: absolute !important;\n top: 0px !important;\n background: url('http://storage7.static.itmages.ru/i/12/1211/h_1355204274_7922327_f51a2c95e1.jpeg') !important;\n background-repeat: repeat-x !important;\n border-radius: 0 0 12px 0 !important;\n }\n.b-live-panel ul li.b-live-panel_b-link, .b-live-panel ul li.b-live-panel_b-description {\n padding-left: 10px !important;\n padding-top: 5px !important;\n background: none !important;\n }\n.b-live-panel ul {\n margin-top: 0px !important;\n }\n.b-live-panel_b-submenu {\n position: absolute !important;\n left: 70px !important;\n top: 45px !important;\n }\n.b-blog-panel.g-clearfix{\n background: url('http://storage7.static.itmages.ru/i/12/1211/h_1355204274_7922327_f51a2c95e1.jpeg') !important;\n background-repeat: repeat-x !important;\n\n position: absolute !important;\n top: 0px !important;\n left: -8px !important;\n width: 480px !important;\n margin-left: 0px !important;\n\n border-radius: 0px 0px 12px 0px !important;\n}\n.b-blog-panel_b-searchmenu {\n position: absolute !important;\n top: 44px !important;\n left: -12px !important;\n padding-top: 11px !important;\n padding-bottom: 12px !important;\n padding-left: 18px !important;\n border-left: 1px solid #E7EAED !important;\n color: #FFF !important;\n }\n.b-blog-panel_b-submenu { \n background: none !important;\n padding-top: 11px !important;\n padding-bottom: 14px !important;\n border-right: 1px solid #E7EAED !important;\n border-radius: 0 !important;\n position: absolute !important;\n top: 44px !important;\n left: 427px !important;\n }\n.b-blog-panel_b-add-entry, .b-blog-panel_b-favorites, .b-blog-panel_b-approved,\n.b-blog-panel_b-all {background: none !important;}\n.b-blog-panel ul li {text-shadow: none !important;}\n.b-blog-panel ul li a:link, .b-blog-panel ul li a:visited, .b-blog-panel ul li a:hover {\n color: #E8EFF7 !important;\n}\n.l-content-wrap {border-radius: 0px !important;\n\n border-color: #E7EAED !important;\n}\n.l-left-panel-wrap {\n top: 30px !important;\n padding: 0 !important;\n}\ndiv.b-menu-panel div.b-menu-panel_b-title h2 {\n\n margin-top: 15px !important;\n margin-bottom: 8px !important;\n }\n.b-blog-entry {margin-top: 10px !important;\n padding-bottom: 0px !important;}\n\n.b-post-added-notify {\n text-align: center !important;\n background-color: #E9EDF1 !important;\n color: #6A7989 !important;\n border-radius: 0px !important;\n padding: 7px !important;\n margin-top: 10px !important;\n width: 640px !important;\n }\n.b-post-added-notify a {\n color: #6A7989 !important;\n font-weight: bold !important;\n text-decoration: none !important;\n }\n.b-blog-panel_b-all {\n width: 60px !important;\n}\n.b-blog-panel_b-approved, .b-blog-panel_b-favorites {\n width: 120px !important;}\nDIV#stats_block.b-header-block_b-stats {\n position: absolute !important;\n top: 85px !important;\n left: 568px !important;\n border-radius: 0px 0px 0px 8px !important;\n z-index: 9999 !important;\n }\n.b-comments-load span {\n margin-left: 170px !important;\n }\n.b-menu-panel_b-title, .b-links-panel_b-title {\n\n border-color: #E7EAED !important;\n }\n.b-blog-panel {\n width: auto !important;\n padding-left: 230px !important;\n }\n.b-blog-panel ul {\n margin: 5px !important;}\n.b-menu-panel_b-links {\n margin-top: 5px !important;\n }\n.l-left-panel-wrap {\n left: -170px !important;\n }\n.b-menu-panel .b-menu-panel_b-links ul {\n width: 170px !important;\n }\n\n.b-menu-panel .b-menu-panel_b-links ul li.m-active {\n border-radius: 10px 0 0 10px !important;\n background: #EAF4FF !important;\n}\n.l-right-panel-wrap {\n right: auto !important;\n top: 655px !important;\n left: -170px !important;\n}\n\n\n.l-wrap {\n padding-top: 85px !important;\n\n}\n.l-comments-wrap {\n border-top: none !important;\n}\n.b-blog-panel ul li.b-blog-panel_b-add-entry, .b-blog-panel ul li.b-blog-panel_b-all {\n border-radius: 0px !important;\n }\n\n\n\n\n.b-board-header {\n height: 45px !important;\n margin: 0px !important;\n position: absolute !important;\n top: 0px !important;\n left: -175px !important;\n padding-bottom: 0 !important;\npadding-top: 0 !important;\n border-bottom: none !important;\n width: 677px !important;\n padding-left: 185px !important;\n background: url('http://storage7.static.itmages.ru/i/12/1211/h_1355204274_7922327_f51a2c95e1.jpeg') !important;\n background-repeat: repeat-x !important;\n border-radius: 0 0 12px 12px !important;\n z-index: 190 !important;\n }\n.b-board-header_desc {\n position: absolute !important;\n top: 5px !important;\n margin-left: 250px !important;\n }\ndiv.b-board-header div.b-board-header_name h1,\ndiv.b-board-header_name div.b-board-header_desc label span,\ndiv.b-board-header div.b-board-header_options a,\n.b-board-header_desc {\n color: #E8EFF7 !important;\n}\ndiv.b-board-header div.b-board-header_name h1 {\n margin-top: 12px !important;\n }\n.b-board-form {\n box-shadow: none !important;\n border: none !important;\n }\n.b-board {\n margin-top: 0px !important;\n\n border-top: 1px solid #DDD !important;\n }\n.b-blog-form {\n padding-top: 14px !important;\n }\n.b-menu-panel_b-footer:hover {\n background: none !important;\n }\n\n\nimg[src$=\"http://1chan.inach.org/img/logo.png\"] {\n width: 0px !important;\n height: 0px !important;\n margin-top: 3px !important;\n margin-left: 29px !important;\n padding-left:150px!important; \n background-image:url(\"http://storage4.static.itmages.ru/i/12/1210/h_1355149829_6733835_496856a2c2.png\")!important;\n background-repeat: no-repeat !important;\n }\n\nA[href=\"http://1chan.inach.org/news/search/\"] {\n position: absolute !important;\n top: -33px !important;\n left: 0px !important;\n border: 1px solid #3F78C8 !important;\n background-color: #FFFFFF !important;\n background-image: -moz-linear-gradient(center top , #EFEFEF 0%, #FFFFFF 100%) !important;\n padding: 0px 70px 0px 30px !important;\n border-radius: 3px !important;\n text-decoration: none !important;\n color: #7C90A6 !important;\n z-index: 9997 !important;\n width: 90px !important;\n\n }\nIMG[src=\"http://1chan.inach.org/ico/search.png\"] {\n position: absolute !important;\n top: -28px !important;\n left: 8px !important;\n z-index: 9998 !important;\n}\n\nA[href=\"http://1chan.inach.org/\"]{\n\n margin-left: 8px !important;\n }\nA[href=\"http://1chan.inach.org/\"] {\n margin-left: 6px !important;\n\n }\n \n.b-underlinks > A[href=\"#\"] {\n font-size: 12px !important;\n padding-top: 10px !important;\n padding-left: 15px !important;\n color: #FFF !important;\n position: fixed !important;\n left: 0px !important;\n top: 0px !important;\n height: 100% !important;\n width: 85px !important;\n opacity: 0;\n text-decoration: none !important;\n background-color: #FFF !important;\n -o-transition: all 0.3s ease;\n -moz-transition: all 0.3s ease;\n -webkit-transition: all 0.5s ease;\n }\n.b-underlinks > A[href=\"#\"]:hover {\n opacity: 1;\n color: #45688E !important;\n background-color: #E1E7ED !important;\n}";
if (typeof GM_addStyle != "undefined") {
GM_addStyle(css);
} else if (typeof PRO_addStyle != "undefined") {
PRO_addStyle(css);
} else if (typeof addStyle != "undefined") {
addStyle(css);
} else {
var node = document.createElement("style");
node.type = "text/css";
node.appendChild(document.createTextNode(css));
var heads = document.getElementsByTagName("head");
if (heads.length > 0) {
heads[0].appendChild(node);
} else {
// no head yet, stick it whereever
document.documentElement.appendChild(node);
}
}

if (typeof GM_addStyle == 'undefined')
var GM_addStyle = function(css) {
var head = document.getElementsByTagName('head')[0], style = document.createElement('style');
if (!head) return;
style.type = 'text/css';
style.textContent = css;
head.appendChild(style);
}
GM_addStyle(".top-button {-moz-box-sizing: border-box; background: rgba(234, 244, 255, 0.5); border-right: 1px solid #DDDDDD; bottom: 0; color: #45688E !important; font-size: 12px; height: 100%; left: 0; padding: 14px; position: fixed; text-decoration: none !important;} .top-button:hover{ background: rgba(234, 244, 255, 1);} .top-button, .top-button:hover{ transition: 0.3s;}");

window.onload=function(){
var d=document.createElement('a');
d.className='top-button';
d.innerHTML = '^ Наверх';
d.href = "javascript:scroll(0,0)";
document.body.appendChild(d);
}
}

function showTrueFace() {
var css = ".b-comment .b-comment_b-homeboard img {\n opacity: 1 !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/0chan.ru.png\"] {\n background-image: url(\"http://storage6.static.itmages.ru/i/13/0222/h_1361528039_8008090_2b8165606d.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/dobrochan.ru.png\"] {\n background-image: url(\"http://storage7.static.itmages.ru/i/13/0222/h_1361528068_8385741_888220d7e6.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/krautchan.net.png\"] {\n background-image: url(\"http://storage1.static.itmages.ru/i/13/0222/h_1361528096_8743884_5ef134d6d8.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/2ch.so.png\"] {\n background-image: url(\"http://storage3.static.itmages.ru/i/13/0222/h_1361528129_6942318_fdde14c976.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/4chan.org.png\"] {\n background-image: url(\"http://storage4.static.itmages.ru/i/13/0222/h_1361528159_8989441_2d40722a22.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/iichan.ru.png\"] {\n background-image: url(\"http://storage4.static.itmages.ru/i/13/0222/h_1361527994_7039100_274fd97400.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/iichan.ru_b.png\"] {\n background-image: url(\"http://storage6.static.itmages.ru/i/13/0222/h_1361528206_8386010_1fb866d2ca.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/xmpp.org.png\"] {\n background-image: url(\"http://storage7.static.itmages.ru/i/13/0222/h_1361528243_8538157_8c9afea0e4.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/olanet.ru.png\"] {\n background-image: url(\"http://storage9.static.itmages.ru/i/13/0222/h_1361528269_2825951_1a2e15c1b6.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/2--ch.ru.png\"] {\n background-image: url(\"http://storage1.static.itmages.ru/i/13/0222/h_1361528299_9722198_0539e4685e.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/hivemind.me.png\"] {\n background-image: url(\"http://storage2.static.itmages.ru/i/13/0222/h_1361528320_5778642_d96932a1a4.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/1chan.inach.org.png\"] {\n background-image: url(\"http://storage4.static.itmages.ru/i/13/0222/h_1361528358_2721167_2f8e514adb.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}\nIMG[src=\"http://1chan.inach.org/ico/homeboards/samechan.ru.png\"] {\n background-image: url(\"http://storage5.static.itmages.ru/i/13/0222/h_1361528391_7922377_e9b9b6f847.png\") !important;\n background-repeat: no-repeat !important;\n width: 0px !important;\n height: 32px !important;\n padding-left: 32px !important;\n}";
if (typeof GM_addStyle != "undefined") {
GM_addStyle(css);
} else if (typeof PRO_addStyle != "undefined") {
PRO_addStyle(css);
} else if (typeof addStyle != "undefined") {
addStyle(css);
} else {
var node = document.createElement("style");
node.type = "text/css";
node.appendChild(document.createTextNode(css));
var heads = document.getElementsByTagName("head");
if (heads.length > 0) {
heads[0].appendChild(node);
} else {
// no head yet, stick it whereever
document.documentElement.appendChild(node);
}
}
}

   /*
* Replies map
*/

    function createRepliesMap() {
        
        locationPrefix = "news"; // /\.org\/([^/]+)/.exec(document.URL)[1]
        var comments = document.getElementsByClassName("b-comment");
        var table = {};
        
        for(var i=0; i<comments.length; i++) {
            current_post = comments[i].id.slice(locationPrefix == 'news' ? 8 :
                (locationPrefix.length + 9) );
            refs = comments[i].getElementsByClassName("js-cross-link");
            for(var j=0; j<refs.length; j++) {
                ref = refs[j].name.slice(locationPrefix.length + 1);
                if(typeof(table[ref]) != 'undefined')
                    table[ref].push(current_post);
                else
                    table[ref] = [current_post];
            }
        }
        for(post_num in table) {
            container = document.createElement("div");
            container.id = "answers_"+post_num;
            container.appendChild(document.createElement('p'));
            container = container.lastChild;
            container.style.margin = '0px';
            container.style.padding = '4px';
            container.style.fontSize = '0.8em';
            container.textContent = "Ответы: ";
            for(post_ref in table[post_num]) {
                link = document.createElement("a");
                link.className = "js-cross-link";
                link.href = document.URL + '#'+table[post_num][post_ref];
                link.name = locationPrefix + "/" + table[post_num][post_ref];
                link.textContent = ">>"+table[post_num][post_ref];
                link.style.fontSize = '1em';
                container.appendChild(link);
                container.innerHTML += ', ';
            }
            container.innerHTML = container.innerHTML.substring(0, container.innerHTML.length-2);
            comment = document.getElementById("comment" +
                (locationPrefix == 'news' ? '_' : ('_' + locationPrefix + '_')) + post_num);
            if(comment)
                comment.appendChild(container.parentNode);
      }
    }
      
    function registerAutoupdateHandler() {
        if(/\.ru\/news\/add/.test(document.URL))
            return;
        document.getElementsByClassName("l-comments-wrap")[0].addEventListener('DOMNodeInserted',
            function(event) {
                if(/comment/.test(event.target.id)) {
                    // Hiding
                    if(enabledFeatures.indexOf("hiding")!= -1) {
                        var match = false;
                        for(var j=0; j<hidePatterns.length; j++)
                            if(hidePatterns[j].test(event.target.textContent)) {
                                hidePost(event.target);
                                break;
                            }
                        var hideButton = event.target.getElementsByClassName('b-comment_b-info')[0]
                                        .getElementsByClassName('js-remove-button')[0];
                        hideButton.getElementsByTagName('img')[0].setAttribute("src", "http://1chan.inach.org/ico/oh-my-eyes.png");
                        hideButton.style.display = "inline-block";
                        hideButton.onclick = function() {
                            hidePost(this.parentNode.parentNode);
                            return false;
                        };
                    }
                    // Answer map
                    if(enabledFeatures.indexOf("answermap")!= -1){
                    refs = event.target.getElementsByClassName("js-cross-link");
                    for(var j=0; j<refs.length; j++) {
                        ref = refs[j].name.slice(locationPrefix.length + 1);
                        link = document.createElement("a");
                        link.className = "js-cross-link";
                        var current_post = event.target.id.slice(locationPrefix == 'news' ? 8 :
                            (locationPrefix.length + 9) );
                        link.href = document.URL + '#' + current_post;
                        link.name = locationPrefix + "/" + current_post;
                        link.textContent = ">>" + current_post;
                        link.style.fontSize = '1em';
                        if(container = document.getElementById('answers_'+ref)) { // да, именно =
                            container = container.lastChild
                            container.innerHTML += ', ';
                            container.appendChild(link)
                        } else {
                            container = document.createElement("div");
                            container.id = "answers_" + ref;
                            container.appendChild(document.createElement('p'));
                            container = container.lastChild;
                            container.style.margin = '0px';
                            container.style.padding = '4px';
                            container.style.fontSize = '0.8em';
                            container.textContent = "Ответы: ";
                            container.appendChild(link)
                            comment = document.getElementById("comment" +
                            (locationPrefix == 'news' ? '_' : ('_' + locationPrefix + '_'))
                            + ref);
                            if(comment)
                                comment.appendChild(container.parentNode);
                        }
                    }
                    }
                }
            });
    }


   /*
* Hiding
*/

    function hidePosts() {
        hidePatterns = [];
        var hiddenComments = [];
        for(var key in localStorage)
            if(/hidephrase/.test(key))
                hidePatterns.push(new RegExp(localStorage[key],"i"));
            else if(/comment_\d+/.test(key))
                hiddenComments.push(key);
        
        var hideButtons = document.getElementsByClassName('js-remove-button');
        for(var i=0; i < hideButtons.length; i++) {
            hideButtons[i].getElementsByTagName('img')[0].setAttribute("src", "http://1chan.inach.org/ico/oh-my-eyes.png");
            hideButtons[i].onclick = function() {
                hidePost(this.parentNode.parentNode);
                return false;
            }
            hideButtons[i].style.display = "inline-block";
        }
        
        var comments = document.getElementsByClassName('b-comment');
        for(var i=0; i < comments.length; i++){
            for(var j=0; j < hidePatterns.length; j++)
                if(hiddenComments.indexOf(comments[i].id)!= -1 || hidePatterns[j].test(comments[i].textContent)) {
                    hidePost(comments[i]);
                    break;
                }
        }
    }

    function hideThreads() {
        hidePatterns = [];
        for(var key in localStorage)
            if(/hidephrase/.test(key))
                hidePatterns.push(new RegExp(localStorage[key],"i"));
            
        var threads = document.getElementsByClassName('b-blog-entry');
        for(var i=0; i < threads.length; i++) {
            var threadOpPost = threads[i].getElementsByClassName('b-blog-entry_b-body')[0].textContent;
            var threadTitle = threads[i].getElementsByClassName('b-blog-entry_b-header')[0].textContent;
            var hideShort = enabledFeatures.indexOf("hide-short-news")!= -1
            for(var j=0; j < hidePatterns.length; j++)
                if(hidePatterns[j].test(threadOpPost) || hidePatterns[j].test(threadTitle)) {
                    hideThread(threads[i]);
                    break;
                }
        }
    }
    
    function hideThread(node) {
        if(enabledFeatures.indexOf("show-hidden")!= -1) {
            node.setAttribute("class", "b-blog-entry m-hide");
            var h = node.getElementsByClassName('b-blog-entry_b-header')[0];
            h.onclick = function() {
                showThread(node);
                return false;
            }
        } else {
            node.style.display = "none";
        }
    }
    
    function showThread(node) {
        node.setAttribute("class", "b-blog-entry");
        var h = node.getElementsByClassName('b-blog-entry_b-header')[0];
        h.onclick = function() {};
    }

    function hidePost(node) {
        if(enabledFeatures.indexOf("show-hidden")!= -1) {
            node.getElementsByClassName('b-comment_b-body')[0].style.display = "none";
            var button = node.getElementsByClassName('b-comment_b-info')[0].getElementsByClassName('js-remove-button')[0];
            button.onclick = function() {
                showPost(node);
                return false;
            }
            button.getElementsByTagName('img')[0].setAttribute("src", "http://img440.imageshack.us/img440/162/ohmyeyes1.png");
        } else {
            node.parentNode.removeChild(node);
        }
        localStorage.setItem(node.id, node.id);
    }

    function showPost(node) {
        node.getElementsByClassName('b-comment_b-body')[0].style.display = "block";
        var button = node.getElementsByClassName('b-comment_b-info')[0].getElementsByClassName('js-remove-button')[0];
        button.onclick = function() {
            hidePost(node);
            return false;
        }
        button.getElementsByTagName('img')[0].setAttribute("src", "http://1chan.inach.org/ico/oh-my-eyes.png");
        localStorage.removeItem(node.id);
    }
    
    

    function hideByChosenIcon(ico) {
    //var comments = document.getElementsByClassName('b-comment');
    var comments = document.getElementsByClassName('b-comment_b-homeboard');
    //var threads = document.getElementsByClassName('b-blog-entry');
    
    var tmp;
    var cheezeIco = 0;
    if (ico == "sosach") {tmp = "http://2ch.hk/"};
    if (ico == "0chan") {tmp = "http://0chan.hk/"};
    if (ico == "iichan") {tmp = "http://iichan.hk/"};
    if (ico == "cirno") {tmp = "cirno swings her swirly butt and gets assfucked by fashionramp"};
    if (ico == "obdrochan") {tmp = "http://dobrochan.ru/"};
    if (ico == "samechan") {tmp = "http://samechan.org/"};
    if (ico == "tirech") {tmp = "http://2--ch.ru/"};
    if (ico == "4chan") {tmp = "http://4chan.org/"};
    if (ico == "krautchan") {tmp = "http://krautchan.net/"};
    if (ico == "hivemind") {tmp = "http://hivemind.me/"};
    if (ico == "olanet") {tmp = "http://olanet.ru/"};
    if (ico == "1chan") {tmp = "http://1chan.inach.org/"};
    if (ico == "konfopetuh") {tmp = "http://xmpp.org/"};
    
    
    for(var i = 0; i < comments.length; i++)
        {
        if ((comments[i].href == tmp) || (ico == "cirno"))
                {
                var commhide = comments[i].parentNode.parentNode;
                if (commhide.parentNode.className == "b-blog-entry") 
                    {
                    if ((ico == "cirno") && (comments[i].title.substring(comments[i].title.length - 6, comments[i].title.length-1) == "Сырно"))
                        {hideThread(commhide.parentNode);;}
                    if (ico !== "cirno") {hideThread(commhide.parentNode);}
                    } 
                    else 
                {
                //alert(comments[i].title.substring(comments[i].title.length - 6, comments[i].title.length-1));
                if ((ico == "cirno") && (comments[i].title.substring(comments[i].title.length - 6, comments[i].title.length-1) == "Сырно"))
                        {hidePost(commhide);}
                if (ico !== "cirno") {hidePost(commhide);}
                }
                
               
                
                }
            } 
    /*
    for(var i=0; i < threads.length; i++)
        {
        var cheezeMess = 0;
        var chosenIcon = threads[i].getElementByClassName("b-comment_b-homeboard");
        if (chosenIcon.title.substring(chosenIcon.title.length - 6, chosenIcon.title.length - 1) == "Сырно") {cheezeMess = 5443;};
        if ((chosenIcon.href == tmp) && (cheezeMess == cheezeIco))
                {
                hideThread(threads[i]);
                }
            } 
    */
    
    
    }
    
    

   /*
* Smiles Panel
*/

    function addTextToForm(text) {
        cursor_pos = formTextarea.selectionStart;
        var formText = formTextarea.value;
        formTextarea.value = formText.slice(0, cursor_pos)
                            + text
                            + formText.slice(formTextarea.selectionEnd);
        formTextarea.focus();
    };

    function wrapImageLink(link) {
        if (/rghost/.test(link))
            return '[:' + /\d+/.exec(link)[0] + ':]';
        else
            return '[' + link + ']';
    }

    function createSmile(text, imgLink) {
      
        var image = document.createElement("img");
        var link = document.createElement("a");
      
        link.href = "#";
        link.onclick = function(e) {
            if (deletingSmiles) {
                destroyCustomSmile(this.id);
            } else {
                addTextToForm(text);
                formTextarea.focus();
            }
            e.preventDefault();
            return false;
        };
        link.title = text;
        image.src = imgLink;
        image.style.margin = "6px 3px 1px 3px";
        link.style.outline = "none";
        link.appendChild(image);
        return link;
    }

    // Custom Images

    function createCustomImage(link) {
        
        var name = prompt("Имя для картинки:");
        if (!name)
            return false;
        var id = "image-" + name;
        
        if (localStorage.getItem(id)) {
            alert("Уже есть картинка с таким именем");
            return false;
        }
        addCustomImage(link, name);
        localStorage.setItem(id, link);
    }
    
    

    function addCustomImage(link, name) {
        
        var id = "image-" + name;
        var newImage = createButton(name, function(e) {
            if (deletingSmiles)
                destroyCustomImage(this.id);
            else {
                addTextToForm(wrapImageLink(link));
                formTextarea.focus();
            }
            e.preventDefault();
            return false;
        });
        
        newImage.onmousedown = function(e) {
            if (e.which === 2) {
                destroyCustomImage(this.id);
            }
            return false;
        };
        
        newImage.id = id;
        newImage.setAttribute("class", "add-image-button");
        
        var imageContainer = document.getElementById("image-container");
        imageContainer.appendChild(newImage);
        imageContainer.style.display = "block";
    }

    function destroyCustomImage(id) {
        localStorage.removeItem(id);
        document.getElementById("image-container").removeChild(document.getElementById(id));
        if (document.getElementsByClassName("add-image-button").length === 0)
            document.getElementById("image-container").style.display = "none";
    }

    // Custom Smiles

    function createCustomSmile(link) {

        var id = "smile-"+link;
        
        if (localStorage.getItem(id)) {
            alert("Такой смайлик уже добавлен");
            return false;
        }
        addCustomSmile(link)
        localStorage.setItem(id, link);
    }

    function addCustomSmile(link) {
        
        var id = "smile-"+link;
        var newSmile = createSmile('"' + wrapImageLink(link) + '":' + link, link);
        
        newSmile.onmousedown = function(e) {
            if (e.which === 2) {
                destroyCustomSmile(this.id);
            }
            return false;
        };
        newSmile.title = "Средняя кнопка мыши для удаления";
        newSmile.id = id;
        newSmile.setAttribute("class", "add-smile-link");
        document.getElementById("smile-panel").insertBefore(newSmile,
                                                        document.getElementById("image-container"));
    }

    function destroyCustomSmile(id) {
        localStorage.removeItem(id);
        document.getElementById("smile-panel").removeChild(document.getElementById(id));
    }

    function addSmileClick(e) {
        
        var link = prompt("Ссылка на картинку или номер файла на ргхосте:");
        var image = new Image();
        
        if (!link)
            return false;
        
        if (/(\d+)\D*$/.test(link))
            var num = /(\d+)\D*$/.exec(link)[1];
        
        image.src = link;
        image.onerror = function() {
            if(num) {
                link = "http://rghost.ru/" + num + "/image.png";
                image.src = link;
            }
            image.onerror = function() {
                alert("Ошибка при загрузке картинки");
            }
        }
        image.onload = function() {
            if (image.width > 45 || image.heigth > 45) {
                createCustomImage(link);
            } else {
                createCustomSmile(link);
            }
        }
        e.preventDefault();
        return false;
    }

    function removeSmilesClick(e) {
        const redCross = "http://1chan.inach.org/ico/remove.gif";
        const whiteCross = "http://1chan.inach.org/ico/delete.gif";
        
        if (!deletingSmiles) {
            document.getElementById("remove-smiles-icon").src = whiteCross;
            deletingSmiles = true;
        } else {
            document.getElementById("remove-smiles-icon").src = redCross;
            deletingSmiles = false;
        }
        e.preventDefault();
        return false;
    }


    function addCustomPaste(paste, name) {
            
            var id = "paste-" + name;
        var newPaste = createButton(name, function(e) {

                addTextToForm(paste);
                formTextarea.focus();
            
            e.preventDefault();
            return false;
        });
        

        newPaste.id = id;
        newPaste.setAttribute("class", "add-paste-button");
        
        var pasteContainer = document.getElementById("paste-container");
        pasteContainer.appendChild(newPaste);
        pasteContainer.style.display = "block";
    }

    function destroyCustomImage(id) {
        localStorage.removeItem(id);
        document.getElementById("image-container").removeChild(document.getElementById(id));
        if (document.getElementsByClassName("add-image-button").length === 0)
            document.getElementById("image-container").style.display = "none";
        }

    /* function generatePastePanel() {
            for(var i = 0; i < pasteNum; i++)
                {
                var id = "paste-" + i;
                var paste = localStorage.getItem(id);
                var name = paste.substring(0,15) + "...";
                addCustomPaste(paste, name);               
                
            }
    }
    */

    function createSmilePanel() {
      
        var container = document.createElement("div");
        var gifSmileList = [ "coolface", "desu", "nyan", "sobak", "trollface"];
        var pngSmileList = ["awesome", "ffuu", "okay", "rage"];
        var imageContainer = document.createElement("div");
        var pasteContainer = document.createElement("div");
        var br1 = document.createElement("br");
        var br2 = document.createElement("br");
        var br3 = document.createElement("br");
        
        var smileTextNode = document.createTextNode("Смайлики");
        container.appendChild(smileTextNode);
        container.appendChild(br1);
        
        for(var i in gifSmileList) {
            var newSmile = createSmile(':'+gifSmileList[i]+':', "http://1chan.inach.org/img/" + gifSmileList[i] + ".gif");
            container.appendChild(newSmile);
        }
        for(var i in pngSmileList) {
            var newSmile = createSmile(':'+pngSmileList[i]+':', "http://1chan.inach.org/img/" + pngSmileList[i] + ".png");
            container.appendChild(newSmile);
        }
        
        var addSmileLink = document.createElement("a");
        var addSmileImg = document.createElement("img");
        addSmileImg.src = "http://cdn1.iconfinder.com/data/icons/basicset/plus_16.png";
        addSmileLink.href = "#";
        addSmileLink.onclick = addSmileClick;
        addSmileLink.appendChild(addSmileImg);
        addSmileLink.title = "Добавить смайлик или картинку";
        
        var removeSmilesLink = document.createElement("a");
        var removeSmilesImg = document.createElement("img");
        removeSmilesImg.src = "http://1chan.inach.org/ico/remove.gif";
        removeSmilesImg.id = "remove-smiles-icon";
        removeSmilesLink.href = "#";
        removeSmilesLink.onclick = removeSmilesClick;
        removeSmilesLink.appendChild(removeSmilesImg);
        removeSmilesLink.title = "Удалить смайлики или картинки";
        
        var controlsContainer = document.createElement("span");
        controlsContainer.style.cssFloat = "right";
        controlsContainer.style.margin = "5px";
        
        controlsContainer.appendChild(addSmileLink);
        controlsContainer.appendChild(document.createElement("br"));
        controlsContainer.appendChild(removeSmilesLink);
        
        container.appendChild(controlsContainer);
        container.style.minHeight = "50px";
        
        if(/\.ru\/news\/add/.test(document.URL)) { // news/add
            container.style.width = '530px'
            container.style.border = "1px solid #999999";
            container.id = "smile-panel";
            document.getElementsByName('text_full')[0].parentNode.insertBefore(container,
                                                        document.getElementsByName('text_full')[0]);
        }
        else {
            container.style.margin = "10px";
            container.style.paddingLeft = "8px";
            container.style.border = "1px solid #CCCCCC";
            container.style.borderRadius = "5px";
            container.id = "smile-panel";
            var formBody = formTextarea.parentNode.parentNode;
            formBody.parentNode.insertBefore(container, formBody);
        }
        
        if(/\.ru\/news/.test(document.URL)) {
            var images = [];
            for(var i = 0; i < localStorage.length; i++) {
                var key = localStorage.key(i);
                if ((/^smile-/).test(key)) {
                    var link = localStorage.getItem(key);
                    addCustomSmile(link);
                } else if ((/^image-.+$/).test(key))
                    images.push(key);
            }
            
            imageContainer.id = "image-container";
            imageContainer.style.margin = "5px 6px 7px 0px";
            imageContainer.style.paddingTop = "2px";
            imageContainer.style.borderTop = "1px dashed #CCCCCC";
                
            container.appendChild(imageContainer);
            var imageTextNode = document.createTextNode("Картинки");
            imageContainer.appendChild(imageTextNode);
            imageContainer.appendChild(br2);
  
            
                
            for(var i in images) {
                var name = /^image-(.+)$/.exec(images[i])[1];
                addCustomImage(localStorage.getItem(images[i]), name);
            }
            
            if (images.length === 0) {
                imageContainer.style.display = "none";
            }
        }
        
        pasteContainer.id = "paste-container";
        pasteContainer.style.margin = "5px 6px 7px 0px";
        pasteContainer.style.paddingTop = "2px";
        pasteContainer.style.borderTop = "1px dashed #CCCCCC";
        container.appendChild(pasteContainer);
        var addPst = document.createElement("a");
        addPst.href = "#";
        addPst.onclick = displayPasteAdd;
        addPst.id = "add-paste-button";
        addPst.textContent = "Добавить";
        //var space = document.createTextNode(" ");
        //var genP = document.createElement("a");
        //genP.href = "";
        //genP.onclick = generatePastePanel;
        //genP.id = "r-paste-button";
        //genP.textContent = "Обновить панель";
        var pasteTextNode = document.createTextNode("Пасты ");
            pasteContainer.appendChild(pasteTextNode);      
            pasteContainer.appendChild(addPst);
        //    pasteContainer.appendChild(space);
        //    pasteContainer.appendChild(genP);
            pasteContainer.appendChild(br3);
            
        for(var i = 0; i < pasteNum; i++)
                {
                var id = "paste-" + i;
                var paste = localStorage.getItem(id);
                var name = paste.substring(0,15) + "...";
                addCustomPaste(paste, name);               
                
            }
        

        

        if(enabledFeatures.indexOf("panel-hiding")!= -1)
            initSmilePanelHiding()
    }

    function initSmilePanelHiding() {
        
        var smilePanel = document.getElementById("smile-panel");
        var showButton = document.createElement("a");
        var showContainer = document.createElement("div");
        var hideButton = document.createElement("a");
        var hideContainer = document.createElement("div");
            
        showButton.onclick = function() {
            showSmilePanel();
            return false;
        };
        showButton.textContent = "Cмайлики и картинки";
        showButton.style.borderBottom = "1px dashed #3366CC";
        showButton.style.textDecoration = "none";
        showButton.href = "#";
        showContainer.appendChild(showButton);
        showContainer.style.display = "none";
        showContainer.style.fontSize = "0.65em";
        showContainer.id = "show-panel-button";
        
        hideButton.onclick = function() {
            hideSmilePanel();
            return false;
        };
        hideButton.textContent = "Спрятать панель";
        hideButton.style.borderBottom = "1px dashed #3366CC";
        hideButton.style.textDecoration = "none";
        hideButton.href = "#";
        hideContainer.appendChild(hideButton);
        hideContainer.style.fontSize = "0.65em";
        hideContainer.id = "hide-panel-button";
        
        if(/\.ru\/news\/add/.test(document.URL)) {
            hideContainer.style.margin = "3px 0px 4px 220px";
            showContainer.style.margin = "3px 0px 4px 210px";
        } else {
            hideContainer.style.margin = "3px 0px -3px 240px";
            showContainer.style.margin = "3px 0px -3px 230px";
        }
            
        smilePanel.parentNode.insertBefore(hideContainer, smilePanel);
        smilePanel.parentNode.insertBefore(showContainer, smilePanel);
            
        if(localStorage.getItem("smile_panel") == "hidden")
            hideSmilePanel();
    }

    function hideSmilePanel() {
        localStorage.setItem("smile_panel", "hidden");
        document.getElementById("smile-panel").style.display = "none";
        document.getElementById("show-panel-button").style.display = "block";
        document.getElementById("hide-panel-button").style.display = "none";
    }

    function showSmilePanel() {
        localStorage.setItem("smile_panel", "visible");
        document.getElementById("smile-panel").style.display = "block";
        document.getElementById("show-panel-button").style.display = "none";
        document.getElementById("hide-panel-button").style.display = "block";
    }


   /*
* Markup Panel
*/

    function getSelectionText(node) {
        var start = node.selectionStart;
        var end = node.selectionEnd;
        return node.value.substring(start, end);
    }

    function wrapText(text, wrapper) {
        return wrapper + text + wrapper;
    }

    function createButton(value, onclick) {
        var button = document.createElement("input");
        button.type = "button";
        button.value = value;
        button.onclick = onclick;
        return button;
    }

    function wrapImageLink(link) {
        if (!link) {
            return "";
        } else if (/rghost/.test(link)) {
            return "[:" + /(\d+)\D*$/.exec(link)[1] + ":]";
        } else {
            return "[" + link + "]";
        }
    }

    function imgClick() {
      
        var link = getSelectionText(formTextarea);
      
        if (link.length > 0) {
            addTextToForm(wrapImageLink(link));
        } else {
            addTextToForm(wrapImageLink(prompt('Ссылка на изображение:')));
        }
    }

    function quoteClick() {
      
        var text = getSelectionText(formTextarea);
        var start = formTextarea.selectionStart;
      
        if (text.length > 0) {
            var formText = formTextarea.value;
            var lines = text.split("\n");
            for(var i in lines) {
                lines[i] = ">>" + lines[i].trim() + "<<";
            }
            addTextToForm(lines.join("\n"));
            if(lines.length == 1)
                formTextarea.setSelectionRange(start + 2, start + text.length + 2);
        } else {
            text = document.getSelection().toString();
            var lines = text.split("\n");
            for(var i in lines) {
              lines[i] = ">" + lines[i].trim();
            }
            addTextToForm(lines.join("\n"));
        }
    }

    function bigBoldClick() {
      
        var text = getSelectionText(formTextarea);
        var lines = text.split("\n");
        var cursor = formTextarea.selectionEnd;
        var start = formTextarea.selectionStart;
        const stars = "\n********************************************";
      
        if (text.length > 0) {
            for(var i in lines) {
                if (lines[i] !== "")
                    lines[i] += stars;
            }
            addTextToForm(lines.join("\n"));
        } else {
            formTextarea.value += stars;
        }
        
        formTextarea.focus();
        if(lines.length == 1 && text.length > 0)
            formTextarea.setSelectionRange(start, start + text.length);
        else
            formTextarea.setSelectionRange(cursor, cursor);
    }

    function bigImgClick() {
      
        var link = getSelectionText(formTextarea);
        
        if (link.length === 0)
            link = prompt('Ссылка на изображение или номер файла на ргхосте:');
        if (!link) {
            formTextarea.focus();
            return false;
        }
        if (/rghost|^[^\/]*\d+[^\/]*$/.test(link)) {
            var num = /(\d+)\D*$/.exec(link)[1];
            link = "http://rghost.ru/" + num + "/image.png";
        }
      
        addTextToForm('"' + wrapImageLink(link) + '":' + link + '');
    }

    function strikeThroughClick() {
        var text = getSelectionText(formTextarea);
        addTextToForm('<s>' + text + '</s>');
    }
    
    function numListClick() {
    }
    
    function mListClick() {
    }
    
    function yobaClick() {
        var selected_text = getSelectionText(formTextarea);
        var has_selected = selected_text.length != 0;

        if(has_selected)
           addTextToForm(yobaTranslate(selected_text));
        else
           formTextarea.value = yobaTranslate(formTextarea.value)
    }

	function brClick() {
	var br = "<br/>";
	addTextToForm(br);
	}
	
	function emptyClick() {
	var emp = "&nbsp;";
	addTextToForm(emp);
	}
	
	function OPReply() {
	var threadNumber = window.location.pathname.split("/")[3];
	var emp = ">>" + threadNumber + '\r';
	addTextToForm(emp);
	}

	function LastReply() {
	var threadNumber = window.location.pathname.split("/")[3];
	var commentNumbers = jQuery(".b-comment_b-info a[name]");
	var emp = ">>" + (commentNumbers.length>0?commentNumbers.last().text():threadNumber) + '\r';
	addTextToForm(emp);
	}	
	function CLRForm() {
	formTextarea.value = "";
	}
		
    function createMarkupPanel() {
      
        var container = document.createElement("div");
        var markup = {
            "B": ["**", "Жирный"],
            "I": ["*", "Наклонный"],
            "C": ["`", "Моноширный"],
            "%": ["%%", "Спойлер"]
        };
        
        var buttons = {
            "img": imgClick,
            "bimg": bigImgClick,
            ">": quoteClick,
            "S": strikeThroughClick,
            "BB": bigBoldClick
        };
        
		var buttons2 = {
            		"Yoba": yobaClick,
			"Zalgo": zalgoClick,
			"BR": brClick,
			"Space": emptyClick
        	};
        	// Каштомные кнопочки! Если нужен еще ряд, нужно скопипастить блок (он отмечен каментами ниже)
		var buttons_kastom = {
            		">>OP": OPReply,
			">>LAST": LastReply,
			"CLR": CLRForm
        	};        	

        for(var k in markup) {
            var newButton = createButton(k, function() {
                var text = getSelectionText(formTextarea);
                var start = formTextarea.selectionStart;
                var selection = formTextarea.selectionStart != formTextarea.selectionEnd;
                var m = markup[this.value][0];
                text = wrapText(text, m);
                addTextToForm(text);
                if(selection)
                    formTextarea.setSelectionRange(start, start + text.length);
                else
                    formTextarea.setSelectionRange(start + m.length, start + m.length);
                });
            container.appendChild(newButton);
        }
		
		container.appendChild(document.createElement("br"));
		
		for (var k in buttons)
            container.appendChild(createButton(k, buttons[k]));
			
		container.appendChild(document.createElement("br"));
		
		for (var k in buttons2)
            container.appendChild(createButton(k, buttons2[k]));
            // Камент. Начало блока, который копипастится для еще ряда кнопочек. Не забудь buttons_kastom на новое значение заменить.
            container.appendChild(document.createElement("br"));
            
            
            for (var k in buttons_kastom)
            container.appendChild(createButton(k, buttons_kastom[k]));
            // Конец блока.
        if(/\.ru\/news\/add/.test(document.URL)) {
            container.style.paddingTop = "4px";
            document.getElementsByName('text_full')[0].parentNode.insertBefore(container,
                                                        document.getElementsByName('text_full')[0])
            document.addEventListener('click', function(event){
                if(/text/.test(event.target.name))
                    formTextarea = event.target // Смена полей в news/add
                })
        } else {
            if(enabledFeatures.indexOf("markup-top") == -1) {
                container.style.display = "inline-block";
                formTextarea.parentNode.insertBefore(container,
                                document.getElementsByClassName("b-comment-form_b-uplink")[0]);
            } else {
                container.style.marginTop = "3px";
                formTextarea.style.margin = "3px 0px 6px"
                formTextarea.parentNode.insertBefore(container, formTextarea);
            }
        }
    }


   /*
* Spoilers
*/
    
    function revealSpoilers() {
        var spoilers = document.getElementsByClassName('b-spoiler-text')
        for(var i = 0; i<spoilers.length; i++)
            spoilers[i].setAttribute('style', 'color:#40454B !important')
    }

/*
* Zalgo Gen
*/
	function rand(max)
			{
				return Math.floor(Math.random() * max);
			}

	function rand_zalgo(array)
			{
				var ind = Math.floor(Math.random() * array.length);
				return array[ind];
			}
	
	function toggle(id)
			{
				if(document.getElementById(id).style.display == "none")
					document.getElementById(id).style.display = "block";
				else
					document.getElementById(id).style.display = "none";
			}
			
	function is_zalgo_char(c)
			{
				var i;
				for(i=0; i<zalgo_up.length; i++)
					if(c == zalgo_up[i])
						return true;
				for(i=0; i<zalgo_down.length; i++)
					if(c == zalgo_down[i])
						return true;
				for(i=0; i<zalgo_mid.length; i++)
					if(c == zalgo_mid[i])
						return true;
				return false;
			}
			
    function zalgoClick() 
			{
        var selected_text = getSelectionText(formTextarea);
        var has_selected = selected_text.length != 0;

        if(has_selected)
           addTextToForm(zalgoFuckUp(selected_text));
        else
           formTextarea.value = zalgoFuckUp(formTextarea.value)
    }
	
	function zalgoFuckUp(text)
			{
				
				var txt = text;
				var newtxt = '';
					
				for(var i=0; i<txt.length; i++)
				{
					if(is_zalgo_char(txt.substr(i, 1)))
						continue;
					
					var num_up;
					var num_mid;
					var num_down;
					
					
					newtxt += txt.substr(i, 1);


						num_up = rand(16) / 2 + 1;
						num_mid = rand(6) / 2;
						num_down = rand(16) / 2 + 1;

					
	
						for(var j=0; j<num_up; j++)
							newtxt += rand_zalgo(zalgo_up);
			
						for(var j=0; j<num_mid; j++)
							newtxt += rand_zalgo(zalgo_mid);
				
						for(var j=0; j<num_down; j++)
							newtxt += rand_zalgo(zalgo_down);
				}

				
				return newtxt;

				
			}
	
/*
* Yoba Translator
*/

   var yoba_main = {
      'а': ["a"],
      'б': ["b"],
      'в': ["v"],
      'г': ["g"],
      'д': ["d"],
      'е': ["ye", "e"],
      'ё': ["yo"],
      'ж': ["zh"],
      'з': ["z"],
      'и': ["i", "ee"],
      'й': ["y", "j"],
      'к': ["k", "ck", "q"],
      'л': ["l"],
      'м': ["m"],
      'н': ["n"],
      'о': ["o", "ou"],
      'п': ["p"],
      'р': ["r"],
      'с': ["s"],
      'т': ["t"],
      'у': ["oo", "u"],
      'ф': ["f"],
      'х': ["kh"],
      'ц': ["c"],
      'ч': ["ch"],
      'ш': ["sh"],
      'щ': ["sh"],
      'ы': ["y", "i"],
      'э': ["e"],
      'ю': ["yu"],
      'я': ["ya"],
   };

   var yoba_ends = {
      'и': ["ey"],
      'е': ["eu"],
      'о': ["ou"],
   };

   function pickRandomElement(arr) {
      if(arr.length == 0)
         return null;
      else if(arr.length == 1)
         return arr[0];
      else
         return arr[Math.floor(Math.random() * arr.length)];
   }

   function yobaTranslate(str) {
      var result = "";

      str = str.replace(/[ьъ]/gi, "");

      for(var pos = 0; pos < str.length; pos++)
      {
         var from = str[pos];
         var to = '';

         var is_upper = from == from.toUpperCase();
         from = from.toLowerCase();

         if(yoba_ends[from] && (!str[pos + 1] || /[\s\.,!\?]/.test(str[pos + 1])))
            to = pickRandomElement(yoba_ends[from]);
         else if(yoba_main[from])
            to = pickRandomElement(yoba_main[from]);
         else
            to = from;

         if(is_upper)
            to = to[0].toUpperCase() + to.slice(1);

         result += to;
      }

      return result;
   }

   /*
* Menu
*/
    
    function createMenu() {
        var general = document.createElement("a");
        var hidelist = document.createElement("a");
        var hideicon = document.createElement("a");
		//var styles = document.createElement("a");
		var signature = document.createElement("a");
        
        general.href = "#";
        general.onclick = displayGeneralOptions;
        general.id = "general-settings-button";
        hidelist.href = "#";
        hidelist.onclick = displayHideList;
        hidelist.id = "hiding-list-button";
        hideicon.href = "#";
        hideicon.onclick = displayIconHide;
        hideicon.id = "icon-hide-button";
	//styles.href = "#";
        //styles.onclick = displayStyleOptions;
        //styles.id = "style-settings-button"; 
        signature.href = "#";
        signature.onclick = displaySignaturePanel;
        signature.id = "signature-set-button";         
        if(enabledFeatures.indexOf('form-settings')!= -1) {
            var generalIcon = document.createElement("img");
            generalIcon.src = "http://cdn1.iconfinder.com/data/icons/munich/16x16/settings.png";
            general.appendChild(generalIcon);
            var regexpIcon = document.createElement("img");
            regexpIcon.src = "http://vll.java.net/images/GrammarIconRegex.gif";
            hidelist.appendChild(regexpIcon);
            var iconIcon = document.createElement("img");
            iconIcon.src = "https://cdn1.iconfinder.com/data/icons/silk2/eye.png";
            hideicon.appendChild(iconIcon);
			/*var styleIcon = document.createElement("img");
            styleIcon.src = "https://cdn1.iconfinder.com/data/icons/glaze/16x16/mimetypes/source_s.png";
            styles.appendChild(styleIcon);
            */
            var signatureIcon = document.createElement("img");
            signatureIcon.src = "https://cdn1.iconfinder.com/data/icons/silk2/text_signature.png";
            signature.appendChild(signatureIcon);
            var container = formTextarea.parentNode.parentNode.getElementsByTagName("div")[0];
            hidelist.style.cssFloat = "right";
            hideicon.style.cssFloat = "right";
            hideicon.style.margin = "0px 4px 0px 2px";
            general.style.cssFloat = "right";
            general.style.margin = "0px 10px 0px 2px";
			//styles.style.cssFloat = "right";
            //styles.style.margin = "0px 2px 0px 2px";
            signature.style.cssFloat = "right";
            signature.style.margin = "0px 2px 0px 2px";
            general.title = "Настройки скрипта";
            hideicon.title = "Скрытие постов по иконке";
            hidelist.title = "Список скрываемых выражений";
			//styles.title = "Сменить стиль";
			signature.title = "Задать подпись";
            container.parentNode.insertBefore(general, container);
            container.parentNode.insertBefore(hidelist, container);
            container.parentNode.insertBefore(hideicon, container);
            container.parentNode.insertBefore(signature, container);
			//container.parentNode.insertBefore(styles, container);
        } else {
            var container = document.getElementsByClassName("b-menu-panel_b-links")[0];
            general.textContent = "Настройки скрипта";
            hidelist.textContent = "Список скрываемых выражений";
            hideicon.textContent = "Скрытие постов по иконке";
            signature.textContent = "Задать подпись";
			//styles.textContent = "Сменить стиль";
            container.appendChild(general);
            container.appendChild(document.createElement("br"));
            container.appendChild(hidelist);
			container.appendChild(document.createElement("br"));
			container.appendChild(hideicon);
			container.appendChild(document.createElement("br"));
			container.appendChild(signature);
            //container.appendChild(styles);
        }
    }

    function hideGeneralOptions() {
        var cont = document.getElementById('scriptsettings');
        cont.parentNode.removeChild(cont);
        document.getElementById('general-settings-button').onclick = displayGeneralOptions;
        return false;
    }
	/*
	function hideStyleOptions() {
        var stl = document.getElementById('stylesettings');
        stl.parentNode.removeChild(stl);
        document.getElementById('style-settings-button').onclick = displayStyleOptions;
        return false;
    }
*/
    function hideHideList() {
        var menu = document.getElementById('regexps').parentNode;
        menu.parentNode.removeChild(menu);
        document.getElementById('hiding-list-button').onclick = displayHideList;
        return false;
    }

/* 	function createYTPlayer(vlink, glue) {
	var player = document.createElement("iframe");
	player.id = "ytplayer";
	player.width = "340";
	player.height = "220";
	player.src = vlink;
	player.frameborder = 0;
	jQuery(glue).append(player);
	var tag = document.createElement('script');
	tag.src = "https://www.youtube.com/player_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	var player;
		function onYouTubePlayerAPIReady() {
			player = new YT.Player('ytplayer', {
			height: '390',
			width: '640',
			videoId: link
			});
		} 
		
	} 
*/
	
    function displayGeneralOptions() {
        var container = document.createElement("div");
        document.getElementById('general-settings-button').onclick = hideGeneralOptions;
        container.id = 'scriptsettings'
        container.setAttribute("style", 'top: 5px; left:5px; position:fixed; z-index: 10000; background: #EAF4FF; padding: 5px');
		container.appendChild(document.createTextNode('Общие настройки скрипта'));
		container.appendChild(document.createElement('br'));
        for(var i = 0; i < features.length; i++) {
            var desc = document.createElement('p');
            desc.textContent = descriptions[i];
            desc.style.display = 'inline';
            desc.style.fontSize = '0.75em'
            var box = document.createElement('input');
            box.type = 'checkbox';
            box.className = 'opt';
            box.id = features[i];
            container.appendChild(box);
            container.appendChild(desc);
            container.appendChild(document.createElement('br'));
        }
        btn = document.createElement("button");
        btn.textContent = "Сохранить";
        btn.href = "#";
        btn.onclick = saveGeneralOptions;
        //btn2 = document.createElement("button");
        //btn2.textContent = "Сбросить все";
        //btn2.href = "#";
        //btn2.onclick = resetAll;
        container.appendChild(btn);
        //container.appendChild(btn2);
        container.appendChild(document.createElement('br'));
        
        document.getElementsByTagName("body")[0].appendChild(container)
        for(var i = 0; i<enabledFeatures.length; i++)
            if(enabledFeatures[i] != '')
                    document.getElementById(enabledFeatures[i]).checked = true;
        return false;
    }
    
 
    
    function displayIconHide() {
        
        var container = document.createElement("div");
        document.getElementById('icon-hide-button').onclick = hideIconHide;
        container.id = 'iconsettings'
        container.setAttribute("style", 'top: 5px; left:5px; position:fixed; z-index: 10000; background: #EAF4FF; padding: 5px');
		container.appendChild(document.createTextNode('Скрытие по выбранной'));
		container.appendChild(document.createElement('br'));
		container.appendChild(document.createTextNode('принадлежности'));
		container.appendChild(document.createElement('br'));
        for(var i = 0; i < codeIcon.length; i++) {
            var desc = document.createElement('p');
            desc.textContent = nameIcon[i];
            desc.style.display = 'inline';
            desc.style.fontSize = '0.75em'
            var box = document.createElement('input');
            box.type = 'checkbox';
            box.className = 'opt';
            box.id = codeIcon[i];
            container.appendChild(box);
            container.appendChild(desc);
            container.appendChild(document.createElement('br'));
        }
        btn = document.createElement("button");
        btn.textContent = "Сохранить";
        btn.href = "#";
        btn.onclick = saveIconHide;
        container.appendChild(btn);
        container.appendChild(document.createElement('br'));
        
        document.getElementsByTagName("body")[0].appendChild(container)
        for(var i = 0; i<enabledFeatures.length; i++)
            if(enabledFeatures[i] != '')
                    document.getElementById(enabledFeatures[i]).checked = true;
        return false;
    }
    
    function saveIconHide() {
    enabledIcons = [];
        document.getElementById('icon-hide-button').onclick = displayIconHide;
        var boxes = document.getElementsByClassName('opt');
        for(var i = 0; i<boxes.length; i++)
            if(boxes[i].checked)
                enabledIcons.push(boxes[i].id);
        var str = '';
        for(var i = 0; i < enabledIcons.length; i++)
            str += enabledIcons[i] + ' ';
        localStorage['iconh' + VERSION] = str;
        cont = document.getElementById('iconsettings');
        cont.parentNode.removeChild(cont)
    window.location.reload()
    }
    
    function hideIconHide() {
        var cont = document.getElementById('iconsettings');
        cont.parentNode.removeChild(cont);
        document.getElementById('icon-hide-button').onclick = displayIconHide;
        return false;
    }
    
    function hideSignaturePanel() {
        var sign = document.getElementById('signpanel');
        sign.parentNode.removeChild(sign);
        document.getElementById('signature-set-button').onclick = displaySignaturePanel;
        return false;
    }
    
    function displaySignaturePanel() {
    	var container = document.createElement("div");
    	document.getElementById('signature-set-button').onclick = hideSignaturePanel;
    	container.id = 'signpanel'
    	container.setAttribute("style", 'top: 5px; left:5px; position:fixed; z-index: 10000; background: #EAF4FF; padding: 5px');
        container.appendChild(document.createTextNode('Задать подпись:'));
	container.appendChild(document.createElement('br'));
	jQuery(container).append("<p style='font-size: 0.75em; display: inline;'>Введите подпись:</p>");
		$('<input>').attr({
		type: 'text',
    		id: 'signatureInputTextField',
		}).appendTo(container);4
	container.appendChild(document.createElement('hr'));
	jQuery(container).append("<p style='font-size: 0.75em; display: inline;'>Обрабатывать форму ввода подписей как массив?</p>");
		$('<input>').attr({
		type: 'checkbox',
    		id: 'signatureInputIsArray',
		}).appendTo(container);
		container.appendChild(document.createElement('br'));
	jQuery(container).append("<p style='font-size: 0.5em; display: inline;'>Разделителем в таком случае является |, подписи постятся последовательно.</p>");
	container.appendChild(document.createElement('hr'));
	jQuery(container).append("<p style='font-size: 0.75em; display: inline;'>Включить подпись в автоматических постах?</p>");
		$('<input>').attr({
		type: 'checkbox',
    		id: 'signatureInAutoMessages',
		}).appendTo(container);
		container.appendChild(document.createElement('br'));
	jQuery(container).append("<p style='font-size: 0.5em; display: inline;'>Это не относится к некоторым из функций. Также возможны ошибки.</p>");
	container.appendChild(document.createElement('hr'));
	btnsave = document.createElement("button");
        btnsave.textContent = "Сохранить";
        btnsave.href = "#";
        btnsave.onclick = saveSignatureOptions;
	container.appendChild(btnsave);
	btnleave = document.createElement("button");
        btnleave.textContent = "Не сохранить";
        btnleave.href = "#";
        btnleave.onclick = hideSignaturePanel;
	container.appendChild(btnleave);
        container.appendChild(document.createElement('br'));
		document.getElementsByTagName("body")[0].appendChild(container);
    };
    
    function saveSignatureOptions() {
    	var signatureFieldValue = document.getElementById('signatureInputTextField').value;
    	console.log("SIGN FIELD VALUE: " + signatureFieldValue);
    	var signatureCheckboxArrayValue = document.getElementById('signatureInputIsArray').checked;
    	console.log("SIGNATURE ARRAY ENABLED: " + signatureCheckboxArrayValue);
    	var signatureInAutoMessagesValue = document.getElementById('signatureInAutoMessages').checked;
    	console.log("SIGNATURE AUTO MESSAGES ENABLED: " + signatureInAutoMessagesValue);
    	localStorage.setItem('userSignature', signatureFieldValue);
    	localStorage.setItem('isSignatureArray', signatureCheckboxArrayValue);
    	localStorage.setItem('isSignatureAutomatic', signatureInAutoMessagesValue);
    	hideSignaturePanel();
    	location.reload();
    }
    
       // НИЧЕГО НЕ ТРОГАТЬ ОНО РАБОТАЕТ ЕЛЕ-ЕЛЕ СУКА РАЗВАЛИВАЕТСЯ БЛЯТЬ ПИЗДЕЦ НАХУЙ       
    function redefineSignatureValue() {
    	var signatureValue = localStorage.getItem('userSignature'); // какого хуя я должен определять это каждый ебаный раз?! быдлокоденх, он самый =(
    	signatureValueAsArray = signatureValue.split('|');
    	//alert(signatureValueAsArray);
    	var signatureArrayCurPos = parseInt(localStorage.getItem('signArrayCurPos'));
    	console.log("SACP: " + signatureArrayCurPos);
    	signatureArrayLength = signatureValueAsArray.length - 1;
    	console.log(signatureArrayLength);
    	signatureArraySelectedValue = signatureValueAsArray[signatureArrayCurPos];
    	console.log(signatureArraySelectedValue);
    	if(signatureArrayCurPos == signatureArrayLength) {
    	    console.log("FST IF ARRIVED");
    	    localStorage.setItem('signArrayCurPos', "0");
    	}
    	if(signatureArrayCurPos < signatureArrayLength) {
    	    console.log("SND IF ARRIVED");
    	    signatureArrayNextPos = signatureArrayCurPos + 1;
    	    console.log("Signature array now: " + signatureArrayNextPos);
    	    localStorage.setItem('signArrayCurPos', signatureArrayNextPos);
    	}
    }
       
    function initSignatureOptions() {
    var commentFormContainer = document.getElementById('comment_form');
        if (localStorage.getItem('userSignature') == null || localStorage.getItem('userSignature') == "") {
            var isSignatureUSetted = false;
            //var autoSignatureValue = false;
            localStorage.setItem('isSignatureAutomatic', "false"); // STRING, а не BOOL; SET, а не GET;
        }
        else { 
            var isSignatureUSetted = true;
            var signatureValue = localStorage.getItem('userSignature'); // если будет массив, то переопределится
            var signatureArrayEnabled = localStorage.getItem('isSignatureArray'); 
            var signatureArrayCurPos = localStorage.getItem('signArrayCurPos');
            if (signatureArrayCurPos == '' || signatureArrayCurPos == null) {
            	localStorage.setItem('signArrayCurPos', "0");
            }          
            //var autoSignatureValue = localStorage.getItem('isSignatureAutomatic'); // это здесь не нужно
            var sendButtonNumber = commentFormContainer.getElementsByTagName('input').length - 1;
            var sendButton = commentFormContainer.getElementsByTagName('input')[sendButtonNumber];
            $( "<p align='center' style='color:red; margin: 4px 0px;'>ОСТОРОЖНО, ВКЛЮЧЕНА ПОДПИСЬ: " + signatureValue + "<a style='color: black'> (<abbr title='Не влияет на автоматические посты'>Временно выключить</abbr><input style='display: inline;' id='tempDisableSignature' type='checkbox'></input>)</a></p>" ).insertBefore( formTextarea );
            sendButton.addEventListener("click", function(e) {
            	if(signatureArrayEnabled == 'true') {
            	    redefineSignatureValue();
            	    signatureValue = signatureArraySelectedValue;
		    var signatureArrayPrevPos = signatureArrayCurPos - 1;
		    if (signatureArrayPrevPos == -1) {
		    	signatureArrayPrevPos = signatureArrayLength;
		    }
            	    console.log(signatureArrayPrevPos);
            	    console.log("PREV: (" + signatureArrayPrevPos + ") " + signatureValueAsArray[signatureArrayPrevPos]);
            	    console.log("NOW: (" + signatureArrayCurPos + ") " + signatureValueAsArray[signatureArrayCurPos]);
            	    formTextarea.value = formTextarea.value.replace(signatureValueAsArray[signatureArrayPrevPos], signatureValueAsArray[signatureArrayCurPos]);
            	}
            	if(formTextarea.value.substring(formTextarea.value.length - signatureValue.toString().length, formTextarea.value.length) != signatureValue.toString() && document.getElementById('tempDisableSignature').checked == false) {
  		    	    formTextarea.value += "\n" + signatureValue;
  		    	
  		};
	    });
	    formTextarea.addEventListener("keydown", function(e) {
    		if (e.ctrlKey && e.keyCode === 13) {
    		    if(signatureArrayEnabled == 'true') {
            	    redefineSignatureValue();
            	    signatureValue = signatureArraySelectedValue;
		    var signatureArrayPrevPos = signatureArrayCurPos - 1;
		    if (signatureArrayPrevPos == -1) {
		    	signatureArrayPrevPos = signatureArrayLength;
		    }
            	    console.log(signatureArrayPrevPos);
            	    console.log("PREV: (" + signatureArrayPrevPos + ") " + signatureValueAsArray[signatureArrayPrevPos]);
            	    console.log("NOW: (" + signatureArrayCurPos + ") " + signatureValueAsArray[signatureArrayCurPos]);
            	    formTextarea.value = formTextarea.value.replace(signatureValueAsArray[signatureArrayPrevPos], signatureValueAsArray[signatureArrayCurPos]);
            	}
       		    if(formTextarea.value.substring(formTextarea.value.length - signatureValue.toString().length, formTextarea.value.length) != signatureValue.toString() && document.getElementById('tempDisableSignature').checked == false) {
  		    	    formTextarea.value += "\n" + signatureValue;
  		    };
    		};
	    });
	    
        }
    }
    
	/*
	function displayStyleOptions() {
        var container = document.createElement("div");
        document.getElementById('style-settings-button').onclick = hideStyleOptions;
        container.id = 'stylesettings'
        container.setAttribute("style", 'top: 5px; left:5px; position:fixed; 
		z-index: 10000; background: #EAF4FF; padding: 5px');
        container.appendChild(document.createTextNode('Сменить стиль:'));
		container.appendChild(document.createElement('br'));
        
        for (var i = 0; i<styleCode.length; i++) 
            {
                var sbox = document.createElement('input');
                var sdesc = document.createElement('p');
                sdesc.textContent = styleName[i];
                sdesc.style.display = 'inline';
                sdesc.style.fontSize = '0.75em'
                sbox.setAttribute('type', 'radio');
                sbox.setAttribute('name', 'sopt');
                sbox.id = styleCode[i];
                container.appendChild(sbox);
                container.appendChild(sdesc);
                container.appendChild(document.createElement('br'));
            }
        
        sbtn = document.createElement("button");
        sbtn.textContent = "Сменить стиль";
        sbtn.href = "#";
        sbtn.onclick = saveStyleOptions;
        container.appendChild(sbtn);
        document.getElementsByTagName("body")[0].appendChild(container)
        for(var i = 0; i<enabledFeatures.length; i++)
            if(enabledFeatures[i] != '')
                    document.getElementById(enabledFeatures[i]).checked = true;
        return false;
    }
*/
    function saveGeneralOptions() {
    enabledFeatures = [];
        document.getElementById('general-settings-button').onclick = displayGeneralOptions;
        var boxes = document.getElementsByClassName('opt');
        for(var i = 0; i<boxes.length; i++)
            if(boxes[i].checked)
                enabledFeatures.push(boxes[i].id);
        var str = '';
        for(var i = 0; i < enabledFeatures.length; i++)
            str += enabledFeatures[i] + ' ';
        localStorage['settings' + VERSION] = str;
        cont = document.getElementById('scriptsettings');
        cont.parentNode.removeChild(cont)
    window.location.reload()
    }
    
    function saveStyleOptions() {
        document.getElementById('style-settings-button').onclick = displayStyleOptions;
        enabledStyles = [];
        var boxes = document.getElementsByName('sopt');
        for(var i = 0; i<boxes.length; i++)
            if(boxes[i].checked)
                enabledStyles.push(boxes[i].id);
        var str = '';
        for(var i = 0; i < enabledStyles.length; i++)
            str += enabledStyles[i] + ' ';
        localStorage['styles' + VERSION] = str;
        stl = document.getElementById('stylesettings');
        stl.parentNode.removeChild(stl)
    window.location.reload()
    }
    
    
    function displayHideList() {
        var container = document.createElement("div")
        document.getElementById('hiding-list-button').onclick = hideHideList;
        container.setAttribute("style", "top: 5px; left:5px; position:fixed; z-index: 10000; background: #EAF4FF; border: 1px black")
        var list = document.createElement("textarea")
        list.id = "regexps"
        list.setAttribute("style", "width: 300px; height: 300px; margin:5px")
        for(var key in localStorage)
            if(/hidephrase/.test(key))
                list.value += localStorage[key] + '\n'
        var button = document.createElement("button")
        button.textContent = "Сохранить"
        button.onclick = updateRegexps;
        button.style.margin = "5px"
        var desc = document.createTextNode("Каждое новое исключение должно");
        var desc2 = document.createTextNode("быть на новой строчке");
        container.appendChild(desc);
        container.appendChild(document.createElement('br'));
        container.appendChild(desc2);
        container.appendChild(document.createElement('br'));
        container.appendChild(list)
        container.appendChild(document.createElement("br"))
        container.appendChild(button)
        document.getElementsByTagName("body")[0].appendChild(container)
        return false;
    }

    function updateRegexps() {
        document.getElementById('hiding-list-button').onclick = displayHideList;
        for(var key in localStorage)
            if(/hidephrase/.test(key))
                localStorage.removeItem(key);
        regexps = document.getElementById('regexps').value.split('\n');
        for(var i = 0; i < regexps.length; i++) {
            if(regexps[i] != "") {
                localStorage.setItem("hidephrase" + i, regexps[i]);
            }
        }
        menu = document.getElementById('regexps').parentNode;
        menu.parentNode.removeChild(menu);
    }

    function hideDefaultButton() {
    	sendButtonDefault = jQuery(".b-comment-form input[type=submit]");
    	$(sendButtonDefault).css({"display":"none"});
    }
    

// СПИЗЖЕННЫЙ КОД: АВТОЖДАЛКА BEGIN


        
      function autoSenderMessagesBegin() {
	var postscounter = unsafeWindow.jQuery(".b-comment").length;
	var postcounteraft = postscounter;
	var timerForAutoSender;

	if (timerForAutoSender) {window.clearInterval(timerForAutoSender);}
	timerForAutoSender = window.setInterval(function() {
		if (postscounter == postcounteraft) {
			var threadNumber = window.location.pathname.split("/")[3];
                    jQuery.post("http://1chan.inach.org/news/res/"+threadNumber+"/add_comment/", {"post_id": threadNumber, "captcha_key": "comment", "captcha": "", "homeboard": "anonymous", "text": "DESU" });
                    console.log('DESU');
			 // САКРАЛЬНОЕ МЕСТО!! Здесь можно интегрировать любую хуиту короче, тупо вызываем функтсию какую надо вместо этой.
			// Вот я пидарас, евал использую. Но так удобнее интегрировать будет, так что похуй.
			postcounteraft++;
			postcounteraft++;
		}
		postscounter = unsafeWindow.jQuery(".b-comment").length;
	}, 300);

}

//Насрать в комментах, стоп

function autoSenderMessagesStop() {
	if (timerForAutoSender) {
       window.clearInterval(timerForAutoSender);
       timerForAutoSender = null;
	} else {

		alert("ЭТО БЫЛА ВАЖНАЯ ХУЙНЯ МОЖЕТ ВСЕ-ТАКИ?");
	}
}

        
// СПИЗЖЕННЫЙ КОД: АВТОЖДАЛКА END


   /*
* Main
*/

    function letTheSobakOut() {
        var jQOmsk = ".b-blog-panel_b-searchmenu";
		//jQuery(jQOmsk).append("/");
		//jQuery(jQOmsk).append("<a href=\"http:\/\/1chan.inach.org\/service\/theme\/normal\/\">Откл</a>");
		//jQuery(jQOmsk).append("<a style='margin-left: 120px'><a href='http://natribu.org'><img src='https://www.sbsibank.by/pic/question.png' alt='Инструкция по эксплуатации проектора' title='Инструкция по эксплуатации проектора'</a></a>");
        try {
            pasteNum = localStorage.getItem('pstNumber') - 1;
            enabledFeatures = localStorage['settings' + VERSION].split(' ');
            enabledStyles = localStorage['styles' + VERSION].split(' ');
            enabledIcons = localStorage['iconh' + VERSION].split(' ');
            enabledFeatures += enabledStyles;
            enabledFeatures += enabledIcons;
        } catch(keyerror) {
            enabledFeatures = features;
            var str = '';
            for(var i = 0; i < features.length; i++ )
                str += features[i] + ' ';
            localStorage['settings' + VERSION] = str;
            
            //enabledStyles = styleCode;
            //var str = '';
            //for(var i = 0; i < styleCode.length; i++ )
            //    str += styleCode[i] + ' ';
            //localStorage['styles' + VERSION] = str;
            
            enabledIcons = codeIcon;
            var str = '';
            for(var i = 0; i < codeIcon.length; i++ )
                str += codeIcon[i] + ' ';
            localStorage['iconh' + VERSION] = str;
        }
        
        
        
        formTextarea = document.getElementById("comment_form_text");
        if (!formTextarea)
            formTextarea = document.getElementsByName("text")[0];
        if (formTextarea) {
            if(enabledFeatures.indexOf("answermap")!= -1)
                createRepliesMap();
            if(enabledFeatures.indexOf("hiding")!= -1)
                hidePosts();
            registerAutoupdateHandler();
            deletingSmiles = false;
            if(enabledFeatures.indexOf("markup")!= -1)
                createMarkupPanel();
            if(enabledFeatures.indexOf("smiles")!= -1)
                createSmilePanel();
            if(enabledFeatures.indexOf("tools-panel")!= -1)
                tools40();	
            if(enabledFeatures.indexOf("change-title")!= -1)
                setTitle();
			if(enabledFeatures.indexOf("embed-YT")!= -1)
                renderYouTube();
            
               
        } else {
            if(enabledFeatures.indexOf("hiding")!= -1)
                hideThreads();
                }
                
            
            // STYLES 
            // Стили специально поломаны, потому что автор хуйло и стили накладываются, блять. 
              
            if(enabledFeatures.indexOf("spoilers")!= -1)
                revealSpoilers();
        	if(enabledStyles.indexOf("lenta")!= -1)
                chanDef();	
            if(enabledStyles.indexOf("vk")!= -1)
                chanDef();
            if(enabledStyles.indexOf("photon")!= -1)
                chanDef();
            if(enabledStyles.indexOf("neutron")!= -1)
                chanDef();
            if(enabledStyles.indexOf("futaba")!= -1)
                chanDef();
            if(enabledStyles.indexOf("burichan")!= -1)
                chanDef();
            if(enabledStyles.indexOf("gurochan")!= -1)
                chanDef();
            if(enabledStyles.indexOf("default")!= -1)
                chanDef();
            if(enabledFeatures.indexOf("show-true-face")!= -1)
                showTrueFace();	
             if(enabledFeatures.indexOf("hide-icon")!= -1)
                        {
                
                        if(enabledIcons.indexOf("sosach")!= -1)
                                    hideByChosenIcon("sosach");
                        if(enabledIcons.indexOf("0chan")!= -1)
                                    hideByChosenIcon("0chan");
                        if(enabledIcons.indexOf("iichan")!= -1)
                                    hideByChosenIcon("iichan");
                        if(enabledIcons.indexOf("cirno")!= -1)
                                    hideByChosenIcon("cirno");
                        if(enabledIcons.indexOf("obdrochan")!= -1)
                                    hideByChosenIcon("obdrochan");
                        if(enabledIcons.indexOf("samechan")!= -1)
                                    hideByChosenIcon("samechan");
                        if(enabledIcons.indexOf("tirech")!= -1)
                                    hideByChosenIcon("tirech");
                        if(enabledIcons.indexOf("4chan")!= -1)
                                    hideByChosenIcon("4chan");
                        if(enabledIcons.indexOf("krautchan")!= -1)
                                    hideByChosenIcon("krautchan");
                        if(enabledIcons.indexOf("hivemind")!= -1)
                                    hideByChosenIcon("hivemind");
                        if(enabledIcons.indexOf("olanet")!= -1)
                                    hideByChosenIcon("olanet");
                        if(enabledIcons.indexOf("1chan")!= -1)
                                    hideByChosenIcon("1chan");
                        if(enabledIcons.indexOf("konfopetuh")!= -1)
                                    hideByChosenIcon("konfopetuh");  
                        }
                
                
        
        
       	//setInterval(hideDefaultButton, 1000);

        //createMenu();
        
    }

    if(navigator.appName == "Opera")
        document.addEventListener('DOMContentLoaded', letTheSobakOut);
    else {
        letTheSobakOut();
        
		}