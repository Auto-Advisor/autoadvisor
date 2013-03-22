class Credit < ActiveRecord::Base
  attr_accessible :dept, :gpa, :name, :number, :year, :user

  belongs_to :user
end
