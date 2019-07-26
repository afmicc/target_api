require 'rails_helper'

describe 'Compatible Targets', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let!(:target) { build(:target, user: user) }

  before do
    Support::Mock::GeocoderMock.add_stub_worthington(target.latitude, target.longitude)
    target.save!
  end

  describe 'GET api/v1/targets/compatible' do
    let!(:new_user) { create(:user, :confirmed) }
    let!(:new_target) do
      build(:target,
            user: new_user,
            topic: target.topic,
            latitude: target.latitude + 0.01,
            longitude: target.longitude)
    end

    before do
      Support::Mock::GeocoderMock.add_stub_new_york(new_target.latitude, new_target.longitude)
      new_target.save!
    end

    context 'when the request is succesful' do
      before do
        get compatible_api_v1_targets_path, headers: auth_header
      end

      it 'is expected a successful response' do
        expect(response).to be_successful
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
        expect(json_value(last, 'area_lenght')).to eq new_target.area_lenght
        expect(json_value(last, 'title')).to eq new_target.title
        expect(json_value(last, 'topic')).to eq new_target.topic
        expect(json_value(last, 'latitude').round(10)).to eq new_target.latitude.round(10)
        expect(json_value(last, 'longitude').round(10)).to eq new_target.longitude.round(10)
      end
    end

    context 'when the user is not logged in' do
      it 'is expected an unauthorized response' do
        get compatible_api_v1_targets_path
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
