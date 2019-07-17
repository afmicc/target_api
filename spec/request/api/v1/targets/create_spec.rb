require 'rails_helper'

describe 'Create Targets', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let!(:auth_header) { user.create_new_auth_token }
  let(:params) do
    {
      target: build(:target).attributes
    }
  end

  describe 'POST api/v1/targets' do
    before do
      post api_v1_targets_path, params: params, headers: auth_header
    end

    context 'when the request is succesful' do
      it 'is expected a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'is expected a increasement of targets count by 1' do
        expect do
          post api_v1_targets_path, params: params, headers: auth_header
        end.to change(Target, :count).by(1)
      end

      it 'is expected that response contains some body data' do
        body = JSON response.body
        decimal_scale = 6
        expect(json_value(body, 'id')).not_to be_nil
        expect(json_value(body, 'user_id')).not_to be_nil
        expect(json_value(body, 'area_lenght')).to eq params[:target]['area_lenght']
        expect(json_value(body, 'title')).to eq params[:target]['title']
        expect(json_value(body, 'topic')).to eq params[:target]['topic']
        expect(json_value(body, 'latitude').to_d.round(decimal_scale))
          .to eq params[:target]['latitude'].round(decimal_scale)
        expect(json_value(body, 'longitude').to_d.round(decimal_scale))
          .to eq params[:target]['longitude'].round(decimal_scale)
      end
    end

    context 'when the user is not logged in' do
      it 'is expected an unauthorized response' do
        post api_v1_targets_path, params: params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
