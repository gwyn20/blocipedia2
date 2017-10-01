class ChargesController < ApplicationController
  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
  
    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in the app
      amount: 15_00,
      description: "Upgrade to Premium Plan - #{current_user.email}",
      currency: 'usd'
    )

    current_user.premium!
  
    flash[:notice] = "Thank you for upgrading to our Premium Plan #{current_user.email}!"
    redirect_to edit_user_registration_path(current_user) # Takes you to User Profile Page
  
    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Plan",
      amount: 15_00
    }
  end

  def downgrade
    @user = current_user
    current_user.standard!
    @user.wikis.each do |wiki|
      wiki.update_attributes(private: false)
    end
    flash[:notice] = "Hey #{current_user.email}, you have now been placed back on our Standard Free Plan."
    redirect_to edit_user_registration_path(current_user) # Takes you to User Profile Page
  end

end
