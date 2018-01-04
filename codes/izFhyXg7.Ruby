require "cgi"
require "cinch"
require "nokogiri"
require "open-uri"
require "wolfram"

if not defined?(Ocra)
    Wolfram.appid    = "APP_ID"
    ADMIN            = "ADMIN_NAME"
    TESTING          = false
    USE_MY_NICK      = false
    if USE_MY_NICK == true
        PORT             = 5000
        BOT_NICK         = ADMIN
        BOT_REALNAME     = ADMIN
        SERVER_NAME      = "SERWER"
    elsif USE_MY_NICK == false
        PORT             = 6667
        BOT_NICK         = "nrq"
        BOT_REALNAME     = BOT_NICK
        SERVER_NAME      = "irc.pirc.pl"
    end
    BOT_USER         = BOT_REALNAME
    PASSWORD         = "PASS"
    HOP_REGEX        = /^!hop (.+)/i
    LENNYFACE        = "( ͡° ͜ʖ ͡°)"
	RAT_REGEX		 = /\b[ImgInfo]?\b/i
    SAY_REGEX        = /\Asay (?<msg>.*)\z/i
	BASH_REGEX		 = /^!bash/i
	RAT_REGEX_2		 = /\b[YouTube]?\b/i
	LENNY_REGEX      = /\blenny(face)?\b/i
    LUNUX_REGEX      = /\l(n|unu)x( pls| plz)?\b/i
    NIGGA_REGEX      = /\bn(i|y)(g|gg)a?\b/i
	WYKOP_REGEX      = /^*wykop(.+)/i
    GOOGLE_REGEX     = /^!g (.+)/i
    WOLFRAM_REGEX    = /\A% (?<query>.*)\z/i
    DELETE_ACCOUNT   = /\busu[nń]\s+k(?:on|ą)to\b/
    if TESTING == false
        CHANNEL_NAME  = "#mirkofm"
    elsif TESTING == true
        CHANNEL_NAME  = "#testingchannel"
    end

    bot = Cinch::Bot.new do
        helpers do
            def google(query)
                url = "http://www.google.pl/search?q=#{CGI.escape(query)}"
                res = Nokogiri::HTML(open(url)).at("h3.r")

                title = res.text
                link = res.at('a')[:href]
                desc = res.at("./following::div").children.first.text
                rescue "Nie znaleziono żadnych wyników."
                else CGI.unescape_html(CGI.unescape("#{title} - #{desc} (#{link})")).force_encoding("ISO-8859-2").encode("UTF-8")
					.gsub("Âą", "ą")
					.gsub("ĂŚ", "ć")
					.gsub("ĂŞ", "ę")
					.gsub("Âł", "ł")
					.gsub("Ăą", "ń")
					.gsub("Ăł", "ó")
					.gsub("Âś", "ś")
					.gsub("Âź", "ź")
					.gsub("Âż", "ż")
					.gsub("â", "-")
					.gsub(/\Podobne+/, "")
					.gsub("âKopia", "")
					.gsub("âKopiaPodobne ", "")
					.gsub("âş", "")
					.gsub(/\(\/url\?q=/, "Link: ")
					.gsub(/\(\/images\?q=/, "Obrazek: ")
					.gsub(/\/&sa=.+/, "")
					# .gsub(/\(\/url\?q=.+/, /\.+/)
					# .gsub("(/q=" " Oryginalny URL: ")
                    #"#{title} - #{desc} (#{link})")
                    #.force_encoding('ISO-8859-2').encode('UTF-8')
            end
			
			class Bash
				def self.Random_Quote
					Get_Quote("random")
				end
			private
				def self.Get_Quote(params)
					result = Bash_Request(params)
					result.first.text
				end				
				def self.Bash_Request(params)
					result = Nokogiri::HTML(open("http://bash.org.pl/#{params}"))
					result.xpath("//div[@class = 'quote post-content post-body']")
				end
			end
        end
        
        configure do |c|
            c.server            = SERVER_NAME
            c.port              = PORT
            c.channels          = [CHANNEL_NAME]
            c.nick              = BOT_NICK
            c.realname          = BOT_REALNAME
            c.user              = BOT_USER
            c.password          = PASSWORD
        end

        on :join do |m|
            if USE_MY_NICK == false
                bot.irc.send "MODE " + BOT_NICK + " +x"
                # if m.user.to_s.downcase == BOT_NICK.downcase
                    # bot.Channel(CHANNEL_NAME).send("Po maturze chodziliśmy na... dziwki. ( ͡° ͜ʖ ͡°)\n   ~Jean Paul Secundo")
                    # bot.User(m.user.to_s).send("A po szkole chodziliśmy na... dziwki. ( ͡° ͜ʖ ͡°)\n~Jean Paul Secundo")
                # end
            end
        end
        
        on :kick do
            bot.Channel(CHANNEL_NAME).join
        end
        
        on :ban do
            bot.irc.send("MSG CHANSERV unban #{CHANNEL_NAME} #{BOT_NICK}")
        end

    if TESTING == true 
        on :message, "test" do |m|
            m.reply("Testowana wiadomość skierowana do użytkownika #{m.user.nick}")
        end
    end
	
		on :message, SAY_REGEX do |m|
			if m.user.to_s.downcase == ADMIN.downcase
				msg = SAY_REGEX.match(m.message)[:msg]
				bot.Channel(CHANNEL_NAME).msg msg
			end
		end
		
        # on :message, WOLFRAM_REGEX do |m|
            # query = WOLFRAM_REGEX.match(m.message)[:query]
            # result = Wolfram.fetch(query)
            ## puts result
            # hash = Wolfram::HashPresenter.new(result).to_hash
            ## puts hash
            # m.reply(hash[:pods]['Result'][0])
        # end
		
		on :message, WOLFRAM_REGEX do |m|
			query = WOLFRAM_REGEX.match(m.message)[:query]
			result = Wolfram.fetch(query)
			sprintf "%s", result
			gsub(" Clash  - Input nterpretation: ", "")
			m.reply result.inspect[0 .. 300]
				.gsub("a:", "answer:")
				.gsub("Math\n", "")
				.gsub(/\bAdministrativeDivision,|Airport,|City,|MetropolitanArea,|Ocean \(|assumptions: |Clash, |SubCategory|\)|Input*interpretation:*?\b\i/, "")
				.gsub("\n", "")
				.gsub(/\banswer:*|   - Input: [\d\(\)\+\-\*\/\.][\d\(\)\+\-\*\/\.][\d\(\)\+\-\*\/\.]   - |\b\i/, "")
				# .gsub(/\b(Clash|City)  - Input nterpretation:[ ]|\b\i/, "")
				# .gsub(/\banswer:  answer:  \b\i/, "answer: ")
				# .gsub("\n", "|")
			#result.inspect[0 .. 256].gsub("\n", "|")
			#.subpods[0].plaintext
			#result.assumptions[0][1].requery.fetch
			#result.inspect.to_s#
			#[0 .. 256].gsub("\n", " | ")
		end
        
        on :message, GOOGLE_REGEX do |m, params|
            m.reply google(params)
        end
   
		on :message, BASH_REGEX do |m|
            m.reply Bash.Random_Quote.gsub(/</, "\n<").gsub("\n", "")
        end
        
        # on :message, WIKIPEDIA_REGEX do |m, query|
            # m.reply wikipedia(query)
        # end
        
        # on :message, "wykop" do |m|
            # m.reply("Obraża papieża.")
        # end
        
        on :message, ":lenny:" do |m|
			if m.user.to_s.downcase == /\bCy(c|s)io(land)\i/
				m.reply("NOPE.")
			else 
				m.reply("( ͡° ͜ʖ ͡°)")
			end
		end
            
		on :message, LENNYFACE do |m|
            if m.user.to_s.downcase == ADMIN.downcase
                m.reply("( ͡° ͜ʖ ͡°)")
            else 
                m.reply("NIE DLA PSA LENNYFACE. ( ͡° ͜ʖ ͡°)")
				bot.irc.send("kick #{CHANNEL_NAME} #{m.user.nick} #{m.user.nick} pls: NIE DLA PSA LENNYFACE. ( ͡° ͜ʖ ͡°)")
            end
        end

		on :message, NIGGA_REGEX do |m|
			m.reply("https://www.youtube.com/watch?v=LsR2dKu5NYM&feature=youtu.be&t=7m4s")
		end
		
        # on :message, LENNY_REGEX do |m|
            # if m.user.to_s.downcase == ADMIN.downcase
                # m.reply("( ͡° ͜ʖ ͡°)")
            # else 
                # m.reply("NIE DLA PSA LENNYFACE. ( ͡° ͜ʖ ͡°)")
                # bot.irc.send("kick #{CHANNEL_NAME} #{m.user.nick} #{m.user.nick} pls: NIE DLA PSA LENNYFACE. ( ͡° ͜ʖ ͡°)")
            # end
        # end
        
        on :message, HOP_REGEX do |m|
            m.reply("sam se kurna skacz")
        end
        
        # on :message, WYKOP_REGEX do |m|
            # m.reply("Więc to tutaj obraża się papieża!")
        # end
        
        on :message, DELETE_ACCOUNT do |m|
            m.reply("sam se usuń")
            bot.irc.send("kick #{CHANNEL_NAME} #{m.user.nick} sam se usuń")
        end
        
        # on :message, LUNUX_REGEX do |m|
            # if m.user.to_s.downcase != "nvll".downcase
                # m.reply("#{m.user.nick} pls")
                # bot.irc.send("kick #{CHANNEL_NAME} #{m.user.nick} #{m.user.nick} pls")
            # end
        # end
    end
    bot.start
end