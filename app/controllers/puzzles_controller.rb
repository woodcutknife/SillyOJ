class PuzzlesController < ApplicationController
  def index
    @contest = Contest.find(params[:id])
    check_contest_started!
    @puzzles = @contest.puzzles.order('-ID DESC').page(params[:page]).per(100)
  end

  def show
    @contest = Contest.find(params[:id])
    check_contest_started!
    @puzzle = Puzzle.find(params[:pid])
  end
end
