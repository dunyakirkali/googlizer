class AddHitsToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :hits, :integer
  end
end
