class HackersController < ApplicationController
  def index
    @contest = Contest.find(params[:id])
    check_contest_started!
    sorted = []
    @contest.hackers.each { |x| sorted << x }
    @ac_cnt = {}
    mode = @contest.mode
    @score = {} if mode == "OI"
    sorted.each do |hacker|
      rec = {}
      solutions = hacker.solutions.where(contest_id: @contest.id)
      solutions.each do |x|
        if rec.has_key? x.puzzle_id
          if x.id > rec[x.puzzle_id].id
            rec[x.puzzle_id] = x
          end
        else
          rec[x.puzzle_id] = x
        end
      end
      @score[hacker.id] = 0 if mode == "OI"
      rec.each { |key, val| @score[hacker.id] += val.result.to_f } if mode == "OI"
      @ac_cnt[hacker.id] = solutions.select { |x| x.result == (mode == "OI" ? "100.0" : "Accepted") }.map { |y| y.puzzle_id }.uniq.size
    end
    if mode == "OI"
      sorted.sort_by! { |hacker| [
        -@score[hacker.id],
        -@ac_cnt[hacker.id],
        hacker.solutions.select { |x| x.contest_id == @contest.id }.size,
        hacker.id
      ]}
    elsif mode == "ACM"
      sorted.sort_by! { |hacker| [
          -@ac_cnt[hacker.id],
          hacker.solutions.select { |x| x.contest_id == @contest.id }.size,
          hacker.id
      ]}
    end
    @hackers = Kaminari.paginate_array(sorted).page(params[:page]).per(50)
  end
end
