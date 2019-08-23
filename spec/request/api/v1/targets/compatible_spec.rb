require 'rails_helper'

describe 'GET api/v1/targets/compatible', type: :request do
  let!(:user) { create(:user, :confirmed) }

  context 'when there is only one target match' do
    let!(:target) { build(:target, user: user) }
    let!(:new_user) { create(:user, :confirmed) }
    let!(:new_target) do
      build(:target,
            user: new_user,
            topic: target.topic,
            latitude: target.latitude + 0.01,
            longitude: target.longitude)
    end

    before do
      Support::Mock::GeocoderMock.add_stub_worthington(target.latitude, target.longitude)
      target.save!
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
        targets = json_value(response.parsed_body, 'targets')
        expect(targets).to_not be_empty
        expect(targets.count).to be_positive
      end

      it 'is expected that response contains at least some body data' do
        decimal_scale = 0.00001
        expect(response.body).to include_json(
          targets: [
            {
              id: new_target.id,
              user_id: new_user.id,
              area_lenght: new_target.area_lenght,
              title: new_target.title,
              topic:
              {
                id: target.topic.id,
                title: target.topic.title
              },
              latitude: be_within(decimal_scale).of(new_target.latitude),
              longitude: be_within(decimal_scale).of(new_target.longitude)
            }
          ]
        )
      end
    end

    context 'when the user is not logged in' do
      it 'is expected an unauthorized response' do
        get compatible_api_v1_targets_path
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'when there are multi target matchs' do
    include_context 'near targets'

    let!(:target) do
      attributes = target_new[:target]
      attributes[:user] = user
      create(:target, attributes)
    end

    before do
      get compatible_api_v1_targets_path, headers: auth_header
    end

    it 'is expected a successful response' do
      expect(response).to be_successful
    end

    it 'is expected that response contains 2 targets' do
      body = JSON response.body
      targets = json_value(body, 'targets')
      expect(targets.count).to be(2)
    end

    it 'is expected that response contains some body data' do
      decimal_scale = 0.00001
      expect(response.body).to include_json(
        targets: [
          {
            id: target1.id,
            user_id: user2.id,
            area_lenght: target1.area_lenght,
            topic:
              {
                id: topic1.id,
                title: topic1.title
              },
            latitude: be_within(decimal_scale).of(target1.latitude),
            longitude: be_within(decimal_scale).of(target1.longitude)
          },
          {
            id: target2.id,
            user_id: user3.id,
            area_lenght: target2.area_lenght,
            topic:
              {
                id: topic1.id,
                title: topic1.title
              },
            latitude: be_within(decimal_scale).of(target2.latitude),
            longitude: be_within(decimal_scale).of(target2.longitude)
          }
        ]
      )
    end
  end
end
