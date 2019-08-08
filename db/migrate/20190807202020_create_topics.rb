class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title, null: false

      t.timestamps
    end

    %w[football travel politics art dating music movies series food].each do |topic|
      Topic.create! title: topic
    end
  end
end
