class Kikki
	attr_accessor :base_url
end

class Kikki
	def base_url=(url)
		@base_url = url
	end

	def get_base_url()
		@base_url
	end
end