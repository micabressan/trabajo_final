    DB.create_table :users do
      primary_key :id
      String :username ,:size=>20 ,:unique=>true
      String :password 
      String :name
      String :surname
      String :email,:unique=>true
      foreign_key :role_id
      Date :date 
    end

  DB.create_table :roles do
    primary_key :id
    String :name
  end



class Role < Sequel::Model
    plugin :json_serializer
    many_to_one :users
  end

class User < Sequel::Model
    plugin :json_serializer
    one_to_many :roles
  end


role=Role.create(:name=>'ADMIN')
user=User.create(:username=>'test',:email=>'test')
user.add_roles(role)