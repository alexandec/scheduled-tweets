require "test_helper"

class UserTest < ActiveSupport::TestCase
  def build_user(email: "new@example.com")
    User.new(email: email, password: "password", password_confirmation: "password")
  end

  test "valid with a well-formed email and password" do
    assert build_user.valid?
  end

  test "requires an email" do
    user = build_user(email: "")
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "rejects malformed emails" do
    [ "plainaddress", "no-at.example.com", "two@@example.com", "has space@example.com", "user@" ].each do |email|
      user = build_user(email: email)
      assert_not user.valid?, "#{email.inspect} should be invalid"
      assert_includes user.errors[:email], "must be a valid email address"
    end
  end

  test "normalizes email by stripping whitespace and downcasing" do
    assert_equal "new@example.com", build_user(email: "  NEW@Example.COM ").email
  end

  test "requires a unique email, ignoring case" do
    user = build_user(email: users(:one).email.upcase)
    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  test "authenticates with the correct password" do
    assert users(:one).authenticate("password")
    assert_not users(:one).authenticate("wrong")
  end
end
