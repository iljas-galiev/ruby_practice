configure { set :server, :puma }
class Db
  @@conn = PG.connect(dbname: 'sinatra', host: 'localhost', user: 'postgres', password: 'ghbjhf756')

  def self.conn
    @@conn
  end
end

$db = Db.conn