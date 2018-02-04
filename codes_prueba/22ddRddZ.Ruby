  validates :first_name, :last_name, presence: true, length: { minimum: 2 }
  validates_each :first_name, :last_name do  |rec, attr, value|
    rec.errors.add(attr, "Must start with capital letter") if value =~ /\A[a-z]/
  end

  validates :password, :password_confirmation,
            presence: true, length: { minimum: 3 }, on: :create
  validates :password, confirmation: true
  validates :email, presence: true, uniqueness: true,
                    format: {
                      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
                    }
  validates :phone, presence: true
  validates :address, presence: true