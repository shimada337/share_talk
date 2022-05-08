class CreateHouseMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :house_members do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :introduction, null: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
