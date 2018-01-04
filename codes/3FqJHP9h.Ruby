require 'sinatra'
require 'json'


TEST_SECRET_KEY = "railssuks"



def get_cities_names()
	Dir.entries('./SCHEDULES').select { |f| f != '.' && f != '..'}
end


def get_schedule_names_of_city(city_name)
	filenames = Dir.entries('./SCHEDULES/' + city_name).select { |f| f != '.' && f != '..'}

	filenames.map { |filename| File.basename(filename, File.extname(filename)) }
end

def get_schedules_metadata()
	city_folders = get_cities_names()
	cities = []
	city_folders.each do | city_name |
		schedules_names = get_schedule_names_of_city(city_name)
		if schedules_names.length != 0
			most_recent = schedules_names.map{ |e| e.to_i }.max
			city_hash = {:cityName => city_name,
						 :mostRecent => most_recent.to_s,
						 :schedules => schedules_names}
			cities.push(city_hash)
		end
	end
	cities.to_json
end

def get_json_string(city, schedule_version)
	json = File.read("./SCHEDULES/#{city}/#{schedule_version}.json")
	json
end


class MainService < Sinatra::Base

	set :bind, '0.0.0.0'
	set :port, '40000'
	set :environment, :production

	get '/' do
		get_schedules_metadata()
	end

	get '/:city/:schedule_version' do
		city = params['city']
		schedule_version  = params['schedule_version']

		cities = get_cities_names()
		if not cities.include? city
			error_json = {}
			error_json[:message] = 'wrong city'
			error_json[:city] = city
			return error_json.to_json
		end
		schedules = get_schedule_names_of_city(city)
	
		if not schedules.include? schedule_version
			error_json = {}
			error_json[:message] = 'wrong schedule version'
			error_json[:scheduleVersion] = schedule_version
			return error_json.to_json
		end
	
		get_json_string(city, schedule_version)
	end

	
end