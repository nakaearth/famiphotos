require 'logstash-logger'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :login?
  before_action :current_user
  before_action :current_group
  before_action :application_log_output

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def current_user
    @current_user ||=  User.includes(:my_groups).find(Base64.decode64(session[:encrypted_user_id])) if session[:encrypted_user_id]
  rescue ActiveRecord::RecordNotFound => ar
    logger.info "ユーザ情報がありません: #{ar.message}"
    session[:user_id] = nil
    nil
  end

  # TODO: グループ切り替えが必要か
  def current_group
    current_user.try(:my_groups).try(:first)
  end

  def login?
    redirect_to :root if session[:encrypted_user_id].blank?
  end

  def application_log_output
    application_log = LogStashLogger.new(type: :file, path: 'log/rails_application.log', sync: true)

    application_log.info({
      "pid": $PROCESS_ID,
      "method": request.request_method,
      "path": request.fullpath,
      "ip": request.remote_ip, "uuid": request.uuid
    })
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404
  end
end
