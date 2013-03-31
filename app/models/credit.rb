class Credit < ActiveRecord::Base
  attr_accessible :dept, :grade, :name, :number, :year, :user

  belongs_to :user
  def self.query_fields
    {:dept => :string,
     :grade => :real,
     :name => :string,
     :number => :int,
     :year => :int}
  end
end
