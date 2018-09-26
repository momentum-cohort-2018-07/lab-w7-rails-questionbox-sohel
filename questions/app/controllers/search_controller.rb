class SearchController < ApplicationController
    skip_before_action :verify_authentication

    
    def index
        if search_params[:search_term].present?
            @results = Post.search_all_partial_matches(search_params[:search_term])
        else
            @results = Post.all
        end
    end
    
      private
        def search_params
          params.permit(:search_term)
        end
end