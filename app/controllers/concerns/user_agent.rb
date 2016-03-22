module UserAgent
  extend ActiveSupport::Concern

  def is_mobile?
    browser.device.iphone? || browser.platform.android? || browser.platform.windows_phone?
  end

  def is_tablet?
    browser.device.tablet?
  end
end
