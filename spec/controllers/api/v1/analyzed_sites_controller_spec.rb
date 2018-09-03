require 'rails_helper'

RSpec.describe Api::V1::AnalyzedSitesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:response_body) { JSON.parse(response.body) }

  before { request.headers['Authorization'] = "Token token=#{user.auth_token}" }

  describe 'POST #create' do
    let(:perform_action) { post :create, params: params }

    context 'without created analyzed_site' do
      let(:params) { { site_params: { url: 'foo.com', source: 'fooboobar' } } }

      it 'should create queued analyzed site' do
        expect(AnalyzedSite.count).to eq 0

        perform_action

        expect(AnalyzedSite.count).to eq 1
        expect(response_body['url']).to eq params[:site_params][:url]
        expect(response_body['source']).to eq params[:site_params][:source]
        expect(response_body['status']).to eq 'queued'
      end
    end

    context 'with analyzed site' do
      let!(:user_analyzed_site) { FactoryBot.create(:user_analyzed_site) }
      let(:user)                { user_analyzed_site.user }
      let(:analyzed_site)       { user_analyzed_site.analyzed_site }
      let(:params)              { { site_params: { url: analyzed_site.url, source: analyzed_site.source } } }

      before { analyzed_site.approve! }

      it 'should return approved site' do
        perform_action

        expect(response_body['url']).to eq analyzed_site.url
        expect(response_body['source']).to eq analyzed_site.source
        expect(response_body['status']).to eq 'approved'
      end
    end
  end

  describe 'GET #index' do
    let(:perform_action) { get :index }

    context 'with user that has analyzed sites' do
      let!(:user_analyzed_sites) { FactoryBot.create_list(:user_analyzed_site, 5, user: user) }
      let(:analyzed_sites_ids) { user_analyzed_sites.map { |e| e.analyzed_site.id } }

      it 'should return analyzed sites for user' do
        perform_action

        expect(response_body['analyzed_sites'].map { |e| e['id'] }).to match_array analyzed_sites_ids
      end
    end
  end

  describe 'GET #show' do
    let(:perform_action) { get :show, params: params }

    context 'when site exist' do
      let!(:analyzed_site) { FactoryBot.create(:analyzed_site) }
      let(:params) { { id: analyzed_site.id } }

      it 'should return analyzed site' do
        perform_action

        expect(response_body['id']).to eq analyzed_site.id
        expect(response_body['status']).to eq 'queued'
      end
    end
  end
end
