class Models::A < ActiveRecord::Base 
  self.include_root_in_json = false

end

class Models::B < ActiveRecord::Base 

end

Models::B.include_root_in_json => true
Models::A.include_root_in_json => false

# why is it false now? it used to be true above
Models::B.include_root_in_json => false