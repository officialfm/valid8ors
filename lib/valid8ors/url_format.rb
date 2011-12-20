# -*- encoding: utf-8 -*-

class UrlFormatValidator < ActiveModel::EachValidator

  URL_PATTERN = /^(http|https):\/\/[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}((:[0-9]{1,5})?\/.*)?$/

  def validate_each(record, attribute, value)
    unless value =~ URL_PATTERN
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

