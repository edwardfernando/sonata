require 'test_helper'

class ScheduleMailerTest < ActionMailer::TestCase
  test "new_schedule_notification" do
    mail = ScheduleMailer.new_schedule_notification
    assert_equal "New schedule notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
