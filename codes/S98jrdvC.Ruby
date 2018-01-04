2.3.1 :033 > container = Docker::Container.all.first
 => #<Docker::Container:0x00000002bc8700 @id="7861460bdf26452c57cde46bf88f63289230ae95a8e3bc4d54a23df824b83823", @info={"Names"=>["/elated_swartz"], "Image"=>"scratch-test", "ImageID"=>"sha256:16dd39f7b1757eb8b7c77685f48ff6b589e6b16204627de780edd3151ae9d337", "Command"=>"/bash", "Created"=>1515003833, "Ports"=>[], "Labels"=>{}, "State"=>"running", "Status"=>"Up 24 minutes", "HostConfig"=>{"NetworkMode"=>"default"}, "NetworkSettings"=>{"Networks"=>{"bridge"=>{"IPAMConfig"=>nil, "Links"=>nil, "Aliases"=>nil, "NetworkID"=>"edd459592d2784e0e0c5650e8112b94c6b14d614c9b34ffff12e69e6b1e9a247", "EndpointID"=>"91c753c03334c0182e7a3efce3cc3a75973d531b5c6bf99b811c47cff978d229", "Gateway"=>"172.17.0.1", "IPAddress"=>"172.17.0.3", "IPPrefixLen"=>16, "IPv6Gateway"=>"", "GlobalIPv6Address"=>"", "GlobalIPv6PrefixLen"=>0, "MacAddress"=>"02:42:ac:11:00:03"}}}, "Mounts"=>[], "id"=>"7861460bdf26452c57cde46bf88f63289230ae95a8e3bc4d54a23df824b83823"}, @connection=#<Docker::Connection:0x00000002ca72e8 @url="unix:///", @options={:socket=>"/var/run/docker.sock"}>> 
2.3.1 :034 > labels = (container.info['Config']['Labels'] || {})
NoMethodError: undefined method `[]' for nil:NilClass
	from (irb):34
	from /home/denz/.rvm/rubies/ruby-2.3.1/bin/irb:11:in `<main>'
2.3.1 :035 > labels = (container.info['Labels'] || {})
 => {} 
2.3.1 :036 >