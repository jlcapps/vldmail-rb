# frozen_string_literal: true

require 'test_helper'

class VldMailTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::VldMail::VERSION
  end

  def test_instantiation
    assert VldMail::Validation.new('foo@example.com').is_a?(VldMail::Validation)
  end
end
