# somewhere in a view:
<%= render 'social_link', locals: { link: contact.twitter } %>
<%= render 'social_link', locals: { link: contact.facebook } %>
<%= render 'social_link', locals: { link: contact.linkedin } %>

# _social_link.html.erb partial:
<% if link.present? %>
  <div>
  	<%= link %>
  </div>
<% end %>