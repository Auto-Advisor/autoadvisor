class Schedule < ActiveRecord::Base
  attr_accessible :name, :sections, :user

  belongs_to :user
  has_and_belongs_to_many :sections
end
