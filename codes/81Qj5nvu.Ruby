if grouped_sales[generic_id].present?
  sales_matrix = prepare_sales_matrix(generic_id: generic_id, start_quantity: start_quantity, start_amount: start_amount)
  sales_matrix_no_taxes = prepare_sales_matrix(generic_id: generic_id, start_quantity: start_quantity, start_amount: distribution_amount_start)
  sales_matrix[generic_id].each_with_index do |sale, index|
  init_year_cost = sale[:total_cost]
  sale_end_price = sale[:amount] / sale[:quantity]
  if asset[:bono]
    sale_end_price = sale_end_price * 2
  end
  sale_end_price = converter.transformer(@convert_um, asset[:iso].to_sym, sale_end_price, sale[:date])
  utility_no_taxes = sales_matrix_no_taxes[generic_id][index][:utility]
  @output << ["No", asset[:name], asset[:nemo], "Utilidad/Pérdida Realizada", sale[:date], utility_no_taxes, 0, sale[:utility],  utility_no_taxes - sale[:utility], "", "", sale[:quantity], sale[:amount], init_year_cost, sale_end_price, " ", " ", " ", sale[:comment], asset[:asset_attributes], sale[:level_names] ].flatten if sale[:utility] != 0
  end
end