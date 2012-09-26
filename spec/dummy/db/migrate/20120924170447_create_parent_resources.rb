class CreateParentResources < ActiveRecord::Migration
  def change
    create_table :parent_resources do |t|
      t.string :prop
      t.integer :user_id

      t.timestamps
    end
  end
end
