# -*- encoding: utf-8 -*-

require_relative 'test_helper'

class TestUser < TestModel
  validates :name, absence: true
end

class TestUserWithAllowBlank < TestModel
  validates :name, absence: { allow_blank: true }
end

class TestAbsenceValidator < MiniTest::Unit::TestCase

  def test_when_name_absent
    test_user = TestUser.new
    assert test_user.valid?
  end

  def test_when_name_present_or_blank
    ["", "James"].each do |name|
      test_user = TestUser.new(name: name)
      refute test_user.valid?
      assert test_user.errors[:name]
    end
  end

  def test_when_allow_blank
    test_user = TestUserWithAllowBlank.new(name: "")
    assert test_user.valid?
  end

  def test_default_message_on_error
    test_user = TestUser.new(name: "James")
    refute test_user.valid?
    assert test_user.errors[:name].include?("is present when it should be absent")
  end

end
