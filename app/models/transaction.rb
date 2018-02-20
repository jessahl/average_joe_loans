class Transaction < ActiveRecord::Base
  belongs_to :lender
  belongs_to :borrower

  def self.get_transactions current_user_id
    self.select("SUM(transactions.amount) AS amount_lent", "borrowers.*").group(:borrower_id).joins(:borrower).where(lender_id: current_user_id)
  end
end
