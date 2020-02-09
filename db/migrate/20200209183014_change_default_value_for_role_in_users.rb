class ChangeDefaultValueForRoleInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :role, from: 1, to: 0
  end
end
