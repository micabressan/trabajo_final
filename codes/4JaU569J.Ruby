require 'fileutils'
require 'yaml'
require 'open-uri'

class RubyDownloader
	PATH = File.dirname(__FILE__)
	DOWNLOAD_URL = "http://launcher.sashok724.net/download"
	LIBRARIES_DIR = PATH + '/libraries' 
	HIRAKI_DIR = LIBRARIES_DIR + '/hikaricp'
	UPDATES_DIR = PATH + '/updates'

	def initialize
		# Запрашиваем весрию обновления
		puts "Введите новую версию лаунчера:"
		$JRE = gets.gsub(/\n/,'')
		
		puts "Введёная версия: #{$JRE}. Проверяю наличие папок..."
		
		begin
			# Запуск создания нужных папок
			unless File.directory? LIBRARIES_DIR
				FileUtils.mkdir_p(LIBRARIES_DIR)
			end
		
			unless File.directory? HIRAKI_DIR
				FileUtils.mkdir_p(HIRAKI_DIR)
			end
		
			unless File.directory? UPDATES_DIR
				FileUtils.mkdir_p(UPDATES_DIR)
			end
		rescue => err
			on_error(err)
		end
		
		puts "Готово! Поехали?"
	end
	
	def run
		launchserver
		first_stack
		hikaricp
		launch4
		jvm
		
		# Завершение работы
		puts "Всё готово! Не забудьте распаковать файлы launch4j.tar.gz (launch4j-osx.tar.gz для OS) и jre.tar.gz!"
		quit
	end
	
	def launchserver
		begin
			puts "Загружаю LaunchServer.jar..."
			open(PATH + '/LaunchServer.jar', 'wb') do |file|
				file << open(DOWNLOAD_URL + '/LaunchServer.jar').read
			end
			puts "Готово!"
		rescue => err
			on_error(err)
		end
	end
	
	def first_stack
		array_to_load = [
			'jansi.jar', 
			'jline2.jar',
			'mysql.jar'
		]
		array_to_load.each do |jar|
			begin
				unless File.exists?(LIBRARIES_DIR + '/' + jar)
					puts "Загружаю #{jar}"
					open(LIBRARIES_DIR + '/' + jar, 'wb') do |file|
						file << open(DOWNLOAD_URL + '/libraries/' + jar).read
					end
					puts "Готово!"
				end
			rescue => err
				on_error(err)
				next
			end
		end
	end
	
	def hikaricp
		array_hikaricp = [
			'javassist.jar',
			'slf4j-api.jar',
			'slf4j-simple.jar',
			'hikaricp.jar'
		]
		begin
			if !File.exists?(HIRAKI_DIR + '/hikaricp.jar') then
				array_hikaricp.each do |jar|
					puts "Загружаю #{jar}"
					open(HIRAKI_DIR + '/' + jar, 'wb') do |file|
						file << open(DOWNLOAD_URL + '/libraries/hikaricp/' + jar).read
					end
					puts "Готово!"
				end
			end
		rescue => err
			on_error(err)
		end
	end
	
	def launch4
		array_launch = [
			'launch4j-osx.tar.gz',
			'launch4j.tar.gz'
		]
		array_launch.each do |jar|
			begin
				puts "Загружаю #{jar}"
				open(LIBRARIES_DIR + '/' + jar, 'wb') do |file|
					file << open(DOWNLOAD_URL + '/libraries/' + jar).read
				end
				puts "Готово!"
			rescue => err
				on_error(err)
				next
			end
		end
	end
	
	def jvm
		begin
			puts "Загружаю JVM. Это займёт много времени!"
			open(UPDATES_DIR + '/jre.tar.gz', 'wb') do |file|
				file << open(DOWNLOAD_URL + '/jre-' + $JRE + '.tar.gz').read
			end
			puts "Готово!"
		rescue => err
			on_error(err)
		end
	end
	
	def quit
		puts "Press enter to exit!"
		gets exit
	end
	
	def on_error(err)
		puts "Уупс. Что-то пошло не так. Ошибка:\n#{err}"
		quit
	end
end

run_this = RubyDownloader.new
run_this.run