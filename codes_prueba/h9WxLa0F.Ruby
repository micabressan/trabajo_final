 <div class="row">
    <div class="col-sm-6">
      <div class="form-group">
        <%= f.label :status, 'Status', class: 'required' %><br>
        <%= f.select :status_ids, Status.all.collect {|x| [x.name, x.id]}, { prompt: true },  multiple: true,
                     class: 'form-control', id: 'status-selector' %>
      </div>
    </div>
  </div>