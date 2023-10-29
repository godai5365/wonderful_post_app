class ApplicationController < ActionController::Base
    # CSRF対策をoffにする
    protect_from_forgery with: :null_session

    # before_action :authenticate_user!
end
