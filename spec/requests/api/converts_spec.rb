describe 'Converts', :type => :request do
  let(:params) do
    {
      convert: {
        data: input,
        skipped_keys: skipped_keys
      }
    }
  end

  context 'without skipped keys' do
    let(:skipped_keys) { [] }
    let(:input) { JSON.parse(File.read(Rails.root.join('spec/fixtures/input.json'))) }
    let(:output) { JSON.parse(File.read(Rails.root.join('spec/fixtures/output.json'))) }

    it 'converts input' do
      post '/api/convert', params: params, headers: http_login_header

      expect(JSON.parse(response.body)).to eq output
    end
  end

  context 'with skipped keys' do
    let(:skipped_keys) { [:country, :school] }
    let(:input) do
      [
        { country: 'UK', school: 'Cambridge', class: 'Grade 12', student_counts: 14 },
        { country: 'UK', school: 'Cambridge', class: 'Grade 12', student_counts: 16 }
      ]
    end
    let(:output) do
      {
        'Grade 12' => [{ 'student_counts' => 14 }, { 'student_counts' => 16 }]
      }
    end

    it 'converts input' do
      post '/api/convert', params: params, headers: http_login_header

      expect(JSON.parse(response.body)).to eq output
    end
  end
end
