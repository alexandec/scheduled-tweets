Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
    Rails.application.credentials.dig(:twitter, :api_key),
    Rails.application.credentials.dig(:twitter, :api_secret)
end

# Twitter API access is no longer free, so in development we skip the real
# OAuth flow. Visiting /auth/twitter redirects straight to the callback with
# this fake auth hash in request.env["omniauth.auth"].
if Rails.env.development?
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
    provider: "twitter",
    uid: "123456",
    info: {
      name: "Fake Tweeter",
      nickname: "fake_tweeter",
      image: "https://placehold.co/48x48"
    },
    credentials: {
      token: "fake_token",
      secret: "fake_secret"
    }
  )
end
