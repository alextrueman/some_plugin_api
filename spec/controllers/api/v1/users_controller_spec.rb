require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:response_body) { JSON.parse(response.body) }
  let(:perform_action) { post :create, params: params }

  describe 'POST #create' do
    context 'with browser_name' do
      let(:params) { { user: { browser_name: Faker::Internet.username } } }

      it 'should create User with API-token' do
        expect{perform_action}.to change{User.count}.from(0).to(1)

        expect(response.status).to eq 200
        expect(response_body['auth_token']).not_to be_nil
      end
    end
  end
end
