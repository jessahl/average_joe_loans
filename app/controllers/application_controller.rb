class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception  

  def current_user
    Lender.find(session[:lender_id]) if session[:lender_id]
    Borrower.find(session[:borrower_id]) if session[:borrower_id]
  end
  
  def require_login
    redirect_to :back unless session[:lender_id] || session[:borrower_id]
  end 

  helper_method :current_user
  
end
