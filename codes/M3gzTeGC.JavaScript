<div class="modal-request modal-window" id="modal-request">
  <div class="modal-container">
    <button class="btn-close modal-button-close">&#10005;</button>
    <div class="modal-request__header">
    <p class="header__request-status">в работе | 5 сен, 12:10</p>
      <h4 class="modal-request__title h4">
        {% set comma = joiner(', ') %}
        {{ (comma() ~ building.data.street_type ~ ' ' ~ building.data.street) if building.data.street -}}
        {{- (comma() ~ building.data.house_type ~ ' ' ~ building.data.house) if building.data.house -}}
        {{- (comma() ~ building.data.block_type ~ ' ' ~ building.data.block) if building.data.block }}
        <br>
        <span class="modal-request__full-title"></span><span class="modal-request__section-number"></span>
      </h4>
      {#<h4 class="modal-request__title h4">Юмашева, 12<br> 10 этаж, 1 подъезд</h4>#}
      {#<div class="modal-request__tags">#}
        {#<span class="request__tags-link">Вода</span>#}
        {#<span class="request__tags-link">Канализация</span>#}
      {#</div>#}
    </div>
    <div class="modal-request__content">
      <span class="modal-request__cause">Причина заявки</span>
      <p class="modal-request__text"></p>
      {#<div class="request__item_executor request__item_complete">#}
        {#<div class="request__item_executor-ava">#}
          {#<img src="/static/images_/testimonials1.jpg" alt="ava">#}
        {#</div>#}
        {#<div class="request__item_executor-person">#}
          {#<span class="executor-person__status">Исполнитель</span>#}
          {#<span class="executor-person__name">Федосеев Михаил</span>#}
          {#<span class="executor-person__tel">+7 (912) 845-84-95</span>#}
        {#</div>#}
        {#<div class="request__item_executor-info request__item-info">#}
          {#<div class="request__item-details">#}
            {#<span>Выполненно</span>#}
            {#<span>30 СЕН, 23:15</span>#}
          {#</div>#}
        {#</div>#}
      {#</div>#}
    </div>
  </div>
</div>