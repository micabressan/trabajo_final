begin

map '/app1' do 
  run App1
end

map '/app2' do
  run App2
end

rescue ActiveRecord::StatementInvalid
  logger.error "Lost connection to MySQL. Reconnecting"
  ActiveRecord::Base.verify_active_connections!
end