module Sortable
  extend ActiveSupport::Concern

  NOT_ALLOWED = %w[
    avatar_data
    encrypted_password
    password
    reset_password_sent_at
    reset_password_token
    unlock_token
	# ...
  ].freeze

  included do
    attribute_names.reject { |name| NOT_ALLOWED.include?(name) }.each do |attr|
      scope(:"order_#{attr}_asc", -> { reorder(attr => :asc) })
      scope(:"order_#{attr}_desc", -> { reorder(attr => :desc) })
    end
  end

  class_methods do
    def order_by(method = nil, direction = nil)
      send :"order_#{method}_#{direction}" if respond_to? "order_#{method}_#{direction}"
    end
  end
end