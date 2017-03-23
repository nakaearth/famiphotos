SwitchPoint.configure do |config|
  if Rails.env.test?
    config.define_switch_point :famiphoto,
      readonly: :"famiphotos_slave_#{Rails.env}",
      writable: :"famiphotos_master_#{Rails.env}"
    config.auto_writable =  true
  end

  unless Rails.env.test?
    config.define_switch_point :famiphoto,
      readonly: :"famiphotos_slave_#{Rails.env}",
      writable: :"famiphotos_master_#{Rails.env}"
    config.auto_writable =  true
  end
end
