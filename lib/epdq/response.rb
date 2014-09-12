require 'epdq/sha_calculator'
require 'cgi'

module EPDQ
  class Response
    attr_reader :raw_parameters, :signature

    def initialize(query_string)
      @raw_parameters = Hash[CGI.parse(query_string).map  { |k,v| [k.upcase, v.first] }]
      @signature      = raw_parameters.delete("SHASIGN")
    end

    def valid_signature?
      raise "missing or empty SHASIGN parameter" unless signature && signature.length > 0

      calculated_sha_out == signature
    end

    def parameters
      Hash[raw_parameters.map { |k, v| [k.downcase.to_sym, v] }]
    end

    private

    def calculated_sha_out
      EPDQ::ShaCalculator.new(raw_parameters, EPDQ.sha_out, EPDQ.sha_type).signature
    end
  end
end
