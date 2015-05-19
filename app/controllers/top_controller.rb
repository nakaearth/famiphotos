class TopController < ApplicationController
  skip_before_action :login?

  # トップ画面
  def index
  end
end
