module Admin
  class AutocompletePackageItemDescriptionsController < AdminController
    def index
      @descriptions = AdminAutocompletePackageItemDescription.all
    end

    def create
      @description = AdminAutocompletePackageItemDescription.new(value: params[:value])
      if @description.save
        respond_to do |format|
          format.js
        end
      else
        head :created
      end
    end

    def destroy
      @description = AdminAutocompletePackageItemDescription.find(params[:id])
      @description.destroy
      respond_to do |format|
        format.js
      end
    end
  end
end
