class Course < ActiveRecord::Base
  attr_accessible 

  has_many :sections
end
