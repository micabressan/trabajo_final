.row.issue-body
  .col-md-6
    h3 Изменения в заявке
    - if @versions.any?
      table.table.table-stripped.table-hover
        thead
        tbody
          tr
            td Дата
            td= t('activerecord.attributes.issue.state')
            td Пользователь
        = @versions.map do |version| 
          tr
            td= version.created_at.strftime("%d/%m/%Y %H:%M")
            td= t(version.changeset["state"].last, scope: Issue::STATE_SCOPE)
            td= User.find_by_id(version.whodunnit).try(:full_name)
    - else
      table.table.table-stripped.table-hover
        thead
        tbody
          tr
            td Дата
            td= t('activerecord.attributes.issue.state')
            td Пользователь
          tr
            td= @issue.created_at.strftime("%d/%m/%Y %H:%M")
            td= t(@issue.state, scope: Issue::STATE_SCOPE)
            td= @issue.dispatcher.try(:full_name)