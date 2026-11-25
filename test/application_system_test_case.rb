require "test_helper"

# Workaround: Capybara 3.40 clears browser storage between tests with
# Storage.clearDataForOrigin(origin: "*"), which recent Chrome versions reject
# ("* is not a valid URL"). Skip that single call; cookies and storage are
# still cleared by Capybara's other reset steps. Remove once Capybara fixes it.
module SkipWildcardStorageClear
  def execute_cdp(cmd, **params)
    return if cmd == "Storage.clearDataForOrigin" && params[:origin] == "*"

    super
  end
end
Capybara::Selenium::Driver::ChromeDriver.prepend(SkipWildcardStorageClear)

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
end
