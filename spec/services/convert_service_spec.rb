describe ConvertService, type: :service do
  let(:params) do
    {
      data: input,
      keys: keys
    }
  end

  subject { described_class.new(params) }

  describe '#call' do
    context 'without keys' do
      let(:keys) { [] }
      let(:input) { JSON.parse(File.read(Rails.root.join('spec/fixtures/input.json'))) }

      it 'converts input' do
        expect(subject.call).to eq input
      end
    end

    context 'with keys' do
      let(:keys) { %w(country school) }
      let(:input) do
        [
          HashWithIndifferentAccess.new(country: 'UK', school: 'Cambridge', class: 'Grade 12', student_counts: 14),
          HashWithIndifferentAccess.new(country: 'UK', school: 'Cambridge', class: 'Grade 12', student_counts: 16)
        ]
      end
      let(:output) do
        {
          "UK" => {
            "Cambridge" => [
              {"class"=>"Grade 12", "student_counts"=>14},
              {"class"=>"Grade 12", "student_counts"=>16}
            ]
          }
        }
      end

      it 'converts input' do
        expect(subject.call).to eq output
      end
    end
  end
end
