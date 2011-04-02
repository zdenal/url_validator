require 'uri'
require 'active_model'
require 'addressable/uri'

module ActiveModel
  module Validations
    class UrlValidator < ActiveModel::Validator

      def validate(record)
        schemes = options[:schemes] || %w(http https ftp).map(&:to_s)
        message = options[:message] || "is not a valid URL"

        options[:attributes].each do |attribute|
          begin
            uri = Addressable::URI.parse(record.send(attribute) || '')
            unless schemes.include?(uri.scheme)
              record.errors.add(attribute, message, :value => uri.to_s)
            end
          rescue Addressable::URI::InvalidURIError
            record.errors.add(attribute, message, :value => uri.to_s)
          end
        end

      end

    end

    module ClassMethods
      # Validates whether the value of the specified attribute is valid url.
      #
      #   class Unicorn
      #     include ActiveModel::Validations
      #     attr_accessor :website, :ftpsite
      #     validates_url :website, :allow_blank => true
      #     validates_url :ftpsite, :schemes => ['ftp']
      #   end
      # Configuration options:
      # * <tt>:message</tt> - A custom error message (default is: "is not a valid URL").
      # * <tt>:allow_nil</tt> - If set to true, skips this validation if the attribute is +nil+ (default is +false+).
      # * <tt>:allow_blank</tt> - If set to true, skips this validation if the attribute is blank (default is +false+).
      # * <tt>:schemes</tt> - Array of URI schemes to validate against. (default is +['http', 'https']+)

      def validates_url(*attr_names)
        attrs = attr_names.take_while{|a| !a.instance_of?(Hash)}
        attrs.each do |a_name|
          class_eval <<-EOF
            def #{a_name}_normalized
              Addressable::URI.parse(#{a_name}).normalize.to_s unless #{a_name}.blank?
            end
          EOF
        end
        validates_with UrlValidator, _merge_attributes(attr_names)
      end
    end
  end
end

