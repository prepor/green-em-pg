require 'spec_helper'
require 'green-em/pg/sequel'
require 'green/group'

describe Green::EM::PG do
  DELAY = 1
  QUERY = "select pg_sleep(#{DELAY})"


  let(:url) { DB_URL }
  let(:size) { 1 }
  let(:db) { Sequel.connect(url, max_connection: size, pool_class: Green::EM::PG::Sequel::ConnectionPool, db_logger: Logger.new(nil)) }
  let(:test) { db[:test] }

  describe "unexist table" do
    it "should raise exception" do
      proc { test.all }.must_raise Sequel::DatabaseError
    end
  end

  describe "exist table" do
    before do
      db.create_table!(:test) do
        text :name
        integer :value, index: true
      end
    end

    after do
      db.drop_table?(:test)
    end

    it "should connect and execute query" do
      test.insert name: "andrew", value: 42
      test.where(name: "andrew").first[:value].must_equal 42
    end


    describe "pool size is exceeded" do
      let(:size) { 1 }
      it "should queue requests" do
        start = Time.now.to_f

        g = Green::Group.new
        res = []
        g.spawn { res << db[QUERY].all }
        g.spawn { res << db[QUERY].all }
        g.join
        (Time.now.to_f - start.to_f).must_be_within_delta DELAY * 2, DELAY * 2 * 0.15
        res.size.must_equal 2
      end
    end

    describe "pool size is enough" do
      let(:size) { 2 }
      it "should parallel requests" do
        start = Time.now.to_f

        g = Green::Group.new
        res = []
        g.spawn { res << db[QUERY].all }
        g.spawn { res << db[QUERY].all }
        g.join

        (Time.now.to_f - start.to_f).must_be_within_delta DELAY, DELAY * 0.30
        res.size.must_equal 2
      end
    end
  end
end
