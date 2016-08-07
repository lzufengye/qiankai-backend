module ActiveAdmin::Views::Pages::BaseExtension
  def add_classes_to_body
    super
    @body.set_attribute "data-controller", params[:controller].gsub(/^admin\//, '')
    @body.set_attribute "data-action",     params[:action]
  end
end
class ActiveAdmin::Views::Pages::Base
  # mixes in the module directly below the class
  prepend ActiveAdmin::Views::Pages::BaseExtension
end