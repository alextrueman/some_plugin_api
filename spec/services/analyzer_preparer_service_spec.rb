require 'rails_helper'

RSpec.describe AnalyzerPreparerService do
  let(:analyzed_site) { FactoryBot.create(:analyzed_site) }
  let(:params)        { { url: analyzed_site.url, source: 'foboo' } }
  let(:hexdigest)     { Digest::SHA1.hexdigest(params[:source]) }
  let(:subject)       { described_class.new(params, analyzed_site, hexdigest) }

  describe '#call' do
    it 'should process changed analyzed_site' do
      analyzed_site.reject!

      subject.call

      expect(analyzed_site.queued?).to be_truthy
      expect(analyzed_site.source).to eq params[:source]
    end
  end
end
