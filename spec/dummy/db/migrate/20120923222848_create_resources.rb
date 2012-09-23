class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :user_id
      t.string :prop

      t.timestamps
    end
  end
end
