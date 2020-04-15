require 'date'

class EmployeesController < ApplicationController
  
  before_action :require_user
  before_action :require_admin, except: [:show]

  def index

  end

  def new
  	@employee = Employee.new
  end

  def create
  	@employee = Employee.new(emp_params)
  	if params[:employee][:dob].present?
      dt = Date.today
      y = dt.year-18
      m = dt.mon
      d = dt.mday
      date_eighteen_ago = Date.new(y,m,d)
  		if (Date.parse(params[:employee][:dob]) < date_eighteen_ago)
  			if @employee.save
  				flash[:success] = "Employee was added successfully"
  				redirect_to employee_path(@employee)
  			else
  				render 'new'
  			end
  		else
  			flash[:danger] = "Employees have to be atleast 18 years of age"
        render 'new'
  		end
  	else
  		@employee.save
  		render 'new'
  	end
  end

  def edit
  end

  def update
  end

  def show
    @employee = Employee.find(params[:id])
    user = User.find_by(employee_id: @employee.id) #Find the user assosciated with the employee
    if user.present?
      if current_user!=user && !current_user.admin? #redirect if employee requested is not current user and current user is not admin
        emp = Employee.find(current_user.employee_id)
        redirect_to employee_path(emp)
      end
    elsif !current_user.admin? #If no login(user) is created for the employee, then redirect if current user is not admin
      emp = Employee.find(current_user.employee_id)
      redirect_to employee_path(emp)
    end
  end

  private

  def emp_params
  	params.require(:employee).permit(:fName, :lName, :phone, :email, :dob, :address)
  end

end
