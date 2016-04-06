irb(main):001:0> require "stripe"
=> false
irb(main):002:0> Stripe.api_key = "sk_test_no_youdont"
=> "sk_test_no_youdont"
irb(main):003:0> customer = Stripe::Customer.retrieve("cus_customer_id")
=> #<Stripe::Customer:0x3f9e4eee7bc8 id=cus_customer_id> JSON: {
  "id": "cus_customer_id",
  "deleted": true
}
irb(main):004:0> customer.sources.create(:source => "tok_valid_token")
NoMethodError: undefined method `sources' for #<Stripe::Customer:0x007f3c9ddcf790>
	from /usr/local/bundle/gems/stripe-1.24.0/lib/stripe/stripe_object.rb:241:in `method_missing'
	from (irb):4
	from /usr/local/bundle/gems/railties-4.2.3/lib/rails/commands/console.rb:110:in `start'
	from /usr/local/bundle/gems/railties-4.2.3/lib/rails/commands/console.rb:9:in `start'
	from /usr/local/bundle/gems/railties-4.2.3/lib/rails/commands/commands_tasks.rb:68:in `console'
	from /usr/local/bundle/gems/railties-4.2.3/lib/rails/commands/commands_tasks.rb:39:in `run_command!'
	from /usr/local/bundle/gems/railties-4.2.3/lib/rails/commands.rb:17:in `<top (required)>'
	from /usr/local/bundle/gems/activesupport-4.2.3/lib/active_support/dependencies.rb:274:in `require'
	from /usr/local/bundle/gems/activesupport-4.2.3/lib/active_support/dependencies.rb:274:in `block in require'
	from /usr/local/bundle/gems/activesupport-4.2.3/lib/active_support/dependencies.rb:240:in `load_dependency'
	from /usr/local/bundle/gems/activesupport-4.2.3/lib/active_support/dependencies.rb:274:in `require'
	from /myapp/bin/rails:8:in `<top (required)>'
	from /usr/local/bundle/gems/activesupport-4.2.3/lib/active_support/dependencies.rb:268:in `load'
	from /usr/local/bundle/gems/activesupport-4.2.3/lib/active_support/dependencies.rb:268:in `block in load'
	from /usr/local/bundle/gems/activesupport-4.2.3/lib/active_support/dependencies.rb:240:in `load_dependency'
	from /usr/local/bundle/gems/activesupport-4.2.3/lib/active_support/dependencies.rb:268:in `load'
	from /usr/local/lib/ruby/site_ruby/2.0.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from /usr/local/lib/ruby/site_ruby/2.0.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from -e:1:in `<main>'irb(main):005:0>