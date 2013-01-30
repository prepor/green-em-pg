spec = Gem::Specification.new do |s|
  s.name = 'green-em-pg'
  s.version = '0.1.1'
  s.date = '2013-01-30'
  s.summary = 'Async PostgreSQL client API for Ruby/EventMachine'
  s.email = "ceo@prepor.ru"
  s.homepage = "http://github.com/prepor/em-postgres"
  s.description = 'Async PostgreSQL client API for Ruby/EventMachine'
  s.has_rdoc = false
  s.authors = ["Andrew Rudenko"]
  s.add_dependency('eventmachine', '>= 0.12')
  s.add_dependency('pg', '>= 0.14')
  s.add_dependency('green', '>= 0.1.1')
  s.add_dependency('em-pg', '>= 0.1')

  # = MANIFEST =
  s.files = %w[
    Gemfile
    Gemfile.lock
    README.md
    Rakefile
    green-em-pg.gemspec
    lib/green-em/pg.rb
    lib/green-em/pg/sequel.rb
    spec/green-em/pg/sequel_spec.rb
    spec/green-em/pg_spec.rb
    spec/spec_helper.rb
  ]
  # = MANIFEST =
end
