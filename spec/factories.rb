Factory.define :account do |f|
  f.sequence(:username) { |n| "ecj#{n}" }
  f.sequence(:email) { |n| "ecj#{n}@edjones.com" }
  f.password "secret"
  f.password_confirmation {|u| u.password }
end


Factory.define :game_stat do |f|
  f.sequence(:login) { |n| "ej1c" }
  f.sequence(:game_id) { |n| "1" }
  f.sequence(:high_score) { |n| "3333" }
end  

  
