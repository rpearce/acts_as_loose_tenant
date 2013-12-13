class Tenant < ActiveRecord::Base
  has_many :tenant_users
  has_many :users, through: :tenant_users
end
