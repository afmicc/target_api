require 'rails_helper'

describe 'Update Users', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let!(:auth_header) { user.create_new_auth_token }
  let(:params) do
    {
      user: build(:user).attributes
    }
  end

  subject { put api_v1_user_path(user), params: params, headers: auth_header }

  describe 'PUT api/v1/users/1' do
    context 'when the request is succesful' do
      before do
        subject
      end

      it 'is expected a successful response' do
        expect(response).to be_successful
      end

      it 'is expected that response contains some body data' do
        expect(response.body).to include_json(
          user: {
            id: user.id,
            name: params[:user]['name'],
            gender: params[:user]['gender']
          }
        )
      end

      it 'is expected that email is ignored' do
        expect(response.body).to include_json(
          user: {
            id: user.id,
            email: user.email
          }
        )
      end
    end

    context 'when attach an avatar' do
      let(:filename) { 'small_avatar.png' }
      let(:avatar) do
        File.open(
          File.expand_path(
            Rails.root.join('spec', 'fixtures', filename)
          )
        ).read
      end
      let(:base64_data) do
        {
          data: "data:image/png;base64,#{Base64.encode64(avatar)}",
          filename: filename,
          content_type: 'image/png'
        }
      end

      before do
        params[:user][:avatar] = base64_data
      end

      it 'is expected a successful response' do
        subject
        expect(response).to be_successful
      end

      it 'is expected that user has some file attached' do
        subject
        expect(user.reload.avatar.attached?).to be
      end

      it 'is expected that response contains url data' do
        subject
        expect(response.body).to include_json(
          user: {
            avatar: %r{^(http|https):\/\/[^ "]+$}
          }
        )
      end

      it 'is expected a increasement of active storage attachments count by 1' do
        expect { subject }.to change(ActiveStorage::Attachment, :count).by(1)
      end
    end

    context 'when the request is fail' do
      it 'requires the name parameter' do
        params[:user]['name'] = nil
        put api_v1_user_path(user), params: params, headers: auth_header
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include_json(error: I18n.t('api.errors.invalid_model'))
      end
    end
  end
end
