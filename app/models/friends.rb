class Friends < ActiveRecord::Base

  attr_accessible :num_of
  has_and_belongs_to_many :user

end
