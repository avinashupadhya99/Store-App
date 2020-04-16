class UsersController < ApplicationController
  
  before_action :require_user, except: [:new, :create]

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
                session[:user_id] = @user.id
                redirect_to employee_path(@employee)
              else
                render 'new'
              end
            else
              flash.now[:danger] = "Login already created for \"#{@employee.email}\" "
              render 'new'
            end
          else
            flash.now[:danger] = "No employee exists with that employee email id"
            render 'new'
          end
        else
          flash.now[:danger] = "Passwords don't match"
          render 'new'
        end
      else
        flash.now[:danger] = "Enter password and confirmation password"
        render 'new'
      end
    else
      flash.now[:danger] = "Email cannot be blank"
      render 'new'
    end
  end

  def edit

  end

  def update
  	
  end

  def editPassword
  end

  def updatePassword
    user_pwd_change = current_user
    if params[:user][:old_password].blank? || params[:user][:new_password].blank? || params[:user][:conf_password].blank?
      flash[:danger] = "Enter all fields"
      redirect_to editPassword_path
    else
      if params[:user][:new_password]!=params[:user][:conf_password]  #Check if passwords match
        flash[:danger] = "Passwords don't match"
        redirect_to editPassword_path
      elsif params[:user][:old_password]==params[:user][:new_password] #Check if new password is same as old password
        flash[:danger] = "New password cannot be same as old password"
        redirect_to editPassword_path
      elsif user_pwd_change.authenticate(params[:user][:old_password]) #Check if old password is correct
        user_pwd_change.password=params[:user][:new_password]
        if user_pwd_change.save
          flash[:success] = "Password was changed successfully"
          redirect_to employee_path(current_employee)
        else
          flash[:danger] = "Password cannot be blank"
          redirect_to editPassword_path
        end
      else
        flash[:danger] = "Wrong old password"
        redirect_to editPassword_path
      end    
    end
  end

  private

  def user_params
    params.require(:user).permit(:employee_id, :password)
  end

end
