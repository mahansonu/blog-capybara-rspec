class Page < ApplicationRecord
  attr_accessor :tags_string
  before_validation :make_slug
  after_save :update_tags

  has_many :page_tags, dependent: :destroy
  has_many :tags, through: :page_tags
  belongs_to :user
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(created_at: :desc) }
  scope :by_term, -> (term) do
    term.gsub(/[^-\w]/,"")
    terms = term.include?(" ") ? term.split : [term]
    pages = Page
    terms.each  {|term| pages = pages.where("content ilike ?","%#{term}%")}
    pages
  end

  scope :by_year_month, ->(year, month) do
    sql = <<~SQL
      extract(year from created_at) = ?
      and extract(month from created_at) = ?
    SQL
    where(sql, year, month)
  end

  def self.month_year_list
    sql = <<~SQL
      select DISTINCT
        trim(to_char(created_at, 'Month')) as month_name,
        to_char(created_at, 'MM') as month_number,
        to_char(created_at, 'YYYY') as year
      from pages
      where published = true
      order by year desc, month_number desc
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end

  def tags_string_for_form
    tags.ordered.map(&:name).join(", ")
  end

  private
  def make_slug
    return unless title
    self.slug = NameCleanup.cleanup(title)
  end

  def update_tags
    self.tags = []
    return if tags_string.blank?
    tags_string.split(", ").each do |tag|
      name = NameCleanup.cleanup(tag)
      tags << Tag.find_or_create_by(name:)
    end
  end
end
