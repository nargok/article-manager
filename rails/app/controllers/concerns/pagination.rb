module Pagination
  extend ActiveSupport::Concern

  def pagination(records)
    {
      current_page: records.current_page,
      total_page: records.total_pages,
    }
  end
end
