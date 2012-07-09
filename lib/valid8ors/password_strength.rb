# -*- encoding: utf-8 -*-

class PasswordStrengthValidator < ActiveModel::EachValidator

  # Password must contain at least a digit, lowercase and uppercase letter.
  PASSWORD_PATTERN = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$/

  def validate_each(record, attribute, value)
    unless value =~ PASSWORD_PATTERN
      record.errors.add(attribute, invalid_message(record, attribute))
    end
  end

  #######################
  ### Private methods ###
  #######################

  private

  def invalid_message(record, attribute)
    I18n.t  :insecure,
            scope:    "#{record.class.i18n_scope}.errors.models.#{record.class.model_name.i18n_key}.attributes.#{attribute}",
            default:  "is not strong enough. It should contain at least a digit, lowercase and uppercase letter."
  end

end
