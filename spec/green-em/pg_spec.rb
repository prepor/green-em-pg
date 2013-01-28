require 'spec_helper'

describe Green::EM::PG do
  let(:db) { Green::EM::PG.new DB_CONFIG }
  it "should execute query" do
    res = db.send_query "select 1;"
    res.first["?column?"].must_equal "1"
  end
end
