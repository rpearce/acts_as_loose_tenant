class User < ActiveRecord::Base
  acts_as_loose_tenant(:tenant, :tenant_user)
end
