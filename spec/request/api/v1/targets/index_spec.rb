require 'rails_helper'

describe 'List Targets', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let!(:auth_header) { user.create_new_auth_token }
  let!(:target) { create(:target, user: user) }

  describe 'GET api/v1/targets' do
    before do
      get api_v1_targets_path, headers: auth_header
    end

    context 'when the request is succesful' do
      it 'is expected a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'is expected that response contains at least one' do
        body = JSON response.body
        expect(body).to_not be_empty
        expect(body.count).to be_positive
      end

      it 'is expected that response contains at least some body data' do
        body = (JSON response.body)
        last = json_value(body, 'targets').last
        expect(json_value(last, 'id')).not_to be_nil
        expect(json_value(last, 'user_id')).not_to be_nil
        expect(json_value(last, 'area_lenght')).to eq target.area_lenght
        expect(json_value(last, 'title')).to eq target.title
        expect(json_value(last, 'topic')).to eq target.topic
        expect(json_value(last, 'latitude').to_d).to eq target.latitude
        expect(json_value(last, 'longitude').to_d).to eq target.longitude
      end
    end

    context 'when the user is not logged in' do
      it 'is expected an unauthorized response' do
        get api_v1_targets_path
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
