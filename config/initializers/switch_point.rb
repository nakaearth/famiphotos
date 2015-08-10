SwitchPoint.configure do |config|
  config.define_switch_point :famiphoto,
    readonly: :"#{Rails.env}_famiphoto",
    writable: :"#{Rails.env}_famiphoto"
end
