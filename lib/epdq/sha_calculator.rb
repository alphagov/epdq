require 'digest/sha1'
require 'digest/sha2'

module EPDQ
  class ShaCalculator < Struct.new(:parameters, :secret, :sha_type)
    def signature
      body = parameters.sort.each_with_object('') do |(k, v), buffer|
        next unless v.to_s.length > 0
        buffer << "#{k.to_s.upcase}=#{v}#{secret}"
      end

      begin
        Digest.const_get(sha_type.upcase).hexdigest(body).upcase
      rescue NameError
        raise "Unexpected sha_type"
      end
    end
  end
end
