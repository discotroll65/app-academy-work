def sign(type = "In", user)
  place = (type == "In") ? "session" : "users"
  visit("/#{place}/new")
  fill_in('Username', with: user.username)
  fill_in('Password', with: user.password)
  click_button("Sign #{type}")
end
