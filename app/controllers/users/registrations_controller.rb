class Users::RegistrationsController < Devise::RegistrationsController
  before_action :select_plan, only: :new
  def create
    # Extend the devise code so that users can register
    # to pro account. Check param = plan2? if yes then
    # set user.plan_id to 2 and save with subscription function.
    # else save normal.
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
 
  
  private
    def select_plan
      unless (params[:plan] == '1' || params[:plan] == '2')
        flash[:notice] = "Please select plan to continue!"
        redirect_to root_url
      end
    end  
    
    
end