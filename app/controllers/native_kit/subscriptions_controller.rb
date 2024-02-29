# frozen_string_literal: true

class NativeKit::SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    subscriber = current_user # TODO: Allow override in initializer
    subscription = NativeKit::WebPushSubscription.find_or_initialize_by(subscriber: subscriber, endpoint: params[:endpoint], auth_key: params[:keys][:auth], p256dh_key: params[:keys][:p256dh])
    subscription.user_agent = params[:user_agent]
    subscription.save!

    head :ok
  end
end
