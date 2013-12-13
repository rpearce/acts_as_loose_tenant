module ActsAsLooseTenant
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def pluralize_symbol symbol
      symbol.to_s.pluralize.to_sym
    end

    def acts_as_loose_tenant association, joiner
      associations = pluralize_symbol(association)
      association_key = :"#{association.to_s}_id"
      joiners = pluralize_symbol(joiner)

      has_many joiners
      has_many associations, through: joiners

      after_create :"add_#{association.to_s}"

      default_scope lambda {
        includes(associations).where(associations => { id: ActsAsTenant.current_tenant.id }) if ActsAsTenant.current_tenant.present?
      }

      define_method "add_#{association.to_s}" do
        send(joiners).create(association_key => ActsAsTenant.current_tenant.id) if ActsAsTenant.current_tenant.present?
      end

      define_method "remove_#{association.to_s}" do
        send(joiners).where(association_key => ActsAsTenant.current_tenant.id).first.destroy if ActsAsTenant.current_tenant.present?
      end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsLooseTenant
