class ImportsController < ApplicationController
  def create
    render json: { error: "File is required" }, status: :unprocessable_entity and return if import_params[:file].blank?

    @import = Import.new(import_params)
    if @import.save
      render json: { message: "File uploaded successfully" }, status: :ok
    else
      render json: { error: @import.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def import_params
    params.require(:import).permit(:file)
  end
end
