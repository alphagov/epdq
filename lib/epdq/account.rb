require 'epdq/sha_calculator'

module EPDQ
  class Account
    attr_accessor :pspid, :sha_in, :sha_out, :sha_type, :test_mode

    def initialize(config = {})
      self.pspid = config[:pspid]
      self.sha_in = config[:sha_in]
      self.sha_out = config[:sha_out]
      self.sha_type = config[:sha_type]
      self.test_mode = config[:test_mode]
    end

  end
end
