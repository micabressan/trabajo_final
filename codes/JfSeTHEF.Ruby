order_ids = Hash.new 0
ConsolidationBin.all.each do |bin|
  order_ids[bin.order_id] += 1
end
ids = []
order_ids.select{|h,k| ids.push(h) if k > 1}
puts Order.where(id: ids).pluck(:vendor_po)