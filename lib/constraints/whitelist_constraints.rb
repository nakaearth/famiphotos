class WhitelistConstraints
  IP_LIST = %w(127.0.0.1)

  def initialize
    @ip_logger = Logger.new("log/ip_logger_#{Rails.env}.log") 
  end

  def self.matches?(request)
    @ip_logger.info request.remote_ip
    IP_LIST.inculde?(request.remote_ip)
  end
end
