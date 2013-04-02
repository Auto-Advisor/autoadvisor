class Course < ActiveRecord::Base
  attr_accessible :dept, :name, :number

  has_many :sections
end
