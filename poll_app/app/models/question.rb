class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: 'AnswerChoice'

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: 'Poll'

  has_many :responses,
    through: :answer_choices

  def results_n_plus_1
    results = {}

    self.answer_choices.each do |choice|
      results[choice.text] = choice.responses.count
    end
    results
  end

  def results_includes
    results = {}
    responses = self.answer_choices.includes(:responses).each do |ac|
      results[ac.text] = ac.responses.length
    end
    results
  end

  def results_sql
    acs = AnswerChoice.find_by_sql([<<-SQL, id])
    SELECT
      answer_choices.*, COUNT(responses.id) AS num_responses
    FROM
      answer_choices
    LEFT JOIN
      responses ON responses.answer_choice_id = answer_choices.id
    WHERE
      answer_choices.question_id = ?
    GROUP BY
      answer_choices.id
    SQL

    acs.inject({}) do |results, ac|
      results[ac.text] = ac.num_responses; results
    end
  end

  def results_active_record
    acs = self.answer_choices
      .select("answer_choices.text, COUNT(responses.id) AS num_responses")
      .joins(<<-SQL).group("answer_choices.id")
        LEFT JOIN
          responses ON responses.answer_choice_id = answer_choices.id
        SQL
    acs.inject({}) do |results, ac|
      results[ac.text] = ac.num_responses; results
    end
  end
end
