# -*- encoding: utf-8 -*-

require_relative 'test_helper'

class TestUrlFormatValidator < MiniTest::Unit::TestCase

  class Site < TestModel
    validates :url, url_format: true
  end

  class SiteAllowsNilToTrue < TestModel
    validates :url, url_format: { allow_nil: true }
  end

  class SiteAllowsNilToFalse < TestModel
    validates :url, url_format: { allow_nil: false }
  end

  def test_valid_url
    valid_urls.each { |url| assert Site.new(url: url).valid? }
  end

  def test_invalid_url
    invalid_urls.each { |url| refute Site.new(url: url).valid? }
  end

  def test_default_message_on_error
    site = Site.new(url: "invalid_url")
    refute site.valid?
    assert site.errors[:url].include?("is improperly formatted")
  end

  def test_nil_url_when_allow_nil_option_is_not_set
    refute Site.new(url: nil).valid?
  end

  def test_nil_url_when_allow_nil_option_is_set_to_true
    assert SiteAllowsNilToTrue.new(url: nil).valid?
  end

  def test_nil_url_when_allow_nil_option_is_set_to_false
    refute SiteAllowsNilToFalse.new(url: nil).valid?
  end

  #######################
  ### Private methods ###
  #######################

  private

  def valid_urls
    [
      'http://test.com',
      'http://www.test.ch',
      'https://super.long.url.with.many.subdomaim.com',
      'http://url.ch/resources',
      'http://url.ch/many/resources/after_path',
      'http://domain.com/?withparam=true',
      'http://domain.com/?withparam=true&otherparam=true',
      'http://domain.com/#with_anchor',
      'http://domain.com/#with_anchor?and=params',
      'http://domain.com/#with_anchor?and=param&other=params',
    ]
  end

  def invalid_urls
    [
      '',
      'test',
      'http://s.c',
      'http://.ru',
      'test.ca',
      'http://test.ca.c',
      'http://test?xsxa',
      'bla://service.com',
      'http://test.toolongdomain',
      'http://énon.ch',
      'http://do main.com/#with_anchor',
      ''
    ]
  end

end
