(function () {
  'use strict';
  /* select active tab in balance */

  window.addEventListener('load', function () {
    $.when(
      $.ajax({
        url: './expenses'
      }),
      $.ajax({
        url: './income'
      })
    )
      .done(function (categoriesCredit, categoriesDebit) {
        var tabsBalance = document.querySelectorAll('.menu-tabs_balance .menu-tabs__nav-item');

        var existExpenses = false;
        var existIncome = false;
        for (var i=0; i<categoriesCredit[0].length; i++ ) {
          if (categoriesCredit[0][i].sum > 0) {
            existExpenses = true;
            break;
          }
        }
        for (var i=0; i<categoriesDebit[0].length; i++ ) {
          if (categoriesDebit[0][i].sum > 0) {
            existIncome = true;
            break;
          }
        }
        /* Toggle tabs in balance */
        for (var i = 0; i < tabsBalance.length; i++) {
          tabsBalance[i].addEventListener('click', activeContentBalance.bind(this, existExpenses, existIncome));
        }
        tabsBalance[0].click();
        var firstTab = document.querySelectorAll('.js-first-tab');
        if (firstTab) {
          firstTab[0].classList.add('active');
        }
        calendarDisplay();

        var contentCredit = document.getElementById('balance-credit');
        (categoriesCredit.length > 0) ? showData(contentCredit, categoriesCredit[0]) : showEmpty(contentCredit);
        var calendarCredit = contentCredit.querySelector('.form-calendar');
        calendarCredit.onchange = function () {
          showData(contentCredit, categoriesCredit);
        };

        var contentDebit = document.getElementById('balance-debit');
        (categoriesDebit.length > 0) ? showData(contentDebit, categoriesDebit[0]) : showEmpty(contentDebit);

        var calendarDebit = contentDebit.querySelector('.form-calendar');
        calendarDebit.onchange = function (event) {
          showData(contentDebit, categoriesDebit);
        };

        var buttonOpenPrevModal = document.querySelector('.modal-questions .modal-button-close');
        buttonOpenPrevModal.addEventListener('click', window.openModal);

        var buttonClearModalBalance = document.querySelector('.modal-balance .modal-button-close');
        buttonClearModalBalance.addEventListener('click', modalBalanceContent);

      });
  });

  function calendarDisplay () {
    var monthName = ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'];
    var shortMontName = ['Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн', 'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'];
    var currentMonth = new Date().getMonth();
    var currentYear = new Date().getFullYear();
    var currentDate = monthName[currentMonth] + ' ' + currentYear;

    jQuery('.form-calendar').monthpicker({
      monthNames: monthName,
      monthNamesShort: shortMontName,
      showOn: 'both',
      buttonImageOnly: true,
      buttonText: '',
      changeYear: false,
      yearRange: 'c-2:c+2',
      maxDate: '0 M',
      dateFormat: 'MM yy',
      UseInputMask: true
    }).val(currentDate);
  }

  function activeContentBalance (existExpenses, existIncome, event) {
    event.preventDefault();
    var tabsBalance = document.querySelectorAll('.menu-tabs_balance .menu-tabs__nav-item');
    var contentBalance = document.querySelectorAll('.balance__content-tab');

    for (var j = 0; j < tabsBalance.length; j++) {
      tabsBalance[j].classList.remove('active');
    }
    for (var c = 0; c < contentBalance.length; c++) {
      contentBalance[c].classList.remove('active');
    }
    event.target.parentNode.classList.add('active');
    var linkTabs = event.target.getAttribute('data-target');
    if (!linkTabs) linkTabs = 'balance-credit'
    var content = document.getElementById(linkTabs);
    content.classList.add('active');

    var emptyBlock = content.querySelectorAll('.balance__empty');
    var notEmptyBlock = content.querySelectorAll('.balance__not-empty');
    if (linkTabs ==='balance-credit') {
      if (!existExpenses) {
        emptyBlock[0].style.display = "block";
        notEmptyBlock[0].style.display = 'none';
      } else {
        emptyBlock[0].style.display = "none";
        notEmptyBlock[0].style.display = 'block';
      }
    } else if (!existIncome) {
      emptyBlock[0].style.display = 'block';
      notEmptyBlock[0].style.display = 'none';
    } else {
      emptyBlock[0].style.display = "none";
      notEmptyBlock[0].style.display = 'block';
    }
  }

  function showData (category, arr) {
    category.querySelector('.balance__month').classList.add('active');
    category.querySelector('.balance__empty').classList.remove('active');
    var arrSort = arr.slice();
    arrSort = arrSort.sort(function (a, b) {
      return absRoundNum(a.sum) < absRoundNum(b.sum);
    });
    var totalValue = category.querySelector('.char-total__value');
    var value = getTotalValue(arrSort);
    var balanceCategory = category.querySelector('.balance__category');
    var list = category.querySelector('.balance__category-list');
    var char = category.querySelector('.balance__char-canvas');

    if (list) {
      balanceCategory.removeChild(list);
    }

    value = formatDisplayNumber(value);
    /* add Nodes in CategoryList in balanceContent */
    if (category.id === 'balance-credit') {
      totalValue.innerHTML = '&ndash; ' + value;
      balanceCategory.appendChild(createListBalance(arrSort, category));
    } else {
      totalValue.innerHTML = value;
      balanceCategory.appendChild(createListBalance(arrSort));
    }
    totalValue.classList.add('rouble');

    /* display Char on Page */
    createChar(
      char,
      balanceCategory,
      arrSort
    );

    /* Open Modal window from List Category of Balance */
    var itemOpenModal = category.querySelectorAll('.balance__category-item');
    for (var i = 0; i < itemOpenModal.length; i++) {
      itemOpenModal[i].addEventListener('click', function (event) {
        var balanceId = event.currentTarget.getAttribute('data-id');
        var balanceModal = event.currentTarget.getAttribute('data-form');
        var categoryForModal = arr.find(function (item) {
          return item.id === balanceId;
        });
        if (categoryForModal !== undefined) {
          modalBalanceContent(category, categoryForModal);
          window.openModal(balanceModal);
        }
      });
    }
  }

  function showEmpty (category) {
    category.querySelector('.balance__empty').classList.add('active');
    category.querySelector('.balance__month').classList.remove('active');

    var monthEmptyData = category.querySelector('.js-currentMonth');
    var calendar = category.querySelector('.form-calendar');
    monthEmptyData.textContent = calendar.value;

    /* Show Data of last Month */
    var callDataLastMonth = category.querySelector('.js-lastMonth');
    callDataLastMonth.onclick = function () {
      var monthName = ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'];
      var currentMonth = calendar.value.slice(0, -5);
      var currentYear = calendar.value.slice(-4);
      var lastDate;
      for (var i = 0; i <= monthName.length; i++) {
        if (monthName[i] === currentMonth) {
          if (i - 1 >= 0) {
            lastDate = monthName[i - 1] + ' ' + currentYear;
            calendar.value = lastDate;
            return calendar.value;
          } else {
            lastDate = monthName[11] + ' ' + (currentYear - 1);
            calendar.value = lastDate;
            return calendar.value;
          }
        }
      }
    };
  }

  /* Format Abs Round Number */
  function absRoundNum (num) {
    var absNum = Math.round(Math.abs(+num) * 100) / 100;
    return absNum;
  }

  /* Format Display Number */
  function formatDisplayNumber (num) {
    var viewNum = String(Math.round(num * 100) / 100).replace(/\B(?=(\d{3})+(?!\d))/g, ' ').replace('.', ', ');
    return viewNum;
  }

  /* Get totalValue */
  function getTotalValue (arr) {
    var value = +arr.reduce(function (sum, current) {
      current = Math.round(Math.abs(+current.sum * 100) / 100);
      return sum + current;
    }, 0);
    return value;
  }

  /* Create Balance List */
  function createListBalance (arr, category) {
    var blockList = document.createElement('div');
    blockList.classList.add('balance__category-list');
    for (var i = 0; i < arr.length; i++) {
      var value = (category) ? String('&ndash; ' + formatDisplayNumber(arr[i].sum)) : formatDisplayNumber(arr[i].sum);
      if (arr[i].fillIcon) {
        arr[i].iconList = window.location.origin + '/uploads/icons/' + arr[i].fillIcon;
      } else {
        arr[i].iconList = window.location.origin + '/uploads/icons/default-fill.svg';
      }
      var item = createNodeItem(arr[i].id, arr[i].iconList, arr[i].name, value);
      blockList.appendChild(item);
    }
    return blockList;
  }

  /* Create Item in Balance List */
  function createNodeItem (dataId, srcImg, textName, textValue) {
    var link = document.createElement('a');
    var img = document.createElement('img');
    var name = document.createElement('p');
    var value = document.createElement('p');

    link.classList.add('balance__category-item');
    link.setAttribute('data-id', dataId);
    link.setAttribute('data-form', 'modal-balance');
    link.appendChild(img);
    img.classList.add('icon-balance');
    img.src = srcImg;
    link.appendChild(name);
    name.classList.add('balance__category-name');
    name.textContent = textName;
    link.appendChild(value);
    value.classList.add('balance__category-value');
    value.innerHTML = textValue;
    return link;
  }

  /* Create char of BalanceList */
  function createChar (char, list, arr) {
    var balanceCategoryList = list.querySelectorAll('.balance__category-item');
    var ctx = char.getContext('2d');
    var totalValue = getTotalValue(arr);
    var basicColor = [27, 194, 129];
    var charSize;
    char.width = char.height = charSize = 360;
    var centerChar = char.width / 2;
    var widthStroke = 50;
    var selectWidthStroke = widthStroke + 10;
    var offset = charSize / 6 - 10;
    var colorBg = 'rgb(0,0,0)';
    var colorCanvasActive = colorBg;
    var colorLabel = 'rgb(254, 254, 254)';
    ctx.fillStyle = colorLabel;
    ctx.font = '600 11px Raleway';

    /* Add new key in Array */
    var startAngle = -Math.PI / 2;
    var colorRGB = basicColor.slice();
    for (var i = 0; i < arr.length; i++) {
      var sliceAngle = 2 * Math.PI * absRoundNum(arr[i].sum) / totalValue;
      /* currentRadius */
      var colorPalatte = 'rgb(' + colorRGB[0] + ',' + colorRGB[1] + ',' + colorRGB[2] + ')';
      colorRGB[0] = (colorRGB[0] >= 3) ? colorRGB[0] - 3 : 0;
      colorRGB[1] = (colorRGB[1] >= 11) ? colorRGB[1] - 11 : 0;
      arr[i].startAngle = startAngle;
      arr[i].sliceAngle = startAngle + sliceAngle;
      arr[i].colorIndex = colorPalatte;
      arr[i].percent = Math.round(100 * absRoundNum(arr[i].sum) / totalValue);
      /* current Percent */
      arr[i].labelX = centerChar - 7 + (offset + centerChar / 2) * Math.cos(startAngle + sliceAngle / 2);
      arr[i].labelY = centerChar + (offset + centerChar / 2) * Math.sin(startAngle + sliceAngle / 2);
      var srcIcon = arr[i].icon;
      arr[i].icon = new window.Image();
      arr[i].icon.src = srcIcon;
      startAngle += sliceAngle;
    }

    /* Draw Sectors of Char */
    function _drawSlice (item, startAngle, sliceAngle, strokeWidth) {
      ctx.restore();
      ctx.beginPath();
      ctx.strokeStyle = item.colorIndex;
      ctx.lineWidth = strokeWidth;
      ctx.arc(centerChar, centerChar, centerChar - 40, startAngle, sliceAngle, false);
      ctx.stroke();
      if (item.percent >= 5) {
        item.icon.addEventListener('load', function (event) {
          event.preventDefault();
          ctx.drawImage(item.icon, item.labelX, item.labelY - 18, 17, 20);
        });
        ctx.fillText(item.percent + '%', item.labelX, item.labelY + 14);
        ctx.drawImage(item.icon, item.labelX, item.labelY - 18, 17, 20);
      }

      ctx.shadowColor = 'rgba(0,0,0,0)';
      ctx.closePath();
    }

    /* Rewrite Circle Char */
    function _rewriteChar (itemSelect) {
      ctx.clearRect(0, 0, charSize, charSize);
      for (var i = 0; i < arr.length; i++) {
        _drawSlice(arr[i], arr[i].startAngle, arr[i].sliceAngle, widthStroke);
      }
      if (itemSelect) {
        _drawSlice(
          itemSelect,
          itemSelect.startAngle,
          itemSelect.sliceAngle,
          selectWidthStroke,
          ctx.shadowColor = 'rgba(0,0,0,0.2)',
          ctx.shadowBlur = 20
        );
      }
    }

    /* Find sector on Char which hover in CategoryList */
    for (var k = 0; k < balanceCategoryList.length; k++) {
      var item = balanceCategoryList[k];
      item.addEventListener('mouseenter', _hoverItemInList);
      item.addEventListener('mouseleave', _rewriteChar);
    }

    /* Get color when mousemove on Char */
    char.addEventListener('mousemove', _charMouseMove);
    char.addEventListener('mouseleave', _charMouseLeave);

    function _hoverItemInList (event) {
      var idCategory = this.getAttribute('data-id');
      event.preventDefault();
      for (var i = 0; i < arr.length; i++) {
        if (arr[i].id === idCategory) {
          _rewriteChar(arr[i]);
        }
      }
    }

    function _charMouseMove (event) {
      event.preventDefault();
      var charX = event.offsetX;
      var charY = event.offsetY;
      var pixelColorChar = ctx.getImageData(charX, charY, 1, 1).data;
      var colorCanvasChar = 'rgb(' + pixelColorChar[0] + ',' + pixelColorChar[1] + ',' + pixelColorChar[2] + ')';
      if (colorCanvasChar !== colorCanvasActive) {
        colorCanvasActive = colorCanvasChar;
        for (var i = 0; i < arr.length; i++) {
          if (arr[i].colorIndex === colorCanvasChar) {
            _rewriteChar(arr[i]);
            for (var j = 0; j < balanceCategoryList.length; j++) {
              var categoryId = balanceCategoryList[j].getAttribute('data-id');
              balanceCategoryList[j].classList.remove('js-hover');
              if (categoryId === arr[i].id) {
                balanceCategoryList[j].classList.add('js-hover');
              }
            }
          } else if (colorCanvasChar !== colorCanvasActive || colorCanvasChar === colorBg) {
            colorCanvasActive = colorCanvasChar;
            for (var k = 0; k < balanceCategoryList.length; k++) {
              balanceCategoryList[k].classList.remove('js-hover')
            }
            _rewriteChar();
          }
        }
      }
    }

    function _charMouseLeave (event) {
      event.preventDefault();
      colorCanvasActive = colorBg;
      _rewriteChar();
    }

    _rewriteChar();
  }

  /* Fill of Modal balance of select data from Categories */
  function modalBalanceContent (category, item) {
    var modalBalance = document.querySelector('.modal-balance');
    var modalTitle = modalBalance.querySelector('.modal__title');
    var modalState = modalBalance.querySelector('.modal-balance__state');
    var modalStateBtn = '<button class="btn modal-balance__btn_questions" data-form="modal-questions"></button>';
    var modalContent = modalBalance.querySelector('.js-modalBalanceContent');
    if (category instanceof window.Event) {
      modalTitle.textContent = '';
      modalState.textContent = '';
      modalContent.textContent = '';
    } else {
      var statusCategory = (category.id === 'balance-credit') ? 'Расходы за ' : 'Поступления за ';
      modalTitle.textContent = item.name;
      var currentMonth = category.querySelector('.form-calendar').value.slice(0, -5);
      var valueTotalBalance = (category.id === 'balance-credit') ? '&ndash; ' + formatDisplayNumber(item.sum) : formatDisplayNumber(item.sum);
      modalState.innerHTML = '<p class="modal-balance__state-text">' + statusCategory + currentMonth.toLowerCase() + ': ' + '<span class="rouble">' + valueTotalBalance + '</span></p>' + modalStateBtn;
      var arr = [];
      for (var key in item.transactions) {
        arr.push(item.transactions[key]);
      }
      for (var i = 0; i < arr.length; i++) {
        modalContent.appendChild(modalBalanceNodeOfList(category, key, arr[i]));
      }
    }
    var buttonCallQuestionsModal = document.querySelector('.modal-balance__btn_questions');
    if (buttonCallQuestionsModal !== null) {
      buttonCallQuestionsModal.addEventListener('click', openModalQuestion);
    }
  }

  /* Create Node of List Transaction */
  function modalBalanceNodeOfList (category, dateText, arr) {
    var contentModal = document.createElement('div');
    contentModal.classList.add('modal-balance__transaction');
    var dateTransaction = document.createElement('date');
    dateTransaction.classList.add('transaction__date');
    contentModal.appendChild(dateTransaction);
    dateTransaction.textContent = dateText;
    var listTransaction = document.createElement('ul');
    listTransaction.classList.add('transaction__list');
    contentModal.appendChild(listTransaction);
    for (var i = 0; i < arr.length; i++) {
      var itemTransaction = document.createElement('li');
      itemTransaction.classList.add('transaction__item');
      listTransaction.appendChild(itemTransaction);
      var nameAgent = document.createElement('h4');
      nameAgent.classList.add('transaction__agent');
      itemTransaction.appendChild(nameAgent);
      nameAgent.textContent = arr[i].relatedName;
      var taskTransaction = document.createElement('p');
      taskTransaction.classList.add('transaction__task');
      taskTransaction.textContent = arr[i].purpose;
      itemTransaction.appendChild(taskTransaction);
      var valueTransaction = document.createElement('p');
      valueTransaction.classList.add('transaction__value');
      var totalValueTransaction = (category.id === 'balance-credit') ? '&ndash; ' + formatDisplayNumber(arr[i].sum) : formatDisplayNumber(arr[i].sum);
      valueTransaction.innerHTML = '<span class="rouble">' + totalValueTransaction + '</span>';
      itemTransaction.appendChild(valueTransaction);
    }
    return contentModal;
  }

  /* Send transactionId in modal window of Question */
  function openModalQuestion (event) {
    event.preventDefault();
    window.openModal('modal-questions');
  }
})();