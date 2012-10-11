# -*- encoding: utf-8 -*-

require_relative 'test_helper'

class TestAbsenceValidator < MiniTest::Unit::TestCase

  class User < TestModel
    validates :name, absence: true
  end

  class OtherUser < TestModel
    validates :name, absence: { allow_blank: true }
  end

  def test_when_name_absent
    user = User.new
    assert user.valid?
  end

  def test_when_name_present_or_blank
    ["", "James"].each do |name|
      user = User.new(name: name)
      refute user.valid?
      assert user.errors[:name]
    end
  end

  def test_when_allow_blank
    other_user = OtherUser.new(name: "")
    assert other_user.valid?
  end

  def test_default_message_on_error
    user = User.new(name: "James")
    refute user.valid?
    assert user.errors[:name].include?("is present when it should be absent")
  end

end
