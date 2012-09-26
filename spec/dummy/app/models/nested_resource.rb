class NestedResource < ActiveRecord::Base
  attr_accessible :parent_resource_id, :prop
  belongs_to :parent_resource
end
