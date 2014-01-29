class ContestsController < ApplicationController
  def index
    @contests = Contest.order('ID DESC').page(params[:page]).per(10)
  end

  def register
    authenticate_hacker!

    contest = Contest.find(params[:id])

    if contest.started
      flash[:alert] = "This contest has started."
      redirect_to contests_path
    end

    unless contest.default
      hacker = current_hacker
      hacker.contests << contest
    end

    redirect_to contests_path
  end
end
