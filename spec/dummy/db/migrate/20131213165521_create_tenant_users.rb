class CreateTenantUsers < ActiveRecord::Migration
  def change
    create_table :tenant_users do |t|
      t.integer :user_id
      t.integer :tenant_id

      t.timestamps
    end
  end
end
