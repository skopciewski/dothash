require "test_helper"
require "dothash/hash"

class HashTest < Minitest::Test
  def test_only_hash_param_allowed
    assert_raises ArgumentError do
      Dothash::Hash.with_dots("foo")
    end
  end

  def test_simple_hash_to_dots
    hash = { x: 1, "y" => "a" }
    expected = { "x" => 1, "y" => "a" }
    assert_equal expected, Dothash::Hash.with_dots(hash)
  end

  def test_nested_simple_values_to_dots
    hash = { x: { y: 1, z: 2 } }
    expected = { "x.y" => 1, "x.z" => 2 }
    assert_equal expected, Dothash::Hash.with_dots(hash)
  end

  def test_nested_more_complicated_values_to_dots
    hash = { x: { y: 1, z: { a1: 8, a2: 10 } }, v: "foo" }
    expected = { "x.y" => 1, "x.z.a1" => 8, "x.z.a2" => 10, "v" => "foo" }
    assert_equal expected, Dothash::Hash.with_dots(hash)
  end

  def test_convert_arrays_to_dots
    hash = { x: [1, { y: 2, z: 3 }] }
    expected = { "x.0" => 1, "x.1.y" => 2, "x.1.z" => 3 }
    assert_equal expected, Dothash::Hash.with_dots(hash)
  end

  def test_hash_to_hash
    dots = { :x => 1, "y" => "a" }
    expected = { x: 1, y: "a" }
    assert_equal expected, Dothash::Hash.without_dots(dots)
  end

  def test_simple_dots_to_hash
    dots = { "x" => 1, "y" => "a" }
    expected = { x: 1, y: "a" }
    assert_equal expected, Dothash::Hash.without_dots(dots)
  end

  def test_nested_simple_dots_to_hash
    dots = { "x.y" => 1, "x.z" => 2 }
    expected = { x: { y: 1, z: 2 } }
    assert_equal expected, Dothash::Hash.without_dots(dots)
  end

  def test_nested_more_complicated_dots_to_hash
    dots = { "x.y" => 1, "x.z.a1" => 8, "x.z.a2" => 10, "v" => "foo" }
    expected = { x: { y: 1, z: { a1: 8, a2: 10 } }, v: "foo" }
    assert_equal expected, Dothash::Hash.without_dots(dots)
  end

  def test_convert_dots_with_arrays
    dots = { "x.0" => 1, "x.1.y" => 2, "x.1.z" => 3 }
    expected = { x: { :"0" => 1, :"1" => { y: 2, z: 3 } } }
    assert_equal expected, Dothash::Hash.without_dots(dots)
  end
end
