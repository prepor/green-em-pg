green-em-pg
===========

Simple wrapper around [em-pg](https://github.com/prepor/em-pg) for [Green](https://github.com/prepor/green). And [Sequel](http://sequel.rubyforge.org/) adapter.

Usage
-----

```ruby
gem "green-em-pg"
```

```ruby
require "green-em/pg"

db = Green::EM::PG.new host: "localhost",
  port: 5432,
  dbname: "test",
  user: "postgres",
  password: "postgres"
  
res = db.send_qeury "select * from test"

puts res.inspect
```

Sequel
------

```ruby
require "green-em/pg/sequal"
url = "postgres://postgres:postgres@localhost:5432/test"
db = Sequel.connect(url, pool_class: Green::EM::PG::Sequel::ConnectionPool)

puts db[:test].all.inspect
```
