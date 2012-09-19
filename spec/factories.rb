# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name "Aditya Lesmana"
  user.username "example@xxx.com"
  user.role "admin"
  user.password "xxx"
end