class BorrowersController < ApplicationController
  def index
  end

  def show
    @borrower = Borrower.find(session[:borrower_id])
    @lender = Lender.all
    # @transactions = Lender.where(borrower_id = @borrower.id).
    @transactions = Transaction.joins(:lender).select("SUM(amount) AS amount_lent", "lenders.first_name", "lenders.last_name", "lenders.email").group("lenders.id").where(borrower_id: @borrower.id)
  end
end
