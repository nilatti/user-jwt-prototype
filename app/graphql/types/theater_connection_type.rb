module Types
  class TheaterConnectionType < Types::BaseObject
    field :total_count, Integer, null: true

    def total_count
      puts "total called"
      object.items.size
    end
  end
end
