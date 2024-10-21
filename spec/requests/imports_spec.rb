require 'rails_helper'

RSpec.describe "ImportsController", type: :request do
  describe "POST /api/imports" do
    let(:params) { { import: { file: } } }
    let(:file) { fixture_file_upload('restaurant_data.json', 'application/json') }

    before { post imports_path, params: params }

    context "when file is present" do
      describe "when file is valid" do
        it "returns http success" do
          expect(response).to have_http_status(:ok)
        end

        it "returns success message" do
          expect(json_body[:message]).to eq("File uploaded successfully")
        end
      end

      describe "when file is invalid" do
        let(:file) { fixture_file_upload('restaurant_data.csv', 'text/csv') }

        it "returns http unprocessable entity" do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "returns error message" do
          expect(json_body[:error]).to eq([ "File must be a JSON file" ])
        end
      end
    end

    context "when file is not present" do
      let(:file) { nil }

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns error message" do
        expect(json_body[:error]).to eq("File is required")
      end
    end
  end
end
