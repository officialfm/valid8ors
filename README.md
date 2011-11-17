# Valid8ors

Valid8ors brings you a nice set of custom validators for Rails 3.

## Installation

Add this line to your Gemfile:

    gem 'valid8ors'

Then run:

    bundle install

## Blacklist Validator

### Usage

Add the following to one of your models:

    validates :name, blacklist: true

You can also modify the default message ("is blacklisted") if validation fails:

    validates :name, blacklist: { message: "is not part of the whitelist" }

### Blacklist file

You can create a blacklist.yml file in the config directory of your Rails application if you need to overload the one used by this gem.

### I18n

If you use I18n, the default key to translate is :blacklisted. So if you add to your User model:

    validates :name, blacklist: true

You can translate (or overload) the default message via for e.g. using activerecord (in english): "en.activerecord.errors.models.user.attributes.name.blacklisted"

### Tests

    cd test
    ruby blacklist_validator_test.rb

## Email Format Validator

### Usage

Add the following to one of your models:

    validates :email, email_format: true

You can also modify the default message ("is improperly formatted") if validation fails:

    validates :email, email_format: { message: "is not well formatted" }

### I18n

If you use I18n, the default key to translate is :improperly_formatted. So if you add to your User model:

    validates :email, email_format: true

You can translate (or overload) the default message via for e.g. (in english): "en.activerecord.errors.models.user.attributes.email.improperly_formatted"

### Tests

    cd test
    ruby email_format_validator_test.rb

### Credits

Regular Expression tests based on [Comparing E-mail Address Validating Regular Expressions](http://fightingforalostcause.net/misc/2006/compare-email-regex.php)

## Compatibility

Ruby 1.8 is not supported.
