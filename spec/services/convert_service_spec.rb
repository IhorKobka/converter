describe ConvertService, type: :service do
  let(:params) do
    {
      data: input,
      skipped_keys: skipped_keys
    }
  end

  subject { described_class.new(params) }

  describe '#call' do
    context 'without skipped keys' do
      let(:skipped_keys) { [] }
      let(:input) { JSON.parse(File.read(Rails.root.join('spec/fixtures/input.json'))) }
      let(:output) { JSON.parse(File.read(Rails.root.join('spec/fixtures/output.json'))) }

      it 'converts input' do
        expect(subject.call).to eq output
      end
    end

    context 'with skipped keys' do
      let(:skipped_keys) { %w(country school) }
      let(:input) do
        [
          HashWithIndifferentAccess.new(country: 'UK', school: 'Cambridge', class: 'Grade 12', student_counts: 14),
          HashWithIndifferentAccess.new(country: 'UK', school: 'Cambridge', class: 'Grade 12', student_counts: 16)
        ]
      end
      let(:output) do
        {
          'Grade 12' => [{ 'student_counts' => 14 }, { 'student_counts' => 16 }]
        }
      end

      it 'converts input' do
        expect(subject.call).to eq output
      end
    end
  end
end
