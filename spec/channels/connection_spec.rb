require 'rails_helper'

describe ApplicationCable::Connection, type: :channel do
  let!(:user) { create(:user, :confirmed) }

  it 'successfully connects' do
    connect 'api/v1/cable', params: auth_header
    expect(connection.current_user.id).to eq user.id
  end

  it 'rejects connection' do
    expect { connect 'api/v1/cable' }.to have_rejected_connection
  end
end
