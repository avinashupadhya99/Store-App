class EmployeesController < ApplicationController
  
  def index

  end

  def new
  	@employee = Employee.new
  end

  def create
  	@employee = Employee.new(emp_params)
  	if params.has_key?(:dob)
  		if (Date.parse(params[:dob]) < 18.years.ago)
			if @employee.save
				flash[:success] = "Employee was added successfully"
				redirect_to employee_path(@employee)
			else
				render 'new'
			end
		else
			notice[:danger] = "Employees have to be atleast 18 years of age"
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

  end

  private

  def emp_params
  	params.require(:employee).permit(:fName, :lName, :phone, :email, :dob, :address)
  end

end
