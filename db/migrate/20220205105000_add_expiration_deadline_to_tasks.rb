class AddExpirationDeadlineToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :expiration_deadline, :datetime, null: false
  end
end
