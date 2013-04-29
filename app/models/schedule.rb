class Schedule < ActiveRecord::Base
  attr_accessible :name, :sections, :user

  def as_json
    {'name' => name, 'sections' => sections}
  end

  belongs_to :user
  has_and_belongs_to_many :sections
end
