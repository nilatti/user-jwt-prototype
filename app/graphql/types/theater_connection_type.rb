module Types
  class TheaterConnectionType < Types::BaseObject
    field :total_count, Integer, null: true
    field :theater, Types::TheaterType, null: true

    def total_count
      object.items.size
    end
  end
end
