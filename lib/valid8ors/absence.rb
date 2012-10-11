# -*- encoding: utf-8 -*-

class AbsenceValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    condition = options[:allow_blank?] ? :blank? : :nil?
    record.errors.add(attribute, invalid_message(record, attribute)) unless value.send(condition)
  end

  #######################
  ### Private methods ###
  #######################

  private

  def invalid_message(record, attribute)
    I18n.t  :not_absent,
            scope:    "#{record.class.i18n_scope}.errors.models.#{record.class.model_name.i18n_key}.attributes.#{attribute}",
            default:  "is present when it should be absent"
  end

end

