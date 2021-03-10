class FileUploadComponent < ViewComponent::Base
  def initialize(form:, model_name:, model_instance:, nested_attributes_name:, max_files:, display_previews_and_destroy: false)
    @form = form
    @model_name = model_name
    @model_instance = model_instance
    @nested_attributes_name = nested_attributes_name
    @max_files = max_files
    @display_previews_and_destroy = display_previews_and_destroy
  end
end
