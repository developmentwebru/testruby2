# frozen_string_literal: true
#
# Uncomment this and change the path if necessary to include your own
# components.
# See https://github.com/plataformatec/simple_form#custom-components to know
# more about custom components.
# Dir[Rails.root.join('lib/components/**/*.rb')].each { |f| require f }
#
# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a
  # complete input. You can remove any component from the
  # wrapper, change the order or even add your own to the
  # stack. The options given below are used to wrap the
  # whole input.
  config.wrappers :bootstrap_form do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.use :min_max
    b.optional :readonly
    b.use :label
    b.use :input, class: 'form-control'
    b.use :hint,  wrap_with: { tag: :small, class: 'text-muted' }
    b.use :full_error, wrap_with: { tag: :small, class: 'text-danger' }
  end

  # config.wrappers :vertical_boolean, tag: 'div', class: 'mb3' do |b|
  #   b.use :html5
  #   b.optional :readonly
  #   b.wrapper tag: 'div', class: 'flex items-center mb2' do |bb|
  #     bb.use :input, class: 'mr2'
  #     bb.use :label, class: 'lh-copy'
  #   end
  #   b.use :full_error, wrap_with: { tag: 'small', class: 'f6 dark-red db mb2' }
  #   b.use :hint, wrap_with: { tag: 'small', class: 'f6 black-60 db mb2' }
  # end

  config.wrappers :form, tag: "div" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.use :min_max
    b.optional :readonly
    b.wrapper tag: "div", class: "mb-3" do |bb|
      bb.use :label, class: "block text-els-black font-semibold mb-1"
      bb.use :input, class: "form-field"
      bb.use :hint,  wrap_with: { tag: :div, class: "text-xs text-grey-darker mt-1" }
      bb.use :full_error, wrap_with: { tag: :div, class: "text-xs text-red mt-1" }
    end
  end

  # Define the way to render check boxes / radio buttons with labels.
  # Defaults to :nested for bootstrap config.
  #   inline: input + label
  #   nested: label > input
  config.boolean_style = :inline

  # Default class for buttons
  config.button_class = 'btn btn-primary'

  # Method used to tidy up errors. Specify any Rails Array method.
  # :first lists the first message for each field.
  # Use :to_sentence to list all errors for each field.
  # config.error_method = :first

  # How the label text should be generated altogether with the required text.
  config.label_text = lambda { |label, required, explicit_label| "#{label} #{required}" }

  # Tell browsers whether to use the native HTML5 validations (novalidate form option).
  # These validations are enabled in SimpleForm's internal config but disabled by default
  # in this configuration, which is recommended due to some quirks from different browsers.
  # To stop SimpleForm from generating the novalidate option, enabling the HTML5 validations,
  # change this configuration to true.
  config.browser_validations = false

  # Custom mappings for input types. This should be a hash containing a regexp
  # to match as key, and the input type that will be used when the field name
  # matches the regexp as value.
  # config.input_mappings = { /count/ => :integer }
  config.input_mappings = { /country/ => :string }

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :bootstrap_form

  # config.wrapper_mappings = {
  #   boolean: :vertical_boolean
  # }
end
