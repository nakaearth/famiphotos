SwitchPoint.configure do |config|
  #if Rails.env.test?
  #  config.define_switch_point :famiphoto,
  #    readonly: :"famiphotos_#{Rails.env}",
  #    writable: :"famiphotos_#{Rails.env}"
  #end

  unless Rails.env.test?
    config.define_switch_point :famiphotos, 
      readonly: :"famiphotos_master_#{Rails.env}", 
      writable: :"famiphotos_slave_#{Rails.env}"
  end
end
