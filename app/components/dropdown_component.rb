class DropdownComponent < ViewComponent::Base
  def initialize(button_text: octicon("three-bars"))
    @button_text = button_text
  end
end
