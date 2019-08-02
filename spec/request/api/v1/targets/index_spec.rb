require 'rails_helper'

describe 'List Targets', type: :request do
  let!(:user) { create(:user, :confirmed, :with_targets, targets_count: 2) }
  let!(:target) { create(:target, user: user) }
  let!(:new_user) { create(:user, :confirmed, :with_targets) }

  describe 'GET api/v1/targets' do
    before do
      get api_v1_targets_path, headers: auth_header
    end

    context 'when the request is succesful' do
      it 'is expected a successful response' do
        expect(response).to be_successful
      end

      it 'is expected that response contains at least one' do
        body = JSON response.body
        targets = json_value(body, 'targets')
        expect(targets).to_not be_empty
        expect(targets.count).to be(3)
      end

      it 'is expected that response contains at least some body data' do
        expect(response.body).to include_json(
          targets: [
            { user_id: user.id },
            { user_id: user.id },
            { user_id: user.id }
          ]
        )
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
