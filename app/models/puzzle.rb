class Puzzle < ActiveRecord::Base
  has_many :solutions, dependent: :destroy
  has_and_belongs_to_many :contests

  validates :title, presence: true,
                    length: { minimum: 1, maximum: 30 }
  validates :time_limit, presence: true,
                         numericality: { only_integer: true, greater_than: 0 }
  validates :memory_limit, presence: true,
                           numericality: { only_integer: true, greater_than: 0 }

  before_save :render_body

  protected

  def render_body
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new
    extensions = { fenced_code_blocks: true }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)

    self.rendered_description = redcarpet.render self.description
    self.rendered_input_format = redcarpet.render self.input_format
    self.rendered_output_format = redcarpet.render self.output_format
    self.rendered_sample_input = redcarpet.render self.sample_input
    self.rendered_sample_output = redcarpet.render self.sample_output
    self.rendered_hint = redcarpet.render self.hint
  end
end
