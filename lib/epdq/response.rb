require 'epdq/sha_calculator'
require 'cgi'

module EPDQ
  class Response

    def initialize(query_string, account = nil, additional_param_keys = [])
      @account = EPDQ.accounts[account] || EPDQ.default_account
      @additional_parameters = {}

      raw_parameters = CGI::parse(query_string)
      # collapse the array that CGI::parse produces for each value
      # and extract additional non-sha parameters
      raw_parameters.each do |k, v|
        if additional_param_keys.include?(k)
          @additional_parameters[k] = raw_parameters.delete(k).first
        else
          raw_parameters[k] = v.first
        end
      end

      @shasign = raw_parameters.delete("SHASIGN")
      @raw_parameters = raw_parameters
    end

    def valid_shasign?
      return false unless @shasign && @shasign.length > 0

      calculated_sha_out == @shasign
    end

    def parameters
      {}.tap do |hash|
        @raw_parameters.merge(@additional_parameters).each do |k, v|
          hash[k.downcase.to_sym] = v
        end
      end
    end

    private

    def calculated_sha_out
      calculator = EPDQ::ShaCalculator.new(@raw_parameters, @account.sha_out, @account.sha_type)
      calculator.sha_signature
    end

  end
end
