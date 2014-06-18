require 'test_helper'

class PersonApprovedMailerTest < ActionMailer::TestCase
  test "approved" do
    mail = PersonApprovedMailer.approved
    assert_equal "Approved", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
