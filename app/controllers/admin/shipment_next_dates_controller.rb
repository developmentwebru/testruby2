module Admin
  class ShipmentNextDatesController < AdminController
    before_action -> { @shipment_next_date = ShipmentNextDate.first }

    def update
      if @shipment_next_date.update(shipment_next_date_params)
        redirect_to admin_root_path, notice: t(".notice")
      else
        render :edit
      end
    end

    private
      def shipment_next_date_params
        params.permit(:date)
      end
  end
end
