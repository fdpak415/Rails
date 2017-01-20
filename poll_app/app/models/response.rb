class Response < ActiveRecord::Base
  validates :answer_choice_id, :respondent_id, presence: true

  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_poll_author

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: 'AnswerChoice'

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :respondent_id,
    class_name: 'User'

  has_one :question,
    through: :answer_choice

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  private

  def respondent_has_not_already_answered_question
   if sibling_responses.exists?(respondent_id: self.respondent_id)
     errors[:respondent_id] << "cannot vote twice for question"
   end
  end

  def respondent_is_not_poll_author
    poll_author_id = self.answer_choice.question.poll.author_id
      if poll_author_id == self.respondent_id
        errors[:author_id] << "poll create cannot answer the poll"
      end
  end

end
