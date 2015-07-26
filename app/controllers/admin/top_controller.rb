module Admin
  class TopController < Admin::ApplicationController
    skip_before_action :login?
    skip_before_action :current_user

    # トップ画面
    def index
    end
  end
end
