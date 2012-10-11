# -*- encoding: utf-8 -*-

require_relative 'test_helper'

class TestBlacklistValidator < MiniTest::Unit::TestCase

  class User < TestModel
    validates :name, blacklist: true
  end

  def test_some_blacklisted_words
    names_that_should_be_blacklisted.each do |name|
      user = User.new(name: name)
      refute user.valid?
      assert user.errors[:name]
    end
  end

  def test_some_whitelisted_words
    names_that_should_be_whitelisted.each { |name| assert User.new(name: name).valid? }
  end

  def test_default_message_on_error
    user = User.new(name: "Get up, fuck up")
    refute user.valid?
    assert user.errors[:name].include?("is blacklisted")
  end

  #######################
  ### Private methods ###
  #######################

  private

  def names_that_should_be_blacklisted
    ["Fucking gay", "I have a boner", "Show me your ass"]
  end

  def names_that_should_be_whitelisted
    ["Alice in wonderland", "The Doors", "This is a simple name"]
  end

end
