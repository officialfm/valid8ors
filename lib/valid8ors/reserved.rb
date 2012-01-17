# -*- encoding: utf-8 -*-

class ReservedValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || invalid_message(record, attribute)) if reserved?(value)
  end

  # Lazy load and transform directly words to patterns instead of creating regexps at each matching tests
  def reserved
    @reserved ||= YAML.load_file(reserved_file)
  end

  #######################
  ### Private methods ###
  #######################

  private

  def invalid_message(record, attribute)
    I18n.t  :reserved,
            scope:    "#{record.class.i18n_scope}.errors.models.#{record.class.model_name.i18n_key}.attributes.#{attribute}",
            default:  "is reserved"
  end

  def reserved?(str)
    reserved.any? { |pattern| str == pattern }
  end

  def reserved_file
    if defined?(Rails.root) && (reserved_file_path = Rails.root.join("config", "reserved.yml")).exist?
      return reserved_file_path
    end
    File.join(File.dirname(__FILE__), "../../config/reserved.yml")
  end

end
