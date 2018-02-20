class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def create
    if params[:lender]
      if Borrower.find_by(email: params[:lender][:email])
        flash[:errors ]= ["Email has already been taken"]
        redirect_to :back
      else 
        @lender = Lender.new lender_params
        if @lender.save
          redirect_to "/sessions/login"
        else
          flash[:errors] = @lender.errors.full_messages   
          redirect_to :back
        end
      end
    elsif params[:borrower]
      if Lender.find_by(email: params[:borrower][:email])
        flash[:errors] = ["Email has already been taken"]
        redirect_to :back
      else
        @borrower = Borrower.new borrower_params
        @borrower.amount_raised = 0
        if @borrower.save
          redirect_to '/sessions/login'
        else
          flash[:errors] = @borrower.errors.full_messages   
          redirect_to :back
        end
      end
    end
  end

  def about

  end

  def contact
    
  end
      

  private

    # def require_correct_lender
    #   if current_lender != Lender.find(params[:id])
    #     redirect_to "/lenders/#{session[:lender_id]}"
    #   end
    # end

    def lender_params
      params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :balance)
    end

    # def require_correct_borrower
    #   if current_borrower != Borrower.find(params[:id])
    #     redirect_to "/borrowers/#{session[:borrower_id]}"
    #   end
    # end

    def borrower_params
      params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :amount_needed, :purpose, :description)
    end
end
