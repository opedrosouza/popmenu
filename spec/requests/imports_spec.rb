require 'rails_helper'

RSpec.describe "ImportsController", type: :request do
  describe "POST /api/imports" do
    context "when file is not present" do
      it "returns http unprocessable entity" do
        post imports_path
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when file is present" do
      it "returns http success" do
        post imports_path, params: { file: fixture_file_upload('restaurant_data.json', 'application/json') }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
