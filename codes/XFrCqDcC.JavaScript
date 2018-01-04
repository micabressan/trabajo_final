// ==UserScript==
// @name        RS07 Polls
// @namespace   rs07_polls
// @include     http://services.runescape.com/m=poll/*/results.ws?id=*
// @require     https://code.jquery.com/jquery-3.2.0.min.js
// @version     1
// @grant       none
// ==/UserScript==

votes_total = 0;
votes_precision = 2;

$('fieldset.question').each(
  function() {
    table   = $(this)[0].getElementsByTagName('table')[0];
    options = table.getElementsByTagName('tr');
    if (votes_total == 0)
      for (i = 0; i < options.length; i++)
        votes_total += parseVotes(options[i].getElementsByTagName('td')[2]);
    if (isYesNo(options)
    ||  isYesNoSkip(options))
    {
      header = $(this)[0].getElementsByTagName('legend')[0]
      isSkip = isYesNoSkip(options);
      newrow = table.insertRow(-1);
      for (i = 0; i < 3; i++)
        newrow.insertCell(i);
      newrow.getElementsByTagName('td')[0].className = 'shield';
      newrow.getElementsByTagName('td')[0].innerText = 'To alter';
      for (i = 0; i < options.length; i++)
      {
        options[i].insertCell(-1);
        options[i].getElementsByTagName('td')[2].style['text-align'] = 'right';
        options[i].getElementsByTagName('td')[3].style['text-align'] = 'right';
      }
      yes  = options[0].getElementsByTagName('td')[2];
      no   = options[1].getElementsByTagName('td')[2];
      alt  =     newrow.getElementsByTagName('td')[2];
      if (isSkip)
        x  = options[2].getElementsByTagName('td')[2];
      yes_ = options[0].getElementsByTagName('td')[3];
      no_  = options[1].getElementsByTagName('td')[3];
      alt_ =     newrow.getElementsByTagName('td')[3];
      if (isSkip)
        x_ = options[2].getElementsByTagName('td')[3];
      votes_yes = parseVotes(yes);
      votes_no  = parseVotes(no);
      votes_rel = votes_yes + votes_no;
      if (isSkip)
        votes_x = parseVotes(x);
      votes_yes_pct = ((votes_yes / votes_rel) * 100).toFixed(votes_precision);
      votes_no_pct  = ((votes_no / votes_rel) * 100).toFixed(votes_precision);
      if (isSkip)
        votes_x_pct = ((votes_x / votes_total) * 100).toFixed(votes_precision);
      tmp_votes_yes = votes_yes;
      tmp_votes_no  = votes_no;
      tmp_votes_rel = votes_rel;
      votes_to_pass = Math.ceil(tmp_votes_rel * .75);
      if (votes_yes >= votes_to_pass)
      {
        pass_colour = 'green';
        do
        {
          if (tmp_votes_yes == votes_to_pass)
            votes_to_alter = 1;
          else
            votes_to_alter = tmp_votes_yes - votes_to_pass;
          tmp_votes_no    += votes_to_alter;
          tmp_votes_rel   += votes_to_alter;
          votes_to_pass    = Math.ceil(tmp_votes_rel * .75);
        }
        while (tmp_votes_yes >= votes_to_pass);
      }
      else
      {
        pass_colour = 'red';
        do
        {
          if (tmp_votes_yes == votes_to_pass)
            votes_to_alter = 1;
          else
            votes_to_alter = votes_to_pass - tmp_votes_yes;
          tmp_votes_yes   += votes_to_alter;
          tmp_votes_rel   += votes_to_alter;
          votes_to_pass    = Math.ceil(tmp_votes_rel * .75);
        }
        while (tmp_votes_yes < votes_to_pass);
        }
      votes_to_alt   = tmp_votes_rel - votes_rel;
      votes_alt_pct  = ((votes_to_alt / votes_rel) * 100).toFixed(votes_precision);
      yes.innerText  = votes_yes_pct + '%';
      no.innerText   = votes_no_pct  + '%';
      alt.innerText  = votes_alt_pct + '%';
      if (isSkip)
        x.innerText  = votes_x_pct   + '%';
      yes_.innerText = numberWithCommas(votes_yes);
      no_.innerText  = numberWithCommas(votes_no);
      alt_.innerText = numberWithCommas(votes_to_alt);
      if (isSkip)
        x_.innerText = numberWithCommas(votes_x);
      if (isSkip)
        x.style['color'] = 'grey';
      header.style['color'] = pass_colour;
    //to_alt  = document.createElement('span');
    //to_alt_ = document.createElement('b');
    //to_alt_.innerText = numberWithCommas(votes_to_alt);
    //to_alt.appendChild(to_alt_);
    //alt_.appendChild(to_alt);
    }
    else
    {
      pass_question = '';
      votes_highest = 0;
      for (i = 0; i < options.length; i++)
      {
        content  = options[i].getElementsByTagName('td')[2];
        content_ = options[i].insertCell(-1);
        votes = parseVotes(content);
        votes_pct = ((votes / votes_total) * 100).toFixed(votes_precision);
        content.style['text-align']  = 'right';
        content_.style['text-align'] = 'right';
        if (votes > votes_highest)
        {
          question = options[i].getElementsByTagName('td')[0];
          if (pass_question)
            pass_question.style.removeProperty('color');
          question.style['color'] = 'green';
          pass_question = question;
          votes_highest = votes;
        }
        content.innerText  = votes_pct + '%';
        content_.innerText = numberWithCommas(votes);
      }
    }
  }
);

$('colgroup').each(
  function() {
    $(this)[0].getElementsByTagName('col')[0].removeAttribute('width');
    $(this)[0].getElementsByTagName('col')[2].removeAttribute('width');
  }
);

function parseVotes(x) {
  return parseInt(x.textContent.match(/^[\d.]+% \((\d+) votes\)$/)[1]);
}

function numberWithCommas(x) {
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

function isYesNo(options) {
  if (options.length == 2
  &&  options[0].getElementsByTagName('td')[0].textContent == 'Yes'
  &&  options[1].getElementsByTagName('td')[0].textContent == 'No')
    return 1;
  return 0;
}

function isYesNoSkip(options) {
  if (options.length == 3
  &&  options[0].getElementsByTagName('td')[0].textContent == 'Yes'
  &&  options[1].getElementsByTagName('td')[0].textContent == 'No'
  &&  options[2].getElementsByTagName('td')[0].textContent == 'Skip question')
    return 1;
  return 0;
}

//votes_yes_pct = toFixedFloor((votes_yes / votes_rel) * 100, votes_precision);
//votes_no_pct  = toFixedFloor(100 - votes_yes_pct, votes_precision);

//function toFixedFloor(number, precision) {
//  var mult = Math.pow(10, precision);
//  return (Math.floor(number * mult) / mult).toFixed(precision);
//}