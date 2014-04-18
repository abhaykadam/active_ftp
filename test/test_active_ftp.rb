require 'test/unit'
require 'active_ftp'

class ActiveFtpTest < Test::Unit::TestCase
  def test_active_ftp_instance
    assert_not_nil ActiveFtp.new
  end
end
