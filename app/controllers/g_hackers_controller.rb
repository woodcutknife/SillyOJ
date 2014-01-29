class GHackersController < ApplicationController
  def index
    sorted = Hacker.all
    @ac_cnt = {}
    sorted.each do |hacker|
      @ac_cnt[hacker.id] = hacker.solutions.select { |x| x.result == "Accepted" }.map { |y| y.puzzle_id }.uniq.size
    end
    sorted.sort_by! { |hacker| [
      -@ac_cnt[hacker.id],
      hacker.solutions.size,
      hacker.id
    ]}
    @hackers = Kaminari.paginate_array(sorted).page(params[:page]).per(50)
  end

  def show
    @hacker = Hacker.find(params[:id])
    @solved = @hacker.solutions.select { |x| x.result == "Accepted" }.map { |y| y.puzzle_id }.sort.uniq
  end
end
