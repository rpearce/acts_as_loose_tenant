require 'spec_helper'

describe User do
  let(:tenant) { create(:tenant) }
  let(:tenant2) { create(:tenant) }
  let(:user) { create(:user) }

  subject { user }

  before do
    ActsAsTenant.current_tenant = tenant
  end

  describe 'after_create' do
    it 'associates the user with tenant based on current tenant' do
      expect(user.tenants.first).to eq tenant
    end
  end

  describe 'add/remove tenant' do
    before do
      user # creates first user and tenant
      ActsAsTenant.current_tenant = tenant2
      user.add_tenant
    end

    describe '#add_tenant' do
      it 'adds an additional tenant' do
        expect(user.tenants.count).to eq 2
        expect(user.tenants.first).to eq tenant
        expect(user.tenants.last).to eq tenant2
      end
    end

    describe '#remove_tenant' do
      before { ActsAsTenant.current_tenant = tenant }

      it 'removes the current tenant' do
        expect {
          user.remove_tenant 
        }.to change(TenantUser, :count).by(-1)
        expect(user.tenants.first).to eq tenant2
      end
    end
  end
end
