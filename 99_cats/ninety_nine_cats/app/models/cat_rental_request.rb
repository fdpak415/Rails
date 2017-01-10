class CatRentalRequest < ActiveRecord::Base

  STATUSES = ["PENDING", "APPROVED", "DENIED"]

  validates :cat_id, :status, :start_date, :end_date, presence: true
  validates :status, inclusion: {in: STATUSES}
  validate :start_must_come_before_end
  validate :does_not_overlap_approved_requests

  belongs_to :cat

  after_initialize :assign_pending_status

  def approve!
    raise "not pending" unless self.status == "PENDING"
    transaction do
      self.status = "APPROVED"
      self.save!

      overlapping_pending_requests.update_all(status: "DENIED")
    end
  end

  def approved?
    self.status == "APPROVED"
  end

  def denied?
    self.status == "DENIED"
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  def pending?
    self.status == "PENDING"
  end

  private

  def assign_pending_status
    self.status ||= "PENDING"
  end

  def overlapping_requests
    CatRentalRequest
      .where.not(id: self.id)
      .where(cat_id: cat_id)
      .where(<<-SQL, start_date: start_date, end_date: end_date)
        NOT( (start_date > :end_date) OR (end_date < :start_date) )
      SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  def does_not_overlap_approved_requests
    return if self.denied?

    unless overlapping_approved_requests.empty?
      errors[:base] << "Request conflicts with existing approved rental request"
    end
  end

  def start_must_come_before_end
    return if start_date < end_date
    errors[:start_date] << "must come before end date"
    errors[:end_date] << "must come after start date"
  end
end
