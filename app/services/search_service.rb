module SearchService
  class << self
    include ParseDate
    def search_date(params,user)
      start_date = position_search(params[:search],0)
      end_date = position_search(params[:search],1)
      Note.search_by_date(start_date,end_date,user)
    end
  end
end