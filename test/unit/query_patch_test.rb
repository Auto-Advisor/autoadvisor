require 'test_helper'

class TestRecord < ActiveRecord::Base
  attr_accessor :float, :fix, :string, :bool
  def initialize
  end

  def query_fields
    {:float => :float, :fix => :int, :string => :string, :bool => :bool}
  end

  def save!
  end
end

class QueryPatchTest < ActiveSupport::TestCase
  def c(field, op, val)
    CreditConstraint.new(:field => field, :op => op, :value => val)
  end

  test "float test" do
    record = TestRecord.new
    record.float = 4.5
    assert record.satisfies_constraint?(c(:float, '>', 4))
    assert record.satisfies_constraint?(c(:float, '>=', 4))
    assert !record.satisfies_constraint?(c(:float, '<', 4))
    assert !record.satisfies_constraint?(c(:float, '<=', 4))
    assert record.satisfies_constraint?(c(:float, '!=', 4.0))
  end

  test "bool test" do
    record = TestRecord.new
    record.bool = false
    assert record.satisfies_constraint?(c(:bool, '==', false))
    assert !record.satisfies_constraint?(c(:bool, '==', true))
    record.bool = true
    assert record.satisfies_constraint?(c(:bool, '==', true))
    assert !record.satisfies_constraint?(c(:bool, '==', false))
  end

  test "string test" do
    record = TestRecord.new
    record.string = ""
    assert record.satisfies_constraint?(c(:string, '==', ""))
    assert !record.satisfies_constraint?(c(:string, '==', "s"))
    assert !record.satisfies_constraint?(c(:string, '!=', ""))
    assert record.satisfies_constraint?(c(:string, '!=', "s"))

    record.string = "foo"
    assert record.satisfies_constraint?(c(:string, '==', "foo"))
    assert !record.satisfies_constraint?(c(:string, '==', "bar"))
    assert !record.satisfies_constraint?(c(:string, '!=', "foo"))
    assert record.satisfies_constraint?(c(:string, '!=', "bar"))
  end

  test "int test" do
    record = TestRecord.new
    record.fix = 42
    assert !record.satisfies_constraint?(c(:fix, '!=', 42))
    assert !record.satisfies_constraint?(c(:fix, '==', 13))
    assert record.satisfies_constraint?(c(:fix, '!=', 13))

    assert record.satisfies_constraint?(c(:fix, '<=', 42))
    assert record.satisfies_constraint?(c(:fix, '>=', 42))
    assert !record.satisfies_constraint?(c(:fix, '>', 42))
    assert !record.satisfies_constraint?(c(:fix, '<', 42))
    assert record.satisfies_constraint?(c(:fix, '<', 43))
    assert record.satisfies_constraint?(c(:fix, '>', 41))
  end
end
