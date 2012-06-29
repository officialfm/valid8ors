# -*- encoding: utf-8 -*-

class EmailFormatValidator < ActiveModel::EachValidator

  EMAIL_PATTERN = /\A[\w\-\+_\.]+@(?<domain>(?:[\w\-\.]+\.)+[a-z]{2,})\Z/i

  def validate_each(record, attribute, value)
    if matching = EMAIL_PATTERN.match(value)
      if options[:accepted_domains] && !options[:accepted_domains].include?(matching[:domain])
        record.errors.add(attribute, options[:message] || invalid_message(record, attribute))
      end
    else
      record.errors.add(attribute, options[:message] || invalid_message(record, attribute))
    end
  end

  #######################
  ### Private methods ###
  #######################

  private

  def invalid_message(record, attribute)
    I18n.t  :improperly_formatted,
            scope:    "#{record.class.i18n_scope}.errors.models.#{record.class.model_name.i18n_key}.attributes.#{attribute}",
            default:  "is improperly formatted"
  end

end
