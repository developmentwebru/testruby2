class AutocompleteComponent < ViewComponent::Base
  def initialize(form_object:, input_name:, url:, stimulus_targets: "")
    @form_object = form_object
    @input_name = input_name
    @url = url
    @stimulus_targets = stimulus_targets
  end
end
