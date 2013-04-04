class Course < ActiveRecord::Base
  attr_accessible :dept, :desc, :name, :number, :sections, :string

  has_many :sections
end
