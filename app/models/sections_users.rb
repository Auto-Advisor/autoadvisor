class SectionsUsers < ActiveRecord::Base
  attr_accessor :user, :section
  belongs_to :user
  belongs_to :section
end
