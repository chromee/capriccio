class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # def facebook
  #   callback_from :facebook
  # end

  def twitter
    callback_from :twitter
  end

  private

  def callback_from(provider)
    provider = provider.to_s

    @user = User.find_for_oauth(request.env['omniauth.auth'])

    session[:oauth_token] = request.env['omniauth.auth']['credentials']['token']
    session[:oauth_token_secret] = request.env['omniauth.auth']['credentials']['secret']

    flash[:info] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
    sign_in_and_redirect @user, event: :authentication
  end
end
