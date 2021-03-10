module Admin
  class AutocompleteController < AdminController
    def find_user
      @user = User.find_by_id(params[:id])&.profile
      render json: @user
    end

    def first_name
      first_name = params[:q]
      first_name = first_name.downcase
      users = Profile.where("lower(first_name) LIKE ?", "#{first_name}%")
      guests = Guest.where("lower(first_name) LIKE ?", "#{first_name}%")
      results = pluck_attr(users, :first_name) | pluck_attr(guests, :first_name)
      @data = results.take(10)

      render :autocomplete, layout: false
    end

    def last_name
      last_name = params[:q]
      last_name = last_name.downcase
      users = Profile.where("lower(last_name) LIKE ?", "#{last_name}%")
      guests = Guest.where("lower(last_name) LIKE ?", "#{last_name}%")
      results = pluck_attr(users, :last_name) | pluck_attr(guests, :last_name)
      @data = results.take(10)

      render :autocomplete, layout: false
    end

    def package_description
      query = params[:q]
      query = query.downcase
      @package_item_descriptions = AdminAutocompletePackageItemDescription.where("lower(value) LIKE ?", "#{query}%")
      results = pluck_attr(@package_item_descriptions, :value)
      @data = results.take(10)

      render :autocomplete, layout: false
    end

    private
      def pluck_attr(records, attr)
        records.order(attr).distinct.pluck(attr)
      end
  end
end
