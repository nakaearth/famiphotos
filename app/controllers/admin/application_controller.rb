# frozen_string_literal: true
module Admin
  class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_action :login?
    before_action :current_user
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404

    def current_user
      @current_user ||= User.find(Base64.decode64(session[:encrypted_user_id])) if session[:encrypted_user_id]
    rescue ActiveRecord::RecordNotFound => ar
      logger.info "ユーザ情報がありません: #{ar.message}"
      session[:user_id] = nil
      nil
    end

    def login?
      redirect_to :admin if session[:encrypted_user_id].blank?
    end

    def render_404
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end
end
