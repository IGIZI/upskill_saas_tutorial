class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         belongs_to :plan
         has_one :profile
         
         attr_accessor :stripe_card_token
         #If user passes validation (email, password, password),
         # then call stripe and tell it to make subscription and 
         # charge from customers card.
         # Stripe responds with user token and id, save it and save user.
def save_with_subscription
  if valid?
    customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
    self.stripe_customer_token = customer.id
    save!
  end
end
end
