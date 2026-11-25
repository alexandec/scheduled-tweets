require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "shows the sign up form" do
    get sign_up_path
    assert_response :success
  end

  test "creates a user and redirects with valid params" do
    assert_difference("User.count", 1) do
      post sign_up_path, params: { user: {
        email: "new@example.com", password: "password", password_confirmation: "password"
      } }
    end

    assert_redirected_to root_path
    assert_equal "Successfully created account", flash[:notice]
  end

  test "re-renders the form with errors when params are invalid" do
    assert_no_difference("User.count") do
      post sign_up_path, params: { user: {
        email: "not-an-email", password: "password", password_confirmation: "different"
      } }
    end

    assert_response :unprocessable_entity
    assert_select ".alert-danger li", minimum: 1
  end
end
