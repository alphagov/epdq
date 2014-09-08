require 'epdq/request'
require 'epdq/response'

module EPDQ
  attr_accessor :test_mode, :sha_in, :sha_out, :sha_type, :pspid
  extend self
end
