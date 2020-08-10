class SearchController < ApplicationController
    def search
       @query = search_params[:query]
       @search_type = search_params[:search_type]

       @results = Search.search @query, @search_type
    end

    def search_params
      params.require(:search).permit(:query, :search_type)
    end
end
