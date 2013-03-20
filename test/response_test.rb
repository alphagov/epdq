require 'test_helper'

class ResponseTest < Test::Unit::TestCase

  setup do
    EPDQ.sha_type = :sha1
    EPDQ.sha_out = "Mysecretsig1875!?"
  end

  test "valid_sha?" do
    query_string = "ACCEPTANCE=1234&AMOUNT=15.00&BRAND=VISA&CARDNO=xxxxxxxxxxxx1111&CURRENCY=EUR&NCERROR=0&ORDERID=12&PAYID=32100123&PM=CreditCard&STATUS=9&SHASIGN=8DC2A769700CA4B3DF87FE8E3B6FD162D6F6A5FA"

    response = EPDQ::Response.new(query_string)
    assert response.valid_shasign?
  end

  test "valid_sha? with mixed case keys" do
    query_string = "ACCEPTANCE=1234&AMOUNT=15.00&brand=VISA&CARDNO=xxxxxxxxxxxx1111&CURRENCY=EUR&ncerror=0&ORDERID=12&PAYID=32100123&PM=CreditCard&STATUS=9&SHASIGN=8DC2A769700CA4B3DF87FE8E3B6FD162D6F6A5FA"

    response = EPDQ::Response.new(query_string)
    assert response.valid_shasign?
  end

  test "parameters" do
    query_string = "ACCEPTANCE=1234&AMOUNT=15.00&BRAND=VISA&CARDNO=xxxxxxxxxxxx1111&CURRENCY=EUR&NCERROR=0&ORDERID=12&PAYID=32100123&PM=CreditCard&STATUS=9&SHASIGN=8DC2A769700CA4B3DF87FE8E3B6FD162D6F6A5FA"

    response = EPDQ::Response.new(query_string)
    parameters = response.parameters

    assert_equal 10, parameters.keys.length
    assert_equal "1234", parameters[:acceptance]
    assert_equal "15.00", parameters[:amount]
    assert_equal "VISA", parameters[:brand]
    assert_equal "xxxxxxxxxxxx1111", parameters[:cardno]
    assert_equal "EUR", parameters[:currency]
    assert_equal "0", parameters[:ncerror]
    assert_equal "12", parameters[:orderid]
    assert_equal "32100123", parameters[:payid]
    assert_equal "CreditCard", parameters[:pm]
    assert_equal "9", parameters[:status]
  end

  test "an account object can be provided to override the defaults" do
    query_string = "ACCEPTANCE=1234&AMOUNT=15.00&BRAND=VISA&CARDNO=xxxxxxxxxxxx1111&CURRENCY=EUR&NCERROR=0&ORDERID=12&PAYID=32100123&PM=CreditCard&STATUS=9&SHASIGN=2DA17DFC1B92327FD6847746DA173B418BDAAC0F"

    account = EPDQ::Account.new( :test_mode => true, :sha_out => "outoutout", :pspid => "AnotherPSPID", :sha_type => :sha1 )

    response = EPDQ::Response.new(query_string, account)
    assert response.valid_shasign?
  end

  test "additional parameter keys can be provided to pass non-sha values in the response" do
    query_string = "ACCEPTANCE=1234&AMOUNT=15.00&BRAND=VISA&CARDNO=xxxxxxxxxxxx1111&CURRENCY=EUR&NCERROR=0&ORDERID=12&PAYID=32100123&PM=CreditCard&STATUS=9&SHASIGN=8DC2A769700CA4B3DF87FE8E3B6FD162D6F6A5FA&order_item_count=4&postage=yes"

    response = EPDQ::Response.new(query_string, nil, ['order_item_count', 'postage', 'another_param_key'])
    parameters = response.parameters

    assert_equal "4", parameters[:order_item_count]
    assert_equal "yes", parameters[:postage]
    assert !parameters.has_key?(:another_param_key)

  end

end
