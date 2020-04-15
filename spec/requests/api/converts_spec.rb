describe 'Converts', :type => :request do
  let(:params) do
    {
      convert: {
        data: input,
        keys: keys
      }
    }
  end

  context 'without keys' do
    let(:keys) { nil }
    let(:input) { JSON.parse(File.read(Rails.root.join('spec/fixtures/input.json'))) }

    it 'converts input' do
      post '/api/convert', params: params, headers: http_login_header

      expect(JSON.parse(response.body)).to eq input
    end
  end

  context 'with keys' do
    let(:keys) { [:country, :school, :class] }
    let(:input) { JSON.parse(File.read(Rails.root.join('spec/fixtures/input.json'))) }
    let(:output) { JSON.parse(File.read(Rails.root.join('spec/fixtures/output.json'))) }

    it 'converts input' do
      post '/api/convert', params: params, headers: http_login_header

      expect(JSON.parse(response.body)).to eq output
    end
  end
end
