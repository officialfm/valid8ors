   __  __            ___            __     __
  /\ \/\ \          /\_ \    __    /\ \  /'_ `\
  \ \ \ \ \     __  \//\ \  /\_\   \_\ \/\ \L\ \    ___   _ __   ____
   \ \ \ \ \  /'__`\  \ \ \ \/\ \  /'_` \/_> _ <_  / __`\/\`'__\/',__\
    \ \ \_/ \/\ \L\.\_ \_\ \_\ \ \/\ \L\ \/\ \L\ \/\ \L\ \ \ \//\__, `\
     \ `\___/\ \__/.\_\/\____\\ \_\ \___,_\ \____/\ \____/\ \_\\/\____/
      `\/__/  \/__/\/_/\/____/ \/_/\/__,_ /\/___/  \/___/  \/_/ \/___/


## Purpose

Bring you a nice set of custom validators for Rails 3.

## Installation

Add this line to your Gemfile:

    gem 'valid8ors'

Then run:

    bundle install

## Blacklist Validator

Check that an attribute doesn't contain blacklisted values.

### Usage

```ruby
class User < ActiveRecord::Base
  validates :name, blacklist: true
end
```

### Blacklist file

You can create a blacklist.yml file in the config directory of your Rails application if you need to overload the one used by this gem.

### I18n error message

Key to translate: **:blacklisted**.
Hence, considering the example above, the translation path would be:

    en.activerecord.errors.models.user.attributes.name.blacklisted

## Reserved Validator

Validate an attribute against a reserved list of values.

### Usage

```ruby
class User < ActiveRecord::Base
  validates :name, reserved: true
end
```

### Reserved file

You can create a reserved.yml file in the config directory of your Rails application if you need to overload the one used by this gem.

### I18n error message

Key to translate: **:reserved**.
Hence, considering the example above, the translation path would be:

    en.activerecord.errors.models.user.attributes.name.reserved

## Email Format Validator

### Usage

```ruby
class User < ActiveRecord::Base
  validates :email, email_format: true
end
```

Restrict your validation to specific domains:

```ruby
class User < ActiveRecord::Base
  validates :email, email_format: { domains: ['gmail.com', 'live.com'] }
end
```

### I18n error messages

Keys to translate: **:improperly_formatted** (when not an email format) and **:invalid_domain** (when email domain not listed in "domains" option).
Hence, considering the two examples above, translation paths would be:

    en.activerecord.errors.models.user.attributes.email.improperly_formatted
    en.activerecord.errors.models.user.attributes.email.invalid_domain

### Credits

Regular Expression tests based on [Comparing E-mail Address Validating Regular Expressions](http://fightingforalostcause.net/misc/2006/compare-email-regex.php)

## Url Format Validator

### Usage

```ruby
class User < ActiveRecord::Base
  validates :url, url_format: true
end
```

### I18n error message

Key to translate: **:improperly_formatted**.
Hence, considering the example above, the translation path would be:

    en.activerecord.errors.models.user.attributes.url.improperly_formatted

## Password Strength Validator

Check if a password contains at least a digit, lowercase and uppercase letter.
Password length validation is not included here as you can use Rails' builtin "LengthValidator".

### Usage

```ruby
class User < ActiveRecord::Base
  validates :password, password_strength: true
end
```

### I18n error message

Key to translate: **:insecure**.
Hence, considering the example above, the translation path would be:

    en.activerecord.errors.models.user.attributes.password.insecure

## Absence Validator

By default, checks if an attribute is nil. Use allow_blank option to accept empty objects.

### Usage

```ruby
class User < ActiveRecord::Base
  validates :name,  absence: true                  # Validate name is nil
  validates :email, absence: { allow_blank: true } # Validate email is blank
end
```

### I18n error message

Key to translate: **:not_absent**.
Hence, considering the example above, translation paths would be:

    en.activerecord.errors.models.user.attributes.name.not_absent
    en.activerecord.errors.models.user.attributes.email.not_absent

## Tests

    rake test

## Compatibility

Ruby version >= 1.9.x
