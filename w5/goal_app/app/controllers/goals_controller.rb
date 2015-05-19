class GoalsController < ApplicationController
  before_action :ensure_signed_in!

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update

  end

  private
    def goal_params
      params.require(:goal).permit(:title, :body, :public, :completed)
    end
end
