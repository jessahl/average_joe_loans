class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def index
    
  end
  
  def create
    if Lender.find_by(email: params[:email])
      lender = Lender.find_by(email: params[:email])
      lender && lender.authenticate(params[:password])
      session[:lender_id] = lender.id
      redirect_to "/lenders/#{lender.id}"
    elsif Borrower.find_by(email: params[:email])
      borrower = Borrower.find_by(email: params[:email])
      borrower && borrower.authenticate(params[:password])
      session[:borrower_id] = borrower.id
      redirect_to "/borrowers/#{borrower.id}"
    else
      flash[:errors] = ["Invalid Combination"]
      redirect_to "/sessions/login"
    
    end
  end
  
  def destroy
    reset_session
    redirect_to :root
  end
  
end
