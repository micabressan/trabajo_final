#!/usr/bin/env ruby

require 'rubygems'
require 'cloudservers'
require 'net/ssh'
require 'mysql'


#Connect to Database
sql = Mysql::new("127.0.0.1", "root", "sqlpassword", "gamesvr")

puts "Executing Query..."
#Find the ImageID
res = sql.query("Select ID from images WHERE name = '#{ARGV[0]}';")


puts "Checking if Image Exists..."
if res.num_rows == 0
	raise RuntimeError, 'Image Not Found, Aborting Build'
end

#Create connection to API/Authenticate
puts "Creating Connection to API..."
cs = CloudServers::Connection.new(:username => 'username', :api_key => 'apikey')

#This Block Retries the build 4 times, after failing 4 times it exits the script with a RuntimeError and prints the failure as reported from the API.
puts "Starting Build..."
buildattempt=0
begin
	if buildattempt < 4 then
		flavor = cs.get_flavor(1)
		newserver = cs.create_server(:name => 'arandomtest', :imageId => cs.get_image(res.fetch_row[0]).id , :flavorId => flavor.id)
	end
rescue Exception => msg
	buildattempt += 1
	if buildattempt < 4
		puts "Build Failed with error #{msg.to_s}"
		puts "Retrying Build..."
		retry
	else
		raise RuntimeError, "Could Not Build Server after 4 attempts. Error: #{msg.to_s}"
	end
end



puts "Server Build Started."

until newserver.status == "ACTIVE" do
	newserver.refresh
	puts "Status: #{newserver.status} - #{newserver.progress}%"
	sleep 10 
end

#Update Database
sql.query("INSERT INTO server_management VALUES(NULL,'#{ARGV[0]}','#{newserver.addresses[:private][0].to_s}',1,#{newserver.id})")