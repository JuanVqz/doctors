class AddMaritalStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :marital_status, :string
  end
end
