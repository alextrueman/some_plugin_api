require 'rails_helper'

RSpec.describe AnalyzerCheckerService do
  let(:user)    { FactoryBot.create(:user) }
  let(:subject) { described_class.new(params, user) }

  describe '#call' do
    context 'when analyzed_site exists and its valid' do
      let(:analyzed_site) { FactoryBot.create(:analyzed_site) }
      let(:params) {
        { url: analyzed_site.url, source: analyzed_site.source }
      }

      it 'should return analyzed_site' do
        expect{subject.call}.to change{UserAnalyzedSite.count}.from(0).to(1)

        expect(subject.call).to eq analyzed_site
      end
    end

    context 'when analyzed_site not exists' do
      let(:params) { { url: 'foo', source: 'boo' } }

      before { allow_any_instance_of(AnalyzerPreparerService).to receive(:call).and_return(nil) }

      it 'should call analyzer preparer service' do
        expect{subject.call}.to change{UserAnalyzedSite.count}.from(0).to(1)

        expect(subject.call.url).to eq params[:url]
        expect(subject.call.source).to eq params[:source]
      end
    end
  end
end
