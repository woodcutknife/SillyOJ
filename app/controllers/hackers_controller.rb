class HackersController < ApplicationController
  def index
    @contest = Contest.find(params[:id])
    check_contest_started!
    sorted = []
    @contest.hackers.each { |x| sorted << x }
    @ac_cnt = {}
    mode = @contest.mode
    @score = {} if mode == "oi"
    sorted.each do |hacker|
      rec = {}
      hacker.solutions.each do |x|
        if rec.has_key? x.puzzle_id
          if x.id > rec[x.puzzle_id].id
            rec[x.puzzle_id] = x
          end
        else
          rec[x.puzzle_id] = x
        end
      end
      @score[hacker.id] = 0 if mode == "oi"
      rec.each { |key, val| @score[hacker.id] += val.result.to_i } if mode == "oi"
      @ac_cnt[hacker.id] = hacker.solutions.select { |x| x.result == (mode == "oj" ? "Accepted" : "100") and x.contest_id == @contest.id }.map { |y| y.puzzle_id }.uniq.size
    end
    sorted.sort_by! { |hacker| [
        -@ac_cnt[hacker.id],
        hacker.solutions.select { |x| x.contest_id == @contest.id }.size,
        hacker.id
    ]}
    p sorted
    @hackers = Kaminari.paginate_array(sorted).page(params[:page]).per(50)
  end

  def show
    @contest = Contest.find(params[:id])
    check_contest_started!
    @hacker = Hacker.find(params[:hid])
    @solved = @hacker.solutions.select { |x| x.result == "Accepted" and x.contest_id == @contest.id }.map { |y| y.puzzle_id }.sort.uniq
  end
end
