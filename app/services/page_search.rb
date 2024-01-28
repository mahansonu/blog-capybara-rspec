module PageSearch
  def self.search(params)
    return [] unless params.present?
    pages = []
    pages = Page.by_term(params[:term]) if params[:term].present?
    pages = Page.by_year_month(params[:year], params[:month]) if params[:year].present? && params[:month].present?

    return [] unless pages.present?
    pages.published.ordered
  end

end