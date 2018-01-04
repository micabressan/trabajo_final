require 'digest'
require 'securerandom'
require 'httparty'

class Miner
  def initialize(wallet_hash)
    @wallet_hash = wallet_hash
  end

  def mine
    s = SecureRandom.base64(6)
    post_string(s) if Digest::SHA256.hexdigest(s)[0..5] == "000000"
  end

  def post_string(string)
    response = HTTParty.post("https://www.volteuro.com/api/mine",
      body: {
        strings: [string],
        wallet_hash: @wallet_hash
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
    puts response.body
  end
end

while true do
  Miner.new(ARGV[0]).mine
end