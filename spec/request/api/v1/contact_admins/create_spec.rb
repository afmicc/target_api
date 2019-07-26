require 'rails_helper'

describe 'Create Contact Admins', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let(:params) do
    {
      contact_admin: attributes_for(:contact_admin)
    }
  end

  describe 'POST api/v1/contact_admin' do
    subject { post api_v1_contact_admin_index_path, params: params, headers: auth_header }

    context 'when the request is succesful' do
      it 'is expected a successful response' do
        subject
        expect(response).to have_http_status(:no_content)
      end

      it 'is expected a increasement of contact_admins count by 1' do
        expect { subject }.to change(ContactAdmin, :count).by(1)
      end

      it 'is expected a increasement of delay_jobs count by 1' do
        expect { subject }.to change(Delayed::Job, :count).by(1)
      end
    end

    context 'when the request is fail' do
      before do
        params[:contact_admin][:email] = ''
        post api_v1_contact_admin_index_path, params: params, headers: auth_header
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
        post api_v1_contact_admin_index_path, params: params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
