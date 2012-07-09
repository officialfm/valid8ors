# -*- encoding: utf-8 -*-

require_relative 'test_helper'

class TestUser < TestModel
  validates :password, password_strength: true
end

class TestUserAllowsNilPasswordToTrue < TestModel
  validates :password, password_strength: { allow_nil: true }
end

class TestUserAllowsNilPasswordToFalse < TestModel
  validates :password, password_strength: { allow_nil: false }
end

class TestPasswordFormatValidator < MiniTest::Unit::TestCase

  def test_valid_passwords
    valid_passwords.each { |password| assert TestUser.new(password: password).valid? }
  end

  def test_invalid_passwords
    invalid_passwords.each { |password| refute TestUser.new(password: password).valid? }
  end

  def test_default_message_on_error
    test_user = TestUser.new(password: "invalid_password")
    refute test_user.valid?
    assert test_user.errors[:password].include?("is not strong enough. It should contain at least a digit, lowercase and uppercase letter.")
  end

  def test_nil_password_when_allow_nil_option_is_not_set
    refute TestUser.new(password: nil).valid?
  end

  def test_nil_password_when_allow_nil_option_is_set_to_true
    assert TestUserAllowsNilPasswordToTrue.new(password: nil).valid?
  end

  def test_nil_password_when_allow_nil_option_is_set_to_false
    refute TestUserAllowsNilPasswordToFalse.new(password: nil).valid?
  end

  #######################
  ### Private methods ###
  #######################

  private

  def valid_passwords
    [
      'aA1',
      'Hey!Co0l',
      'SmA$H1nG!_PUmP!',
      'L0c@l'
    ]
  end

  def invalid_passwords
    [
      'aaa',
      'AAA',
      '123',
      'aAa',
      'a1a',
      '1A1',
      ' aA1',
      'aA1 ',
      ' aA1 ',
      'aA 12c'
    ]
  end

end
