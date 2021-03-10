class ValidationErrorsComponent < ViewComponent::Base
  def initialize(errors:)
    @errors = errors
  end
end
