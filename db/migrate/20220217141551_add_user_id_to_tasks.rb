class AddUserIdToTasks < ActiveRecord::Migration[6.1]
  def change
  end

  add_foreign_key :tasks, :users
end
