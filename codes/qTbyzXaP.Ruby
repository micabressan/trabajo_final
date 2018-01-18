<ul>
  <% [linkedin twitter facebook].each do |platform| %>
    <% if contact.public_send(platform).present? %>
      <li>
        <%= contact.public_send platform %>
      </li>
    <% end%>
  <% end %>
</ul>