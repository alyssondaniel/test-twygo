# frozen_string_literal: true

module Api
  module V1
    class MoviesController < ApplicationController
      # POST /api/v1/movies
      def create
        @movie = Movie.new(movie_params)
        if @movie.save
          render json: @movie, status: :created, location: @movie_url
        else
          render json: @movie.errors, status: :unprocessable_entity
        end
      end

      private

      # Only allow a list of trusted parameters through.
      def movie_params
        params.require(:movie).permit(:course_id, :url)
      end
    end
  end
end
