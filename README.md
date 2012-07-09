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

### Blacklist file

You can create a blacklist.yml file in the config directory of your Rails application if you need to overload the one used by this gem.

### I18n

If you use I18n, the default key to translate is :blacklisted. So if you add to your User model:

    validates :name, blacklist: true

You can translate (or overload) the default message via for e.g. using activerecord (in english): "en.activerecord.errors.models.user.attributes.name.blacklisted"

### Tests

    cd test
    ruby blacklist_test.rb

## Reserved Validator

### Usage

Add the following to one of your models:

    validates :name, reserved: true

### Reserved file

You can create a reserved.yml file in the config directory of your Rails application if you need to overload the one used by this gem.

### I18n

If you use I18n, the default key to translate is :reserved. So if you add to your User model:

    validates :name, reserved: true

You can translate (or overload) the default message via for e.g. using activerecord (in english): "en.activerecord.errors.models.user.attributes.name.reserved"

### Tests

    cd test
    ruby reserved_test.rb

## Email Format Validator

### Usage

Add the following to one of your models:

    validates :email, email_format: true

Restrict your validation to accept emails from specific domains only:

    validates :email, email_format: { domains: ['gmail.com', 'live.com'] }

### I18n

Default keys to translate are :improperly_formatted (when not an email format) and :invalid_domain (when email domain not listed in "domains" option).
So if you add to your User model:

    validates :email, email_format: true

You can translate (or overload) the default message via for e.g. (in english): "en.activerecord.errors.models.user.attributes.email.improperly_formatted"

### Tests

    cd test
    ruby email_format_test.rb

### Credits

Regular Expression tests based on [Comparing E-mail Address Validating Regular Expressions](http://fightingforalostcause.net/misc/2006/compare-email-regex.php)

## Url Format Validator

### Usage

Add the following to one of your models:

    validates :url, url_format: true

### I18n

If you use I18n, the default key to translate is :improperly_formatted. So if you add to your User model:

    validates :url, url_format: true

You can translate (or overload) the default message via for e.g. (in english): "en.activerecord.errors.models.user.attributes.url.improperly_formatted"

### Tests

    cd test
    ruby url_format_test.rb

## Password Strength Validator

Check if a password contains at least a digit, lowercase and uppercase letter.
Password length validation is not included here as you can use Rails' builtin "LengthValidator".

### Usage

Add the following to one of your models:

    validates :password, password_strength: true

### I18n

The default key to translate is :insecure. So if you add to your User model:

    validates :password, password_strength: true

You can translate (or overload) the default message via for e.g. (in english): "en.activerecord.errors.models.user.attributes.password.insecure"

### Tests

    cd test
    ruby password_strength_test.rb

## Compatibility

Ruby 1.8 is not supported.
