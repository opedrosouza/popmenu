class ImportsController < ApplicationController
  def create
    return render json: { error: "File is required" }, status: :unprocessable_entity if params[:file].nil?
    render json: { message: "File uploaded successfully" }, status: :ok
  end
end
