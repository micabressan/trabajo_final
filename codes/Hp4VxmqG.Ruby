#!/usr/bin/env ruby

#Load Stuff and Set Variables from ARGV
require 'rubygems'
require 'cloudservers'
require 'net/ssh'
require 'mysql'
game=ARGV[0]
slots=ARGV[1]
username=ARGV[2]


#Connect to Database
sql = Mysql::new("127.0.0.1", "root", "SQLPASS", "gamesvr")

puts "Executing Query..."
#Find the ImageID
res = sql.query("Select ID from images WHERE name = '#{game}';")


puts "Checking if Image Exists..."
if res.num_rows == 0
	raise RuntimeError, 'Image Not Found, Aborting Build'
end

#Create connection to API/Authenticate
puts "Creating Connection to API..."
cs = CloudServers::Connection.new(:username => 'APIUSER', :api_key => 'APIKEY')

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

#Some Temporary Variables that will go away soon.
uid=25


#Update Database
sql.query("INSERT INTO servers VALUES(NULL,'#{game}',#{slots},'#{newserver.addresses[:public][0].to_s}','#{newserver.addresses[:private][0].to_s}',#{newserver.id},'#{username}',#{uid},1,NOW(),NOW(),NULL)")