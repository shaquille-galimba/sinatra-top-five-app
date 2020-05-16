class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
			t.string :content
			t.intenger :user_id
			t.integer :topic_id

      t.timestamps null: false
    end
  end
end
