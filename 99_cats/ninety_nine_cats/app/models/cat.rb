require 'action_view'

class Cat < ActiveRecord::Base
   include ActionView::Helpers::DateHelper

  COLORS = ["BLACK", "BLUE", "BROWN", "WHITE", "ORANGE"]
  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: {in: COLORS}
  validates :sex, inclusion: {in: %w(M F)}

  has_many :rental_requests,
  dependent: :destroy,
  class_name: "CatRentalRequest"



  def age
    time_ago_in_words(birth_date)
  end
end
