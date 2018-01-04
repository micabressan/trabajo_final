require 'net/http'
require 'base64'
require 'json'
require 'uri'

uri = URI.parse("https://api.clarifai.com/v2/models/aaa03c23b3724a16a56b629203edc62c/outputs")
request = Net::HTTP::Post.new(uri)

request.content_type = "application/json"
request["Authorization"] = "Key YOUR_CLARIFAI_API_KEY"

# For file
encoded_file = Base64.encode64(File.open("/Users/username/Pictures/cool.jpg", "rb").read)
image = { base64: encoded_file }
# For url
url = "http://cdn2-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-8.jpg"
image = { url: url }

body = {
  inputs: [
    data: {
      image: image
    }
  ]
}

request.body = body.to_json

req_options = { use_ssl: uri.scheme == "https", }

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

puts response.body