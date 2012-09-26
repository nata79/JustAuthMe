class CreateNestedResources < ActiveRecord::Migration
  def change
    create_table :nested_resources do |t|
      t.string :prop
      t.integer :parent_resource_id

      t.timestamps
    end
  end
end
