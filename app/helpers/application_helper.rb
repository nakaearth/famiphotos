# frozen_string_literal: true
module ApplicationHelper
  def famiphoto_url
    return "http://#{request.host}:#{request.port}/" if Rails.env.development?

    "https://#{request.host}/"
  end
end
