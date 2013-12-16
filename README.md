# ActsAsLooseTenant
[![Code Climate](https://codeclimate.com/github/rpearce/acts_as_loose_tenant.png)](https://codeclimate.com/github/rpearce/acts_as_loose_tenant)

Allow for your models to have multiple tenants. (Note: this does not
acts as a replacement for the [ActsAsTenant gem](https://github.com/ErwinM/acts_as_tenant) -- it merely extends its
functionality).

## Installation instructions
This will be released to RubyGems once it has reached a further point,
so if you want to use it, make sure to include the GitHub repo:

```ruby
# Gemfile

gem 'acts_as_loose_tenant', github: 'git@github.com:rpearce/acts_as_loose_tenant.git'
```

## Why This Exists
[ActsAsTenant](https://github.com/ErwinM/acts_as_tenant) is a great gem for multitenancy. It scopes
queries based on a ```tenant_id``` column which is added to, for
example, a ```users``` table.

Unfortunately, this only allows that table record to have one tenant
when you may want access to multiple tenants. ```ActsAsLooseTenant```
was created to solve this problem.

## Example Usage
Add ```acts_as_loose_tenant(:tenant, :tenant_user)``` to the model you want to have access to multiple
tenants. The arguments you pass establish the models' relationships. In
this case, ```:tenant``` is my Tenant model I want my User model to be
scoped to, and ```:tenant_user``` is the name of the join table that
connects the two together.

```ruby
class User < ActiveRecord::Base
  acts_as_loose_tenant(:tenant, :tenant_user)
end
```

Next, make sure your join table is created and its relationships are set up properly:

### Create Join Model
```
bundle exec rails g model tenant_user user_id:integer tenant_id:integer
```

### Set up relationships
```ruby
class TenantUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :tenant
end

class Tenant < ActiveRecord::Base
  has_many :tenant_users
  has_many :users, through: :tenant_users
end
```

...and that's it!

## Note
Check out the [ActsAsTenant gem](https://github.com/ErwinM/acts_as_tenant) for more information on how to utilize ActsAsTenant.

# ToDo
- Make easier out of the box
  - generator for join table and relationships

- Explicitly declaring the tenant and join table is hacky. Find a way to make this better.

- Optimize queries

