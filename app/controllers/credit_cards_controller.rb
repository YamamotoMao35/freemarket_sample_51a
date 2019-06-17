class CreditCardsController < ApplicationController

  require "payjp"
  
  def new
    redirect_to action: "show" if current_user.credit_card.present?
  end

  def pay
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        user = User.find(current_user.id)
        user.update(credit_card_id: @card.id)
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end
  
  def delete
    card = current_user.credit_card
    if card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
    redirect_to action: "new"
  end

  def show
    card = current_user.credit_card
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
end

