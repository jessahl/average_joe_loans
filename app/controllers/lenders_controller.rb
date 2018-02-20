class LendersController < ApplicationController
  def index
  end

  def show
    @lender = Lender.find(session[:lender_id])
    @borrower = Borrower.all
    @lent_money_to = Transaction.joins(:borrower).select("*").where(lender_id: @lender.id)
    @transactions = Transaction.get_transactions session[:lender_id]  
  end

  def loans
    @lender = Lender.find(session[:lender_id])
    @borrower = Borrower.all
    @lent_money_to = Transaction.joins(:borrower).select("*").where(lender_id: @lender.id)
    @transactions = Transaction.get_transactions session[:lender_id]  
  end

  def create_transaction
    @lender = Lender.find(session[:lender_id])
    @borrower = Borrower.find(params[:transaction][:borrower_id])
    money =  (params[:transaction][:amount]).to_d
    current_balance = @lender.balance - money
    current_amount_raised = @borrower.amount_raised + money

    if current_balance < 0
      flash[:errors] = ["Not enough funds"]
    else
      puts "money"
      puts money
      puts 'current balance'
      puts current_balance
      @lender.update(balance: current_balance)
      puts @lender.balance
      puts @lender.errors.full_messages
      @borrower.update(amount_raised: current_amount_raised)
      transaction = Transaction.new(tranactions_params)
      transaction.lender = Lender.find(session[:lender_id])
      transaction.save
    end
    redirect_to :back
  end


  private
    def tranactions_params
      params.require(:transaction).permit(:amount, :borrower_id)
    end
end
