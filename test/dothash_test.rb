require "test_helper"
require "dothash"

class DothashTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Dothash::VERSION
  end
end
