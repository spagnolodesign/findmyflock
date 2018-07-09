class SubscribersController < ApplicationController
  before_action :authenticate_recruiter!
  before_action :set_company

  def new
    @plan = Plan.first
    @subscriber = Subscriber.new
  end

  def create
    @plan = Plan.find_by(stripe_id: params[:plan])
    @subscriber = Subscriber.new(company: @company)
    stripe_token = params[:stripeToken]
    billing_address = {
      line1: params[:address_line1],
      city: params[:address_city],
      state: params[:address_country],
      country: params[:address_state],
      postal_code: params[:address_zip]
    }

    if @subscriber.save_and_make_payment(current_recruiter.email, @plan, stripe_token, billing_address)
       redirect_to dashboard_companies_path, notice: "Thank you to subscribe with us."
    else
      render :new
    end
  end

  def destroy
    #Set subscription to canceld with stripe API
    @subscriber = Subscriber.find(params[:id])
    if @subscriber.active?
      sub = Stripe::Subscription.retrieve(@subscriber.stripe_subscription_id)
      if sub.delete
        redirect_to subscribers_path, notice: "Your subscription was canceled, you will still a member until the next billing period."
      end
    end
  end

  def set_company
    @company = current_recruiter.company
  end


end
