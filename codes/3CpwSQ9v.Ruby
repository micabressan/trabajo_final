


<div class="container">

  <div class="row">
    <h2 class="text-center new-pint-btn"><%= link_to 'New Pin', new_pin_path %></h3>
      <hr>
  </div>

  <div class="row">
    <div clas="col-md-2">

    </div>

    <div class="col-md-10 ">
      <div>
        <% @pins.each do |pin| %>
          <hr>

          <p class="text-center">
            <%= pin.name %><br>
            <%= pin.text %><br>
            <%= image_tag pin.avatar_url , class: ["img-thumbnail zdj"]%><br>

            <%= link_to 'Delete', pin, method: :delete %>
          </p>

          <hr style="color:blue;">
        <% end   %>
    </div>

    <div clas="col-md-2">

    </div>
  </div>
</div>