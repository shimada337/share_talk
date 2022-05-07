class CreateHouseMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :house_members do |t|

      t.timestamps
    end
  end
end
