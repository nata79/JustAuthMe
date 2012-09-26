class ParentResource < ActiveRecord::Base
  attr_accessible :prop, :user_id
  has_many :nested_resources
end
