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
        expect(response).to be_successful
      end

      it 'is expected a increasement of targets count by 1' do
        expect { subject }.to change(Target, :count).by(1)
      end

      it 'is expected that response contains some body data' do
        subject
        body = JSON response.body
        decimal_scale = 10
        expect(json_value(body, 'target', 'id')).not_to be_nil
        expect(json_value(body, 'target', 'user_id')).not_to be_nil
        expect(json_value(body, 'target', 'area_lenght')).to eq params[:target][:area_lenght]
        expect(json_value(body, 'target', 'title')).to eq params[:target][:title]
        expect(json_value(body, 'target', 'topic')).to eq params[:target][:topic]
        expect(json_value(body, 'target', 'latitude').round(decimal_scale))
          .to eq params[:target][:latitude].round(decimal_scale)
        expect(json_value(body, 'target', 'longitude').round(decimal_scale))
          .to eq params[:target][:longitude].round(decimal_scale)
      end

      context "when the created target is compatible with other target's user" do
        let!(:new_user) { create(:user, :confirmed) }
        let!(:new_target) do
          build(:target,
                user: new_user,
                topic: params[:target][:topic],
                latitude: params[:target][:latitude] + 0.01,
                longitude: params[:target][:longitude])
        end

        before do
          Geocoder::Lookup::Test.add_stub(
            [params[:target][:latitude], params[:target][:longitude]],
            [
              {
                latitude: params[:target][:latitude],
                longitude: params[:target][:longitude],
                address: 'Worthington, OH',
                city: 'Worthington',
                state: 'Ohio',
                state_code: 'OH',
                country: 'United States',
                country_code: 'US'
              }
            ]
          )
          Geocoder::Lookup::Test.add_stub(
            [new_target.latitude, new_target.longitude],
            [
              {
                latitude: new_target.latitude,
                longitude: new_target.longitude,
                address: 'New York, NY, USA',
                state: 'New York',
                state_code: 'NY',
                country: 'United States',
                country_code: 'US'
              }
            ]
          )
          new_target.save!
        end

        it 'is expected a successful response' do
          subject
          expect(response).to have_http_status(:ok)
        end

        it 'is expected a increasement of delay_jobs count by 1' do
          expect { subject }.to change(Delayed::Job, :count).by(1)
        end

        it 'is expected a increasement of chat_rooms count by 1' do
          expect { subject }.to change(ChatRoom, :count).by(1)
        end
      end
      context "when the created target isn't compatible with other target's user" do
        let!(:new_user) { create(:user, :confirmed) }
        let!(:new_target) do
          build(:target,
                user: new_user,
                topic: params[:target][:topic],
                latitude: 90,
                longitude: 180)
        end

        before do
          Geocoder::Lookup::Test.add_stub(
            [params[:target][:latitude], params[:target][:longitude]],
            [
              {
                latitude: params[:target][:latitude],
                longitude: params[:target][:longitude],
                address: 'Worthington, OH',
                city: 'Worthington',
                state: 'Ohio',
                state_code: 'OH',
                country: 'United States',
                country_code: 'US'
              }
            ]
          )
          Geocoder::Lookup::Test.add_stub(
            [new_target.latitude, new_target.longitude],
            [
              {
                latitude: new_target.latitude,
                longitude: new_target.longitude,
                address: 'New York, NY, USA',
                state: 'New York',
                state_code: 'NY',
                country: 'United States',
                country_code: 'US'
              }
            ]
          )
          new_target.save!
        end

        it 'is expected a successful response' do
          subject
          expect(response).to have_http_status(:ok)
        end

        it 'is expected the same count of delay_jobs' do
          subject
          expect { subject }.to change(Delayed::Job, :count).by(0)
        end

        it 'is expected the same count of chat_rooms' do
          subject
          expect { subject }.to change(ChatRoom, :count).by(0)
        end
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

    context "when the user already has #{Target::MAX_TARGETS_PER_USER - 1} targets" do
      let!(:user) do
        create(:user,
               :confirmed,
               :with_targets,
               targets_count: (Target::MAX_TARGETS_PER_USER - 1))
      end
      let!(:auth_header) { user.create_new_auth_token }

      subject { post api_v1_targets_path, params: params, headers: auth_header }

      it 'is expected a successful response' do
        subject
        expect(response).to be_successful
      end

      it 'is expected a increasement of targets count by 1' do
        expect { subject }.to change(Target, :count).by(1)
      end
    end

    context "when the user already has #{Target::MAX_TARGETS_PER_USER} targets" do
      let!(:user) do
        create(:user,
               :confirmed,
               :with_targets,
               targets_count: Target::MAX_TARGETS_PER_USER)
      end
      let!(:auth_header) { user.create_new_auth_token }

      subject { post api_v1_targets_path, params: params, headers: auth_header }

      it 'is expected an error response' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'is expected the same count of targets' do
        expect { subject }.to change(Target, :count).by(0)
      end
    end
  end
end
