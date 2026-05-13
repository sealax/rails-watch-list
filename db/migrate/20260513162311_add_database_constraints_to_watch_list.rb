class AddDatabaseConstraintsToWatchList < ActiveRecord::Migration[8.1]
  def change
    change_column_null :lists, :name, false
    change_column_null :movies, :title, false
    change_column_null :movies, :overview, false
    change_column_null :bookmarks, :comment, false

    add_index :lists, :name, unique: true
    add_index :movies, :title, unique: true
    add_index :bookmarks, [ :list_id, :movie_id ], unique: true
  end
end
