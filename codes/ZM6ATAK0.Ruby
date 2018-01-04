extract building from sources
  #call
    should create building (FAILED - 1)
    should not create duplications (FAILED - 2)

Failures:

  1) extract building from sources #call should create building
     Failure/Error: expect(Building.first.sources.pluck(:id)).to eq [source.id, another_source.id]
     
       expected: [1, 2]
            got: [2, 1]
     
       (compared using ==)
     # ./spec/lib/export_helpers/extract_building_from_source_spec.rb:17:in `block (3 levels) in <top (required)>'
     # /home/how/.rvm/gems/ruby-2.4.1@home_easy/gems/spring-commands-rspec-1.0.4/lib/spring/commands/rspec.rb:18:in `call'
     # -e:1:in `<main>'

  2) extract building from sources #call should not create duplications
     Failure/Error: expect(Building.first.sources.pluck(:id)).to eq [source.id, another_source.id]
     
       expected: [1, 2]
            got: [2, 1]
     
       (compared using ==)
     # ./spec/lib/export_helpers/extract_building_from_source_spec.rb:23:in `block (3 levels) in <top (required)>'
     # /home/how/.rvm/gems/ruby-2.4.1@home_easy/gems/spring-commands-rspec-1.0.4/lib/spring/commands/rspec.rb:18:in `call'
     # -e:1:in `<main>'

Finished in 8.13 seconds (files took 0.37495 seconds to load)
2 examples, 2 failures