require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # rack_test runs without a real browser, so no JavaScript (Turbo) runs.
  # We use it because headless Chrome via Selenium was flaky in CI: with
  # Capybara 3.40 and Chrome 158, keystrokes and clicks sometimes went to a
  # document other than the one displayed. Switch back to
  # `driven_by :selenium, using: :headless_chrome` for tests that need JS
  # once a Capybara/Chrome fix is available.
  driven_by :rack_test
end
