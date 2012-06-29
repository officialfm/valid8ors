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
    ruby blacklist_test.rb

## Reserved Validator

### Usage

Add the following to one of your models:

    validates :name, reserved: true

You can also modify the default message ("is reserved") if validation fails:

    validates :name, reserved: { message: "is not part of the whitelist" }

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

You can also modify the default message ("is improperly formatted") if validation fails:

    validates :email, email_format: { message: "is not well formatted" }

Restrict your validation to accept emails from specific domains only:

    validates :email, email_format: { domains: ['gmail.com', 'live.com'] }

You can also modify the default message ("can't be from this domain") if email's domain is rejected

    validates :email, email_format: { invalid_domain_message: 'forbidden domain', domains: ['gmail.com', 'live.com'] }

### I18n

If you use I18n, the default keys to translate are :improperly_formatted (for the incorrect email message) and :invalid_domain (for the blacklisted domain email message).
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

You can also modify the default message ("is improperly formatted") if validation fails:

    validates :url, url_format: { message: "is not well formatted" }

### I18n

If you use I18n, the default key to translate is :improperly_formatted. So if you add to your User model:

    validates :url, url_format: true

You can translate (or overload) the default message via for e.g. (in english): "en.activerecord.errors.models.user.attributes.url.improperly_formatted"

### Tests

    cd test
    ruby url_format_test.rb

## Password Format Validator

Check if a password contains at least a lower case letter, an upper case letter and a digit.
Password length validation is not included here as you can use Rails' builtin "LengthValidator".

### Usage

Add the following to one of your models:

    validates :password, password_format: true

You can also modify the default message ("is not strong enough") if validation fails:

    validates :password, password_format: { message: "isn't secure" }

### I18n

If you use I18n, the default key to translate is :insecure. So if you add to your User model:

    validates :password, password_format: true

You can translate (or overload) the default message via for e.g. (in english): "en.activerecord.errors.models.user.attributes.password.insecure"

### Tests

    cd test
    ruby password_format_test.rb

## Compatibility

Ruby 1.8 is not supported.
