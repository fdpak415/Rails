# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  u1 = User.create!(name: "frank")
  u2 = User.create!(name: "ellie")

  p1 = Poll.create!(title: "car poll", author_id: u1.id)
  p2 = Poll.create!(title: "dogs poll", author_id: u2.id)

  q1 = Question.create!(text: "What car do you like?", poll_id: p1.id)
  ac1 = AnswerChoice.create!(text: "Porsche", question_id: q1.id)
  ac2 = AnswerChoice.create!(text: "BMW", question_id: q1.id)
  ac3 = AnswerChoice.create!(text: "TESLA", question_id: q1.id)

  q2 = Question.create!(text: "What dog do you like?", poll_id: p2.id)
  ac4 = AnswerChoice.create!(text: "Lay", question_id: q2.id)
  ac5 = AnswerChoice.create!(text: "Cubby", question_id: q2.id)
  ac6 = AnswerChoice.create!(text: "Totoro", question_id: q2.id)

  r1 = Response.create!(answer_choice_id: ac2.id, respondent_id: u2.id)
  r2 = Response.create!(answer_choice_id: ac5.id, respondent_id: u1.id)
end
