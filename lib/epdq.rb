require 'epdq/account'
require 'epdq/request'
require 'epdq/response'

module EPDQ

  def self.accounts
    @@accounts ||= { }
  end

  def self.accounts=(accounts)
    @@accounts = accounts
  end

  def self.default_account
    self.accounts[:default] ||= EPDQ::Account.new
  end

  def self.default_account=(account)
    self.accounts[:default] = account
  end

  def self.test_mode=(test_mode)
    self.default_account.test_mode = !!test_mode
  end

  def self.test_mode
    self.default_account.test_mode
  end

  def self.sha_in=(sha_in)
    self.default_account.sha_in = sha_in
  end

  def self.sha_in
    self.default_account.sha_in
  end

  def self.sha_out=(sha_out)
    self.default_account.sha_out = sha_out
  end

  def self.sha_out
    self.default_account.sha_out
  end

  def self.sha_type=(sha_type)
    self.default_account.sha_type = sha_type
  end

  def self.sha_type
    self.default_account.sha_type
  end

  def self.pspid=(pspid)
    self.default_account.pspid = pspid
  end

  def self.pspid
    self.default_account.pspid
  end

end
