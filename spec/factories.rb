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

Factory.define :my_game do |f|
  f.sequence(:title) { |n| "#{n}th century" }
  f.sequence(:author) { |n| "common_user" }
end   

Factory.define :my_digi do |f|
  f.sequence(:theme) { |n| 'Bad Santas' }
  f.sequence(:author) { |n| 'testdude' }
  f.public false
  f.public_play false
end  
