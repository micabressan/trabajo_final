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