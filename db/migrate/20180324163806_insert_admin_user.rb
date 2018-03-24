class InsertAdminUser < ActiveRecord::Migration[5.1]
  user = User.new
  user.email = "admin@mail.jp"
  user.password = "password"
  user.save
  user.add_role "admin"
end
