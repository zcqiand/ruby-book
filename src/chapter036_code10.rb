begin
  product.save!
rescue ActiveRecord::StaleObjectError
  product.reload
  product.name = params[:name]
  retry
end