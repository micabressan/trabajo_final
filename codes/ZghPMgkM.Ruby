#!/usr/bin/env ruby

require 'rubygems'
require 'cloudservers'
require 'mysql'

cs = CloudServers::Connection.new(:username => '-username-', :api_key => '-apikey-')

puts "Connection Established"

image = cs.get_image(13941355)
flavor = cs.get_flavor(1)
newserver = cs.create_server(:name => 'arandomtest', :imageId => image.id, :flavorId => flavor.id)

puts "Server Build Started"

until newserver.status == "ACTIVE" do
	newserver.refresh
	puts newserver.status
	puts newserver.progress
	sleep 10
end

#Gather Stuff for SQL



privaddress = newserver.addresses[:private][0].to_s
game = ARGV[0]


sql = Mysql::new("127.0.0.1", "root", "-password-", "gamesvr")
sql.query("INSERT INTO server_management VALUES(NULL,'#{game}','#{privaddress}',1)")