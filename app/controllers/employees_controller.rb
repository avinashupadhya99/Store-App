require 'date'

class EmployeesController < ApplicationController
  
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
  end

  private

  def emp_params
  	params.require(:employee).permit(:fName, :lName, :phone, :email, :dob, :address)
  end

end
