require 'rails_helper'

describe 'GET api/v1/topics', type: :request do
  let!(:user) { create(:user) }
  let!(:topic) { create(:topic) }

  context 'when the request is succesful' do
    before do
      get api_v1_topics_path, headers: auth_header
    end

    it 'is expected a successful response' do
      expect(response).to be_successful
    end

    it 'is expected that response contains at least one' do
      topics = json_value(response.parsed_body, 'topics')
      expect(topics.count).to be >= 1
    end

    it 'is expected that response contains at least some body data' do
      topics = json_value(response.parsed_body, 'topics')
      expect(topics).to include_unordered_json([{ id: topic.id, title: topic.title }])
    end
  end

  context 'when the user is not logged in' do
    it 'is expected an unauthorized response' do
      get api_v1_topics_path
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
