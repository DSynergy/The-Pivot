require 'minitest/autorun'
require 'minitest/pride'
require_relative 'allergens'

class AllergensTest < Minitest::Test
    def test_allergic_to_peanuts
      allergy = Allergy.new(2)
      assert_equal "peanuts", allergy.parse
    end

    def test_allergic_to_eggs_and_peanuts
      allergy = Allergy.new(3)
      assert_equal ["eggs", "peanuts"], allergy.parse
    end
end
