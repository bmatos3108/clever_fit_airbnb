class RemoveUserIdFromReviews < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :reviews, :users
    remove_index :reviews, :user_id
    remove_column :reviews, :user_id, :string
  end
end
