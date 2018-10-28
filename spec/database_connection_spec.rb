require 'database_connection'
require 'database_connection_setup'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to a test database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'chitter_test')
      DatabaseConnection.setup('chitter_test')
    end

    it 'this connection is persistent' do
      connection = DatabaseConnection.setup('chitter_test')
      expect(DatabaseConnection.connection).to eq connection
    end
  end

  describe '.query' do
    it 'executes a query via PG' do
      connection = DatabaseConnection.setup('chitter_test')
      expect(connection).to receive(:exec).with("SELECT * FROM bookmarks")
      DatabaseConnection.query("SELECT * FROM bookmarks")
    end
  end
end
