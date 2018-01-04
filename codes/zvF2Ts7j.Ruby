csv_str = CSV.generate do |csv|
  csv << ['Funz ID', 'Funz name', 'Is Host?', 'Category', 'N. of paid orders', 'N. of tickets sold', 'Nearest date', 'N. of upcoming dates', 'Published?', 'Approved?'] + (1..5).map { |i| "Interest #{i}" }
  Funz.by_site(3).each do |funz|
    funz_orders = funz.orders.confirmed.with_money_or_gift_card
    csv << [funz.id, funz.title, funz.owner.funzing_host, funz.category.name, funz_orders.size, funz_orders.map(&:total_tickets).sum, funz.next_event.try(:scheduled_on_date), funz.number_of_upcoming_events, funz.published?, funz.approved?, *funz.interests.map(&:key)]
  end
end
ReportsMailer.send_csv_to_emails(['rotem@funzing.com'], 'January Marketing Campaign Report', 'JanuaryMarketingCampaignReport.csv', csv_str).deliver_now