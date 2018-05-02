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
    session[:user_name] = request.env['omniauth.auth']['info']['name']
    session[:user_nickname] = request.env['omniauth.auth']['info']['nickname']

    flash[:info] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
    sign_in_and_redirect @user, event: :authentication
  end
end
