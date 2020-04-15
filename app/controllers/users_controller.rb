class UsersController < ApplicationController
  
  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:user][:email].present? #Check if email is entered
      if params[:user][:conf_password].present? && params[:user][:password].present? #Check if both password fields are entered
        if params[:user][:password]==params[:user][:conf_password] #Check if passwords match
          @employee = Employee.find_by(email: params[:user][:email]) #Find the employee matching the email
          if @employee.present? #Check if employee exists
            old_user = User.find_by(employee_id: @employee.id)
            if !old_user.present?  #Check if a login(user) is already created for the employee
              params[:user][:employee_id] = @employee.id
              @user = User.new(user_params)
              if @user.save
                flash[:success] = "Login created for \"#{@employee.email}\""
                redirect_to employee_path(@employee)
              else
                render 'new'
              end
            else
              flash[:danger] = "Login already created for \"#{@employee.email}\" "
              render 'new'
            end
          else
            flash[:danger] = "No employee exists with that employee email id"
            render 'new'
          end
        else
          flash[:danger] = "Passwords don't match"
          render 'new'
        end
      else
        flash[:danger] = "Enter password and confirmation password"
        render 'new'
      end
    else
      flash[:danger] = "Email cannot be blank"
      render 'new'
    end
  end

  def edit

  end

  def update
  	
  end

  private

  def user_params
    params.require(:user).permit(:employee_id, :password)
  end

end
