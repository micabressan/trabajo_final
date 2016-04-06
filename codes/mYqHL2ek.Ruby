class Release
	attr_accessor :age, :category, :title

	# Called on Release.new(...)
	def initialize(node)
		@age = node.css('.p-time').text
		@category = node.css('.c-adult').text
		@title = node.css('.p-title').text
	end
end