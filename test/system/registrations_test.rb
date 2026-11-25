require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase
  test "signing up with valid details" do
    visit sign_up_path

    fill_in "Email", with: "new@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create User"

    assert_text "Successfully created account"
  end

  test "signing up with mismatched passwords shows an error" do
    visit sign_up_path

    fill_in "Email", with: "new@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "different"
    click_on "Create User"

    assert_text "Password confirmation doesn't match Password"
  end
end
