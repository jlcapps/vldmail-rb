# frozen_string_literal: true

require 'test_helper'

class VldMailTest < Minitest::Test
  # test cases derived from libvldmail autotest-cases
  SUCCESS_EMAILS =     [
    '" "@provider.tld',
    '"very.(),:;<>[]\".VERY.\"very@\\ \"very\".unusual"@strange.example.com',
    'foo@[192.168.0.1]',
    'foo@[IPv6:::1]',
    'foo@bar.quux',
    'hügo@müller.berlin',
    '🎃@emojiguy'
   ]
  FAILURE_EMAILS = ['admin@localhost', 'foo@bar.quux@quux']

  def test_that_it_has_a_version_number
    refute_nil ::VldMail::VERSION
  end

  def test_instantiation
    assert VldMail::Validation.new('foo@example.com').is_a?(VldMail::Validation)
  end

  def test_success_returns_true
    SUCCESS_EMAILS.each do |email|
      assert VldMail::Validation.new(email).success?
    end
  end

  def test_success_returns_false
    FAILURE_EMAILS.each do |email|
      assert_equal false, VldMail::Validation.new(email).success?
    end
  end
end
