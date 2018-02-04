<ul>
  <% [linkedin twitter facebook].each do |platform| %>
    <li>
      <%= contact.public_send platform %>
    </li>
  <% end %>
</ul>