# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      before_action :set_course, only: %i[show update]

      # GET /api/v1/courses
      def index
        @courses = params[:date] ? Course.active_filter(params[:date]) : Course.active

        render json: @courses, include: :movies
      end

      # GET /api/v1/courses/1
      def show
        render json: @course
      end

      # POST /api/v1/courses
      def create
        @course = Course.new(course_params)
        if @course.save
          render json: @course, status: :created, location: @course_url
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/courses/1
      def update
        if @course.update(course_params)
          render json: @course
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_course
        @course = Course.find_by(id: params[:id])
        render json: { error: 'not found' }, status: :not_found unless @course
      end

      # Only allow a list of trusted parameters through.
      def course_params
        params.require(:course).permit(:title, :description, :end_on)
      end
    end
  end
end
