boolean_attrs = { :city_id => 20,
                  :road_id => 10,
                  :town_id => 5,
                  :cottage_town_id => 5,
                  :type_id => 10 }

value_attrs = { :building_area => 50,
                :land_area => 50 }

[ :landscape, :foundation, :wall_material, :flooring, :roofing,
  :decoration, :furniture, :gas, :water_supply, :ductwork ].each do |key|
  boolean_attrs.merge!(key => 2)
end