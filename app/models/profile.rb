class Profile < ActiveRecord::Base
  attr_accessible :user, :major, :credit
  belongs_to :user
end
