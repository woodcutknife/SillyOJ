class SolutionsController < ApplicationController
  def index
    @contest = Contest.find(params[:id])
    lim = {}
    lim[:contest_id] = params[:id]
    lim[:hacker_id] = params[:hacker_id] if params[:hacker_id]
    lim[:puzzle_id] = params[:puzzle_id] if params[:puzzle_id]
    lim[:result] = params[:result] if params[:result]
    @solutions = Solution.where(lim).order('id DESC').page(params[:page]).per(10)
  end

  def show
    authenticate_hacker!

    @contest = Contest.find(params[:id])
    @solution = Solution.find(params[:sid])
    if (not @contest.ended) and (current_hacker.id != @solution.hacker_id)
      flash[:alert] = "You are not allowed to view this code."
      redirect_to contests_path
    end
  end

  def new
    authenticate_hacker!

    @contest = Contest.find(params[:id])
    if @contest.ended
      flash[:alert] = "This contest has ended."
      redirect_to contest_puzzles_path(@contest.id)
      return
    end
    check_contest_registered!
    @solution = Solution.new
    @solution.puzzle_id = params[:puzzle_id]
  end

  def create
    authenticate_hacker!

    @contest = Contest.find(params[:id])
    if @contest.ended
      flash[:alert] = "This contest has ended."
      redirect_to contest_puzzles_path(@contest.id)
      return
    end
    check_contest_registered!

    @solution = Solution.new(params[:solution].permit(:puzzle_id, :language, :code))
    @solution.hacker_id = current_hacker.id
    @solution.contest_id = params[:id]
    @solution.time_cost = -1
    @solution.memory_cost = -1
    @solution.result = "Pending"

    @solution.hacker.language_last_use = @solution.language
    @solution.hacker.save

    if Puzzle.where(id: @solution.puzzle_id).size == 1 && @solution.save
      if @contest.end_time and @contest.mode == 'OI'
        snds = @contest.end_time.to_i - Time.now.to_i
        snds = 1 if snds < 1
        @solution.delay(run_at: snds.from_now).judge
        redirect_to contest_puzzles_path(params[:id])
      else
        @solution.delay.judge
        redirect_to contest_solutions_path(params[:id])
      end
    else
      render action: "new"
    end
  end
end
