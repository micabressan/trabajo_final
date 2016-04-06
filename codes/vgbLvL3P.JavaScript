// ==UserScript==
// @name         AFK Showdown
// @namespace    napty
// @description  Bot that automatically answers someone who is PMing you with a pre-set message or a personnalized one. Due to people complaining about spam, the bot won't keep on answering the person once it has sent its message.
// @match        http://play.pokemonshowdown.com*
// @require      http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js
// ==/UserScript==

function createbuttons()
{
    var $buttons = {
        eating: "Sorry, but I can't answer you right now because I am eating.",
        sleeping: "I must have forgotten to turn OFF my PC because I am sleeping.",
        outside: "Sorry, but I'm outside right now, either doing sport or buying stuff. Can't answer you.",
        serie: "I am watching a serie right now, so I'll see your message and I'll answer it at the end of the episode.",
        personnalized: null
    },
        $defaultMessage = "For some reason, I can't answer you right now.";
    
    if(!localStorage.afk)
        localStorage.afk = "{ \"button\": \"personnalized\", \"message\": \""+ $defaultMessage +"\" }";
    
    $.each($buttons, function($activity, $description)
    {
        $("p button[name=credits]").before(
            $("<label>", 
            {
                "for": $activity,
                html : [$("<input>",
                {
                    type: "radio",
                    id: $activity,
                    name: "afk",
                    "data-message": $description,
                    text: $activity,
                    checked: ($activity == "personnalized") ? "checked" : null,
                    click: function($event)
                    {
                        var $afk = JSON.parse(localStorage.afk);
                        
                        $afk["button"]  = $(this).attr("id");
                        $afk["message"] = ($(this).attr("data-message")) ? $(this).attr("data-message") : $("#personnalized-message").val();
                        
                        localStorage.afk = JSON.stringify($afk);
                    }
                }), $activity]
            })
        );
    });
    
    $("p button[name=credits]").before(
       $("<textarea>", 
       {
           css: 
           {
             width: "226px",
             height: "56px"
           },
           id: "personnalized-message",
           html: $defaultMessage,
           keyup: function(event)
           {
               if($("#personnalized").is(":checked"))
               {
                   var $afk = JSON.parse(localStorage.afk);
                   
                   $afk["message"] = $(this).val();
                   
                   localStorage.afk = JSON.stringify($afk);
               }
           }
       })
    );
    
    $("#personnalized").trigger("click");
    
    $("<style>.ps-popup.credits, .ps-overlay { display: none } .bot-off { opacity: 0.7 } .menugroup >p> label { display: inline-block; padding: 5px; }</style>").appendTo("head");
    
    $("p button[name=credits]")
    .text("Bot is OFF")
    .addClass("bot-off")
    .on("click", function(event)
    {
        event.preventDefault();
        
        if($(this).hasClass("bot-off"))
           $(this).removeClass("bot-off").addClass("bot-on").text("Bot is ON");
        else
           $(this).removeClass("bot-on").addClass("bot-off").text("Bot is OFF");
        
    });
}

function pm()
{
    if($("p button[name=credits]").hasClass("bot-off"))
        return;
    
    var $pmbox  = $(".pmbox > div").not(".news-embed"),
        $lobby  = $(".ps-room:not(#mainmenu) .chatbox"),
        $reason = JSON.parse(localStorage.afk),
        $reason = $reason.message;
    
    switch($pmbox.length)
    {
        case 0:
            return false;
            break;
        default:
            $pmbox.each(function($index, $element)
            {
                if(!$($($element).find(".inner div:last-child")).hasClass("mine") && $($element).find(".inner div:last-child").get(0))
                {
                    var $pseudo       = $($($element).find(".inner > div:last-child .username")).text(),
                        $conversation = $($($element).find(".inner")).html();
                        
                    if(!new RegExp($reason, "g").test($conversation))
                    {
                        $($($lobby).find("textarea")).val("/w "+ $pseudo +","+ $reason);
                        $lobby.submit();
                    }
                }
            });
    }
}

window.onload = function()
{
    var script = document.createElement("script");
        script.innerHTML = pm;
        script.innerHTML += createbuttons;
        script.innerHTML += "\nsetInterval(pm, 1000);";
        script.innerHTML += "\ncreatebuttons();";
    
    document.body.appendChild(script);
}