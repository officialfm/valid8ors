# -*- encoding: utf-8 -*-

require_relative 'test_helper'

class TestUser < TestModel
  validates :name, reserved: true
end

class TestReservedValidator < MiniTest::Unit::TestCase

  def test_some_reserved_words
    names_that_should_be_reserved.each do |name|
      test_user = TestUser.new(name: name)
      refute test_user.valid?
      assert test_user.errors[:name]
    end
  end

  def test_some_not_reserved_words
    names_that_should_be_not_reserved.each { |name| assert TestUser.new(name: name).valid? }
  end

  def test_with_nil_attribute
    test_user = TestUser.new(name: nil)
    assert test_user.valid?
  end

  def test_default_message_on_error
    test_user = TestUser.new(name: "abOUt")
    refute test_user.valid?
    assert test_user.errors[:name].include?("is reserved")
  end

  #######################
  ### Private methods ###
  #######################

  private

  def names_that_should_be_reserved
    ["About", "faq", "heLP"]
  end

  def names_that_should_be_not_reserved
    ["daftpunk", "u2", "madonna"]
  end

end
