require 'rails_helper'

describe 'DELETE api/v1/targets/1', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let!(:target) { create(:target, user: user) }

  context 'when the request is succesful' do
    subject { delete api_v1_target_path(target), headers: auth_header }
    it 'is expected a successful response' do
      subject
      expect(response).to have_http_status(:no_content)
    end

    it 'is expected a decrement of targets count by 1' do
      expect { subject }.to change(Target, :count).by(-1)
    end
  end

  context "when the target doesn't exist" do
    before do
      unfound_id = target.id + 1
      delete api_v1_target_path(unfound_id), headers: auth_header
    end

    it 'is expected a not found response' do
      expect(response).to have_http_status(:not_found)
    end

    it 'is expected an error message' do
      expect(response.body).to include_json(error: I18n.t('api.errors.not_found'))
    end
  end

  context "when the target wasn't created by user" do
    let!(:new_user) { create(:user, :confirmed) }
    let!(:new_auth_header) { new_user.create_new_auth_token }

    before do
      delete api_v1_target_path(target), headers: new_auth_header
    end

    it 'is expected a not found response' do
      expect(response).to have_http_status(:not_found)
    end

    it 'is expected an error message' do
      expect(response.body).to include_json(error: I18n.t('api.errors.not_found'))
    end
  end

  context 'when the user is not logged in' do
    it 'is expected an unauthorized response' do
      delete api_v1_target_path(target)
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
