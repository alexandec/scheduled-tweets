require "test_helper"

class PasswordResetsTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @token = @user.signed_id(purpose: "password_reset", expires_in: 15.minutes)
  end

  test "resets password with valid token" do
    patch password_reset_path(token: @token), params: { user: { password: "newpass123", password_confirmation: "newpass123" } }
    assert_redirected_to root_path
    assert @user.reload.authenticate("newpass123")
  end

  test "shows error when passwords don't match" do
    patch password_reset_path(token: @token), params: { user: { password: "newpass123", password_confirmation: "other" } }
    assert_response :unprocessable_entity
    assert_select ".alert-danger li", /doesn't match/
  end

  test "shows error when password is blank" do
    patch password_reset_path(token: @token), params: { user: { password: "", password_confirmation: "" } }
    assert_response :unprocessable_entity
    assert_select ".alert-danger li", /Password can't be blank/
    assert @user.reload.authenticate("password")
  end

  test "rejects invalid token" do
    get password_reset_edit_path(token: "bogus")
    assert_redirected_to root_path
  end
end
