funz_owner_id_by_funz_id = Funz.joins(:events).inject({}) { |h, funz| h.merge(funz.id => funz.owner_id) }
funz_owner_id_by_funz_id.each do |funz_id, owner_id|
  Event.where(funz_id: funz_id).update_all(owner_id: owner_id)
end