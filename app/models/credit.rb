class Credit < ActiveRecord::Base
  attr_accessible :dept, :grade, :name, :number, :year, :user

  belongs_to :user
  query_field :dept, :string
  query_field :grade, :real
  query_field :name, :string
  query_field :number, :int
  query_field :year, :int
end
