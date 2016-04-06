require 'json'
require 'net/http'

module NovaPoshtaAPI
  API_URL = 'https://api.novaposhta.ua/v2.0/json/'.freeze

  class BadRequest < StandardError; end
  class BadResponse < StandardError; end

  def self.cities
    post(request_payload('Address', 'getCities')).map do |hash|
      city_attrs(hash)
    end
  end

  def self.locations
    post(request_payload('Address', 'getWarehouses')).map do |hash|
      location_attrs(hash)
    end
  end

  def self.location_attrs(hash)
    name, address = partition_location_name(hash['Description'])
    name_ru, = partition_location_name(hash['DescriptionRu'])
    {
      id: hash['Ref'],
      name: name,
      name_ru: name_ru,
      phone: hash['Phone'],
      city_id: hash['CityRef'],
      address: address
    }
  end

  def self.city_attrs(hash)
    {
      id: hash['Ref'],
      name: hash['Description'].sub("'", '’'),
      name_ru: hash['DescriptionRu']
    }
  end

  def self.partition_location_name(name)
    name
      .sub("'", '’')
      .sub(/відділення|отделение/i, '')
      .partition(':') # TODO: Improve retreiving address from description
      .values_at(0, 2)
      .map(&:strip)
  end

  private

  def self.post(payload)
    uri = URI(API_URL)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = payload
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
    process_response(response)
  end

  def self.request_payload(model_name, method_name, method_properties = {})
    { apiKey: ENV['NOVA_POSHTA_API_TOKEN'], modelName: model_name,
      calledMethod: method_name, methodProperties: method_properties
    }.to_json
  end

  def self.process_response(response)
    begin
      json = JSON.parse(response.body)
    rescue => e
      fail(BadResponse, e.inspect)
    end
    validate_json(json)

    json['data']
  end

  def self.validate_json(json)
    success, data, errors, warnings = json.values_at('success', 'data', 'errors', 'warnings')
    fail(BadResponse, 'unknown status') if success.nil?
    fail(BadRequest, errors.to_s) unless success
    fail(BadResponse, 'has no data') unless data
    Rails.logger.warn("Nova Poshta warning: #{warnings}") if !warnings.nil? && warnings.empty?
  end
end