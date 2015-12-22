class ChangeUsers < ActiveRecord::Migration
  def change
   change_column_default :users, :private,   default: 0
   change_column_default :users, :count_message,  default: 0
  end
end
