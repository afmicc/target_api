require 'rails_helper'

describe 'Create Targets', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let(:params) do
    {
      target: attributes_for(:target)
    }
  end

  describe 'POST api/v1/targets' do
    subject { post api_v1_targets_path, params: params, headers: auth_header }

    context 'when the request is succesful' do
      it 'is expected a successful response' do
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'is expected a increasement of targets count by 1' do
        expect { subject }.to change(Target, :count).by(1)
      end

      it 'is expected that response contains some body data' do
        subject
        body = JSON response.body
        decimal_scale = 6
        expect(json_value(body, 'target', 'id')).not_to be_nil
        expect(json_value(body, 'target', 'user_id')).not_to be_nil
        expect(json_value(body, 'target', 'area_lenght')).to eq params[:target][:area_lenght]
        expect(json_value(body, 'target', 'title')).to eq params[:target][:title]
        expect(json_value(body, 'target', 'topic')).to eq params[:target][:topic]
        expect(json_value(body, 'target', 'latitude').to_d.round(decimal_scale))
          .to eq params[:target][:latitude].to_d.round(decimal_scale)
        expect(json_value(body, 'target', 'longitude').to_d.round(decimal_scale))
          .to eq params[:target][:longitude].to_d.round(decimal_scale)
      end
    end

    context 'when the request is fail' do
      before do
        params[:target][:title] = ''
        post api_v1_targets_path, params: params, headers: auth_header
      end

      it 'is expected an error response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'is expected an error message' do
        body = JSON response.body
        expect(json_value(body, 'error')).to eq I18n.t('api.errors.invalid_model')
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
