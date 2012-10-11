# -*- encoding: utf-8 -*-

require_relative 'test_helper'

class TestEmailFormatValidator < MiniTest::Unit::TestCase

  class User < TestModel
    validates :email, email_format: true
  end

  class UserWithEmailDomains < TestModel
    validates :email, email_format: { domains: ['mail.com', 'subdomain.mail.com'] }
  end

  class UserAllowsNilEmailToTrue < TestModel
    validates :email, email_format: { allow_nil: true }
  end

  class UserAllowsNilEmailToFalse < TestModel
    validates :email, email_format: { allow_nil: false }
  end

  def test_valid_emails
    valid_emails.each { |email| assert User.new(email: email).valid? }
  end

  def test_invalid_emails
    invalid_emails.each { |email| refute User.new(email: email).valid? }
  end

  def test_email_when_domains_option
    valid_emails_with_correct_domains = ['user@mail.com', 'user@subdomain.mail.com']
    valid_emails_with_incorrect_domains = ['user@gmail.com', 'user@subdomain.gmail.com']

    valid_emails_with_correct_domains.each do |email|
      assert UserWithEmailDomains.new(email: email).valid?
    end

    valid_emails_with_incorrect_domains.each do |email|
      refute UserWithEmailDomains.new(email: email).valid?
    end
  end

  def test_default_invalid_domain_message_on_error
    user = UserWithEmailDomains.new(email: "user@gmail.com")
    refute user.valid?
    assert user.errors[:email].include?("can't be from this domain")
  end

  def test_default_message_on_error
    user = User.new(email: "invalid_email@")
    refute user.valid?
    assert user.errors[:email].include?("is improperly formatted")
  end

  def test_nil_email_when_allow_nil_option_is_not_set
    refute User.new(email: nil).valid?
  end

  def test_nil_email_when_allow_nil_option_is_set_to_true
    assert UserAllowsNilEmailToTrue.new(email: nil).valid?
  end

  def test_nil_email_when_allow_nil_option_is_set_to_false
    refute UserAllowsNilEmailToFalse.new(email: nil).valid?
  end

  #######################
  ### Private methods ###
  #######################

  private

  def valid_emails
    [
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@letters-in-local.org',
      '01234567890@numbers-in-local.net',
      # '&\'*+-./=?^_{}~@other-valid-characters-in-local.net',
      # 'mixed-1234-in-{+^}-local@sld.net',
      'a@single-character-in-local.org',
      # '"quoted"@sld.com',
      # '"\e\s\c\a\p\e\d"@sld.com',
      # '"quoted-at-sign@sld.org"@sld.com',
      # '"escaped\"quote"@sld.com',
      # '"back\slash"@sld.com',
      'one-character-third-level@a.example.com',
      'single-character-in-sld@x.org',
      'local@dash-in-sld.com',
      'letters-in-sld@123.com',
      'one-letter-sld@x.org',
      'uncommon-tld@sld.museum',
      'uncommon-tld@sld.travel',
      'uncommon-tld@sld.mobi',
      'country-code-tld@sld.uk',
      'country-code-tld@sld.rw',
      'local@sld.newTLD',
      # 'punycode-numbers-in-tld@sld.xn--3e0b707e',
      'the-total-length@of-an-entire-address-cannot-be-longer-than-two-hundred-and-fifty-four-characters' +
        '-and-this-address-is-254-characters-exactly-so-it-should-be-valid-and-im-going-to-add-some-more' +
        '-words-here-to-increase-the-lenght-blah-blah-blah-blah-bla.org',
      # 'bracketed-IP-instead-of-domain@[127.0.0.1]',
      'local@sub.domains.com',
      'first+last@domain.com'
    ]
  end

  def invalid_emails
    [
      '',
      'foo@bar',
      'foo@bar.c',
      'foo@bar.com@bar.com',
      'foo@',
      '@missing-local.org',
      '! #$%`|@invalid-characters-in-local.org',
      '(),:;`|@more-invalid-characters-in-local.org',
      '<>@[]\`|@even-more-invalid-characters-in-local.org',
      # '.local-starts-with-dot@sld.com',
      # 'local-ends-with-dot.@sld.com',
      # 'two..consecutive-dots@sld.com',
      'partially."quoted"@sld.com',
      # 'the-local-part-is-invalid-if-it-is-longer-than-sixty-four-characters@sld.net',
      'missing-sld@.com',
      # 'sld-starts-with-dashsh@-sld.com',
      # 'sld-ends-with-dash@sld-.com',
      'invalid-characters-in-sld@! "#$%(),/;<>_[]`|.org',
      'missing-dot-before-tld@com',
      'missing-tld@sld.',
      # 'the-total-length@of-an-entire-address-cannot-be-longer-than-two-hundred-and-fifty-four-characters-and' +
      #   '-this-address-is-255-characters-exactly-so-it-should-be-invalid-and-im-going-to-add-some-more-words' +
      #   '-here-to-increase-the-lenght-blah-blah-blah-blah-bl.org',
      'missing-at-sign.net',
      'unbracketed-IP@127.0.0.1',
      'invalid-ip@127.0.0.1.26',
      'another-invalid-ip@127.0.0.256',
      'IP-and-port@127.0.0.1:25'
    ]
  end

end
