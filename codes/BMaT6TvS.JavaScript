$.ajaxSetup({ cache: false });

function getCurrentComments() {
	return $("li.msg");
}

function getNewComments(callback) {
	$.ajax({
		success: function(body) {
			callback($("li.msg", $(body)));
		}
	});
}

function updateComments() {
	if (window.location.href.indexOf("forum/showtopic-") === -1) return;

	var old = getCurrentComments();
	var container = $(".contentBoxTopicMessageList")[0];

	getNewComments(function(comments) {
		if (comments.length !== old.length) {
			container.insertBefore(comments[comments.length - 2], document.getElementById("addNewMsg"));
		}
	});
}

setInterval(() => updateComments(), 2000);

function doAddMessage() {
    var a = document.getElementById("message_add_form");
    if (a.text_msg.value == "") {
        Alert_popup(lang[0][29][6], lang[0][23][0]);
        return false
    }
    if (a.recaptcha_response_field) {
        var b = Recaptcha.get_response();
        var c = Recaptcha.get_challenge()
    } else if (a.question) {
        var b = a.question.value;
        var c = a.question_sec.value
    } else {
        var b = "";
        var c = ""
    }
    Ajax_Loading("");
    var d = new Array;
    $("#message_add_form input[class='marker_file_ajax']").each(function(a, b) {
        d.push($(b).val())
    });
    if (forum_cpu) {
        var e = dle_root + forum_path + "/add/" + a.topict_id.value + "/post"
    } else {
        var e = dle_root + "index.php?do=" + forum_path + "&action=newpost&id=" + a.topict_id.value + "&param=post"
    }
    $.post(e, {
        text_msg: a.text_msg.value,
        topic_id: a.topict_id.value,
        recaptcha_response_field: b,
        recaptcha_challenge_field: c,
        id_file: d
    }, function(b) {
        Ajax_close("");
        if (b.param == 0) {
            Alert_popup(b.data, lang[0][23][0]);
            return false
        } 
        setElementForum()
    }, "json")
}