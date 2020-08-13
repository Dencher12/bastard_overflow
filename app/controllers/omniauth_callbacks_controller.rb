class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
        @user = User.find_for_oauth(request.env['omniauth.auth'])
        if @user.persisted?
            sign_in @user
            redirect_to welcome_index_path 
            set_flash_message(:notice, :success, kind: 'Github')
        end    
    end    
end    