require "test_helper"

class PasswordMailerTest < ActionMailer::TestCase
  test "reset" do
    user = users(:one)
    mail = PasswordMailer.with(user: user).reset
    assert_equal "Reset your password", mail.subject
    assert_equal [ user.email ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi #{user.email}", mail.body.encoded
    assert_match "/password/reset/edit?token=", mail.body.encoded
  end
end
