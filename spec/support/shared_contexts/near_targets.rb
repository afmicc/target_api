shared_context 'near targets', shared_context: :metadata do
  # users
  let!(:user2) { create(:user, :confirmed) }
  let!(:user3) { create(:user, :confirmed) }

  # topics
  let!(:topic1) { create(:topic) }
  let!(:topic2) { create(:topic) }

  # target - Montenvideo Shopping - 7km - compatible: Y
  let!(:target1) do
    create(:target,
           user: user2,
           title: 'Montenvideo Shopping',
           topic: topic1,
           latitude: -34.9036534,
           longitude: -56.1449722,
           area_lenght: 4)
  end

  # target - Nuevocentro Shopping - 4.13 km - compatible: Y
  let!(:target2) do
    create(:target,
           user: user3,
           title: 'Nuevocentro Shopping',
           topic: topic1,
           latitude: -34.8756006,
           longitude: -56.1771999,
           area_lenght: 2)
  end

  # target - Rural del prado - 4.09 km - compatible: N
  let!(:target3) do
    create(:target,
           user: user2,
           title: 'Rural del prado',
           topic: topic2,
           latitude: -34.8719561,
           longitude: -56.2144232,
           area_lenght: 4)
  end

  # target - Portones Shopping - 11.3 km - compatible: N
  let!(:target4) do
    create(:target,
           user: user3,
           title: 'Portones Shopping',
           topic: topic1,
           latitude: -34.8811386,
           longitude: -56.0813423,
           area_lenght: 2)
  end

  # new target to add - Rootstrap
  let(:target_new) do
    {
      target: attributes_for(:target,
                             title: 'Rootstrap',
                             topic_id: topic1.id,
                             latitude: -34.9071206,
                             longitude: -56.2011391,
                             area_lenght: 4)
    }
  end

  subject { post api_v1_targets_path, params: target_new, headers: auth_header }
end
