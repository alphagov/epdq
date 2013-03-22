require 'test_helper'

class AccountTest < Test::Unit::TestCase

  teardown do
    EPDQ.default_account = nil
  end

  test "an account can be created with configuration" do
    account = EPDQ::Account.new(
      :pspid => "MyPSPID",
      :sha_in => "Mysecretsig1875!?",
      :sha_out => "Theirsecretsig5781!?",
      :sha_type => :sha1,
      :test_mode => false
    )
    assert_equal "MyPSPID", account.pspid
    assert_equal "Mysecretsig1875!?", account.sha_in
    assert_equal "Theirsecretsig5781!?", account.sha_out
    assert_equal :sha1, account.sha_type
    assert_false account.test_mode
  end

  test "a default account gets initialized for the module" do
    assert_not_nil EPDQ.default_account
    assert EPDQ.default_account.is_a?(EPDQ::Account)
  end

  test "setters on the module delegate to the default account" do
    EPDQ.pspid = "testing"
    EPDQ.sha_in = "in"
    EPDQ.sha_out = "out"
    EPDQ.sha_type = :sha1
    EPDQ.test_mode = true

    assert_equal "testing", EPDQ.default_account.pspid
    assert_equal "in", EPDQ.default_account.sha_in
    assert_equal "out", EPDQ.default_account.sha_out
    assert_equal :sha1, EPDQ.default_account.sha_type
    assert_true EPDQ.default_account.test_mode
  end

  test "getters on the module delegate to the default account" do
    EPDQ.default_account.pspid = "testing"
    EPDQ.default_account.sha_in = "in"
    EPDQ.default_account.sha_out = "out"
    EPDQ.default_account.sha_type = :sha1
    EPDQ.default_account.test_mode = true

    assert_equal "testing", EPDQ.pspid
    assert_equal "in", EPDQ.sha_in
    assert_equal "out", EPDQ.sha_out
    assert_equal :sha1, EPDQ.sha_type
    assert_true EPDQ.test_mode
  end

end
