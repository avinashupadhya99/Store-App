class SessionsController < ApplicationController
	#Deals with authentication
	before_action :require_user, only: [:destroy]
	before_action :no_login, except: [:destroy]
	def new
		 
	end

	def create
		employee = Employee.find_by(email: params[:session][:email].downcase)
		if employee
			user = User.find_by(employee_id: employee.id)
			if user && user.authenticate(params[:session][:password])
				session[:user_id] = user.id
				flash[:success] = "You have successfully logged in"
				redirect_to employee_path(employee)
			else
				flash.now[:danger] = "There was something wrong with your login information"
				render 'new'
			end
		else
			flash.now[:danger] = "There was something wrong with your login information"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You have logged out"
		redirect_to root_path
	end

	private 

	def no_login
		if logged_in?
			flash[:danger]="You are already logged in!"
			redirect_to employee_path(current_user.employee_id)
		end
	end

end