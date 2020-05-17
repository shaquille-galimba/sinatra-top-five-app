class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
			t.integer :user_id
			t.integer :topic_id
			t.string :contents

      t.timestamps null: false
    end
  end
end
