class CatRentalRequestsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_owner_approves, only: [:approve, :deny]
  before_action :ensure_owner_does_not_rent_own_cat, only: [:create]


  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def create
    @rental_request = CatRentalRequest.new(cat_rental_request_params)
    @rental_request.user_id = current_user.id
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      flash[:errors] = @rental_request.errors.full_messages
      redirect_to :back
    end
  end

  def ensure_owner_does_not_rent_own_cat
    @rental_request = CatRentalRequest.new(cat_rental_request_params)
    cat = @rental_request.cat
    if current_user.cats.include?(cat)
      flash[:errors] = ["Can't rent your own cat, dummy"]
      redirect_to :back
    end
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end

  private
  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :end_date, :start_date, :status)
  end

  def ensure_owner_approves
    @rental = CatRentalRequest.find(params[:id])
    cat = @rental.cat
    unless cat.user_id == current_user.id
      flash[:errors] = ["You don't own #{cat.name}!"]
      redirect_to cat_url(cat)
    end
  end
end
