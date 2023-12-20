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

  def test_message
    SUCCESS_EMAILS.each do |email|
      assert_equal '', VldMail::Validation.new(email).message
    end

    FAILURE_EMAILS.each do |email|
      refute_equal '', VldMail::Validation.new(email).message
    end

    assert_equal 'One @ is more than enough.',
                 VldMail::Validation.new(FAILURE_EMAILS.last).message
  end

  def test_maximum_length
    username = Array.new(64, 'u').join('')
    host = Array.new(255, 'h').join('')
    email = "#{username}@#{host}"
    assert_equal 320, email.length

    validation = VldMail::Validation.new(email)
    assert validation.success?
    assert_equal '', validation.message
  end

  def test_exceeding_maximum_length
    username = Array.new(65, 'u').join('')
    host = Array.new(255, 'h').join('')
    email = "#{username}@#{host}"
    assert_equal 321, email.length

    validation = VldMail::Validation.new(email)
    refute validation.success?
    assert_equal 'Maximum email length is 320.', validation.message
  end

  def test_email_attribute
    email = 'foo@example.com'
    validation = VldMail::Validation.new(email)
    assert_equal email, validation.email
  end
end
