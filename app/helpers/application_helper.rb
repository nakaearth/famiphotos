module ApplicationHelper
  # link_to の実装を参考にしている
  # http://apidock.com/rails/ActionView/Helpers/UrlHelper/link_to
  def link_to_remote(name = nil, options = {}, html_options = {}, &block)
    html_options, options, name = options, name, block if block_given?

    html_options[:remote]       = true
    html_options[:disable_with] ||= name

    if block_given?
      link_to options, html_options, &block
    else
      link_to name, options, html_options
    end
  end

  def link_to_remote_modal(name = nil, options = {}, html_options = {}, &block)
    html_options, options = options, html_options if block_given?

    html_options[:class]  = "#{html_options[:class]} #{PA_JS_CLASSES[:plugins][:show_remote_modal]}"
    html_options[:data] ||= {}
    html_options[:data][:type] = :html

    html_options, options = options, html_options if block_given?
    link_to_remote(name, options, html_options, &block)
  end
end
