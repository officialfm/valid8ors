# -*- encoding: utf-8 -*-

class EmailFormatValidator < ActiveModel::EachValidator

  EMAIL_PATTERN = /\A[\w\-\+_\.]([.]?([\w\-\+_]+)*)?@(?<domain>(?:[\w\-\.]+\.)+[a-z]{2,})\Z/i

  def validate_each(record, attribute, value)
    if matching = EMAIL_PATTERN.match(value)
      if options[:domains] && !options[:domains].include?(matching[:domain])
        record.errors.add(attribute, invalid_domain_message(record, attribute))
      end
    else
      record.errors.add(attribute, invalid_message(record, attribute))
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

  def invalid_domain_message(record, attribute)
    I18n.t  :invalid_domain,
            scope:    "#{record.class.i18n_scope}.errors.models.#{record.class.model_name.i18n_key}.attributes.#{attribute}",
            default:  "can't be from this domain"
  end

end
