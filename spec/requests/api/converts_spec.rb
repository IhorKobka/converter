describe 'Converts', :type => :request do
  let(:params) do
    {
      convert: {
        data: input,
        keys: keys
      }
    }
  end

  let(:headers) do
    {
      **http_login_header,
      'CONTENT_TYPE' => 'application/json'
    }
  end

  context 'without keys' do
    let(:keys) { nil }
    let(:input) { JSON.parse(File.read(Rails.root.join('spec/fixtures/input.json'))) }

    it 'converts input' do
      post '/api/convert.json', params: params.to_json, headers: headers

      expect(JSON.parse(response.body)).to eq input
    end
  end

  context 'with keys' do
    let(:keys) { [:country, :school, :class] }
    let(:input) { JSON.parse(File.read(Rails.root.join('spec/fixtures/input.json'))) }
    let(:output) { JSON.parse(File.read(Rails.root.join('spec/fixtures/output.json'))) }

    it 'converts input' do
      post '/api/convert', params: params.to_json, headers: headers

      expect(JSON.parse(response.body)).to eq output
    end
  end
end
