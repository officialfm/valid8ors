# -*- encoding: utf-8 -*-

require_relative 'test_helper'

class TestReservedValidator < MiniTest::Unit::TestCase

  class User < TestModel
    validates :name, reserved: true
  end

  def test_some_reserved_words
    names_that_should_be_reserved.each do |name|
      user = User.new(name: name)
      refute user.valid?
      assert user.errors[:name]
    end
  end

  def test_some_not_reserved_words
    names_that_should_be_not_reserved.each { |name| assert User.new(name: name).valid? }
  end

  def test_with_nil_attribute
    user = User.new(name: nil)
    assert user.valid?
  end

  def test_default_message_on_error
    user = User.new(name: "abOUt")
    refute user.valid?
    assert user.errors[:name].include?("is reserved")
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
