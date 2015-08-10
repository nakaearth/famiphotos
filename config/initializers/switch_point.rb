SwitchPoint.configure do |config|
  if Rails.env.test?
    config.define_switch_point :famiphoto,
      readonly: :"famiphoto_#{Rails.env}",
      writable: :"famiphoto_#{Rails.env}"
  end

  unless Rails.env.test?
    config.define_switch_point :famiphoto, 
      readonly: :"famiphoto_master_#{Rails.env}", 
      writable: :"famiphoto_slave_#{Rails.env}"
  end
end
