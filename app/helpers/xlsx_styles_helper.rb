module XlsxStylesHelper
  def xlsx_styles
    {
      h_left:    { alignment: { horizontal: :left } },
      h_center:  { alignment: { horizontal: :center } },
      h_right:   { alignment: { horizontal: :right } },
      v_top:     { alignment: { vertical: :top } },
      v_center:  { alignment: { vertical: :center } },
      v_bottom:  { alignment: { vertical: :bottom } },
      wrap_text: { alignment: { wrap_text: true } }
    }
  end
end
