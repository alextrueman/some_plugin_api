require 'rails_helper'

RSpec.describe AnalyzerAlgorithmService do
  let!(:analyzed_site) { FactoryBot.create(:analyzed_site) }
  let(:subject)        { described_class.new(analyzed_site.id) }

  describe '#call' do
    it 'should process analyzed_site' do
      expect(analyzed_site.status).to eq 'queued'

      subject.call

      expect(analyzed_site.reload.status).not_to eq 'queued'
    end
  end
end
