{# {% set reguestList = [{status: 'process', date: '30 СЕН, 23:15', detailsPlace: '2этаж', detailsInfo:'1 подъезд', text:'Устранение общедомового засора
          канализации', tags:['Вода', 'Канализация']},
{status: 'complete', date: '30 СЕН, 23:15', detailsPlace: '2этаж', detailsInfo:'1 подъезд', text:'Смазать качель во дворе', tags: ['Электричество', 'Водосток']}] %} #}

<ul class="request__list">
  {% for request in building.requests  -%}
    {% if request.status < 2 %}
      <li class="request__item request__item_process">
    {% else %}
      <li class="request__item request__item_complete">
    {% endif %}
    <a href="#" class="request__item-link" data-id={{ loop.index}}>
      <div class="request__item-info">
        <div class="request__item-details">
          {% if request.status < 2 %}
          <span>в работе</span>
          {% else %}
            <span>Выполнена</span>
          {% endif %}
          <span>{{ request.created_at | datetimeformat('DD MMM, YYYY') | upper }}</span>
        </div>
        {% if page == 'building-page_requests' %}
        <div class="request__item-details">
          <span>{{ request.floor.fullTitle }}</span>
          <span>{{ (request.section.number ~ ' подъезд') if request.floor.number }}</span>
        </div>
        {% endif %}
      </div>
      <p class="request__item-text">{{ request.text }}</p>
      <div class="request__tags">
        {% for tag in request.tags %}
        <span class="request__tags-link">{{ tag }}</span>
        {% endfor %}
      </div>
    </a>
    </li>
  {%- endfor  %}
</ul>