require 'spec_helper'
require 'nova_poshta_api'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

feature 'External request' do
  it 'disabled' do
    uri = URI('https://google.com')
    expect { Net::HTTP.get(uri) }.to raise_error(WebMock::NetConnectNotAllowedError)
  end
end

describe NovaPoshtaAPI do
  before :all do
    ENV['NOVA_POSHTA_API_TOKEN'] = SecureRandom.uuid
  end

  before :each do
    stub_request(:post, NovaPoshtaAPI::API_URL)
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: response_body, headers: {})
  end

  let(:bad_response) { NovaPoshtaAPI::BadResponse }
  let(:bad_request) { NovaPoshtaAPI::BadRequest }

  let(:valid_json) do
    {
      success: true,
      errors: Random.rand(5..10).times.map { Faker::Lorem.sentence },
      data: response_data
    }
  end

  let(:cities) do
    Random.rand(5..10).times.map do
      name = Faker::Address.city
      {
        'Ref' => SecureRandom.uuid,
        'Description' =>  name,
        'DescriptionRu' =>  "#{name} - RU"
      }
    end
  end

  let(:locations) do
    Random.rand(5..10).times.map do |n|
      name = "Location #{n}"
      {
        'Ref' => SecureRandom.uuid,
        'Description' =>  name,
        'DescriptionRu' =>  "#{name} - RU",
        'Phone' => Faker::PhoneNumber.phone_number,
        'CityRef' => SecureRandom.uuid
      }
    end
  end

  let(:response_data) { cities }
  let(:method_name) { :cities }

  def expect_error
    expect { subject.send(method_name) }.to raise_error(error_type, /#{error_message}/i)
  end

  context 'when response is not JSON' do
    let(:response_body) { 'not a JSON string' }
    let(:error_type) { bad_response }
    let(:error_message) { 'json' }

    it 'fails' do
      expect_error
    end
  end

  context 'when response status unknown'  do
    let(:response_body) { JSON.dump(valid_json.except(:success)) }
    let(:error_type) { bad_response }
    let(:error_message) { 'status' }

    it 'fails' do
      expect_error
    end
  end

  context 'when data unknown'  do
    let(:response_body) { JSON.dump(valid_json.except(:data)) }
    let(:error_type) { bad_response }
    let(:error_message) { 'data' }

    it 'fails' do
      expect_error
    end
  end

  context 'when status false' do
    let(:response_body) { JSON.dump(valid_json.merge(success: false)) }
    let(:error_type) { bad_request }
    let(:error_message) { valid_json[:errors].first }

    it 'fails' do
      expect_error
    end
  end

  context 'when status true' do
    let(:response_body) { JSON.dump(valid_json) }

    context 'when cities requested' do
      let(:response_data) { cities }

      it "doesn't fail" do
        expect { subject.cities }.not_to raise_error
      end

      it 'returns proper data' do
        proper_data = cities.map do |city|
          {
            id: city['Ref'],
            name: city['Description'],
            name_ru: city['DescriptionRu']
          }
        end

        expect(subject.cities).to match_array(proper_data)
      end
    end

    context 'when locations requested' do
      let(:response_data) { locations }

      it "doesn't fail" do
        expect { subject.locations }.not_to raise_error
      end

      it 'returns proper data' do
        proper_data = locations.map do |location|
          {
            id: location['Ref'],
            name: location['Description'],
            name_ru: location['DescriptionRu'],
            phone: location['Phone'],
            city_id: location['CityRef'],
            address: ''
          }
        end

        expect(subject.locations).to match_array(proper_data)
      end

      # TODO: Check retreiving location's address from description
    end
  end
end