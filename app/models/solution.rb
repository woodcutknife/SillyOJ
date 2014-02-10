class Solution < ActiveRecord::Base
  belongs_to :hacker
  belongs_to :puzzle
  belongs_to :contest

  has_many :test_results, dependent: :destroy

  validates :language, presence: true,
                       inclusion: { in: [ 'C', 'C++', 'Pascal' ] }
  validates :code, presence: true,
                   length: { minimum: 2, maximum: 100000 }

  before_save :render_body

  def judge
    require 'socket'
    require 'yaml'

    mode = self.contest.mode

    self.result = 'Waiting'
    self.save

    loop do
      begin
        client = TCPSocket.new 'localhost', '1234'
      rescue
        client = nil
      end

      if client
        self.result = 'Running'
        self.save

        client.puts YAML::dump([ self.puzzle_id, self.language, self.code, mode ])

        judge_result = YAML::load(client.recvfrom(131072)[0])
        client.close

        self.result = judge_result[0]
        self.time_cost = judge_result[1].to_i
        self.memory_cost = judge_result[2].to_i
        self.compile_info = judge_result[-1].join("\n")

        if mode == 'OI'
          judge_result[3].each do |log|
            test_result = TestResult.new
            test_result.result = log[:result]
            test_result.score = log[:score]
            test_result.time_cost = log[:time]
            test_result.memory_cost = log[:memory]
            test_result.log = log[:checker_log]
            test_result.solution = self
            test_result.save
          end
        end

        self.save

        return true
      end

      sleep(0.5)
    end

    false
  end

  protected

  def render_body
    require 'redcarpet'
    renderer = PygmentizeHTML.new
    extensions = { fenced_code_blocks: true }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)

    self.rendered_code = redcarpet.render "~~~ #{self.language.downcase}\n#{self.code}\n~~~"

    renderer = Redcarpet::Render::HTML.new
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    self.rendered_compile_info = redcarpet.render "~~~\n#{self.compile_info}\n~~~"
  end
end

class PygmentizeHTML < Redcarpet::Render::HTML
  def block_code(code, language)
    require 'pygmentize'
    Pygmentize.process(code, language)
  end
end
