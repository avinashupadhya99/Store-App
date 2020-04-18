class SessionsController < ApplicationController
	#Deals with authentication
	before_action :require_user, only: [:destroy]
	before_action :no_login, except: [:destroy]
	def new
		 
	end

	def create
		employee = Employee.find_by(email: params[:session][:email].downcase) #Find the employee using the email entered
		if employee #Proceed only if an employee exists with the email entered
			user = User.find_by(employee_id: employee.id) #User of the employee
			if user && user.authenticate(params[:session][:password]) #Proceed only if user exists and password is correct
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

	def no_login #Checks if login path is called after logging in
		if logged_in?
			flash[:danger]="You are already logged in!"
			redirect_to employee_path(current_user.employee_id)
		end
	end

end