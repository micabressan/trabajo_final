{% extends "layouts/inner.njk" %}

{% set page = "building-page_balance" %}
{% block content %}
  <main class="page-inside building-page">
    {% include "common/banner.njk" %}
    {% include "common/menu-tabs.njk" %}
    <section class="building-page__balance container">
      <section class="balance">
        <header class="balance__header">
          {% if building.balance %}
            <div class="balance__info">
              <span class="balance__info-details">Баланс дома</span>
              <p class="balance__info-value rouble">{{ building.balance | costFormat }}</p>
              <time class="balance__info-date">Обновленно {{ building.updated_at | datetimeformat('DD.MM.YYYY') }}</time>
            </div>
          {% endif %}
          <nav class="menu-tabs_balance">
            <ul class="menu-tabs__nav">
              <li class="menu-tabs__nav-item active js-first-tab">
                <a href="#balance-credit" data-target="balance-credit">Расходы</a>
              </li>
              <li class="menu-tabs__nav-item">
                <a href="#balance-debit" data-target="balance-debit">Поступления</a>
              </li>
            </ul>
          </nav>
        </header>
        <div class="balance__content">
          <div class="balance__content-tab active balance__content-credit" id="balance-credit">
            <div class="balance__not-empty">
              <h2 class="visually-hidden">Расходы</h2>
              {% include "block/balance__calendar.njk" %}
              <div class="balance__month">
                <div class="balance-row">
                  <div class="balance__category balance-column">
                    <div class="balance__category-caption">
                      <p>Категория расходов</p>
                      <p class="rouble">Сумма,</p>
                    </div>
                  </div>
                  <div class="balance__char balance-column">
                    <div class="balance__char-total">
                      <span class="char-total__overvalue">Всего расходов</span>
                      <p class="char-total__value"></p>
                    </div>
                    <canvas class="balance__char-canvas"></canvas>
                  </div>
                </div>
              </div>
            </div>
            <div class="balance__empty">
              <div class="balance-row">
                <div class="balance-column balance__empty-img"></div>
                <div class="balance-column balance__empty-info">
                  <h3 class="balance__empty-title">Пока мы не получили информацию о расходах
                    за <span class="js-currentMonth"></span></h3>
                  <p class="balance__empty-details">Данные расходов обычно появляются
                    со 2 числа месяца</p>
                  <button href="#" class="btn btn-action btn_md js-lastMonth">Расходы за прошлый месяц</button>
                </div>
              </div>
            </div>
          </div>
          <div class="balance__content-tab balance__content-debit" id="balance-debit">
            <div class="balance__not-empty">
              <h2 class="visually-hidden">Доходы</h2>
              {% include "block/balance__calendar.njk" %}
              <div class="balance__month">
                <div class="balance-row">
                  <div class="balance__category balance-column">
                    <div class="balance__category-caption">
                      <p>Категория доходов</p>
                      <p class="rouble">Сумма, </p>
                    </div>
                  </div>
                  <div class="balance__char balance-column">
                    <div class="balance__char-total">
                      <span class="char-total__overvalue">Всего доходов</span>
                      <p class="char-total__value"></p>
                    </div>
                    <canvas class="balance__char-canvas"></canvas>
                  </div>
                </div>
              </div>
            </div>
            <div class="balance__empty">
              <div class="balance-row">
                <div class="balance-column balance__empty-img"></div>
                <div class="balance-column balance__empty-info">
                  <h3 class="balance__empty-title">Пока мы не получили информацию о доходах
                    за <span class="js-currentMonth"></span></h3>
                  <p class="balance__empty-details">Данные доходов обычно появляются
                    со 2 числа месяца</p>
                  <button href="#" class="btn btn-action btn_md js-lastMonth">Доходы за прошлый месяц</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </section>
  </main>
{% endblock %}

{% block modals %}
  {% include "modals/modal-balance.njk" %}
  {% include "modals/modal-questions.njk" %}
  {% include "modals/modal-questions-success.njk" %}
  {% include 'modals/modal-idea-for-home.njk' %}
{% endblock %}

{% block scripts %}
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/jquery-ui-monthpicker@1.0.3/jquery.ui.monthpicker.js"></script>
  <script src="/assets/js/building-page_balance.js"></script>
{% endblock %}