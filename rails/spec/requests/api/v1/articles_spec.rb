require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /index" do
    subject { get(api_v1_articles_path(params)) }

    before do
      create_list(:article, 25, status: :published)
      create_list(:article, 8, status: :draft)
    end

    context "pageをparamsで送信しない時" do
      let(:params) { nil }

      it "1ページ目のレコードを10件取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.keys).to eq ["articles", "meta"]
        expect(res["articles"].length).to eq 10
        expect(res["articles"][0].keys).to eq ["id", "title", "content", "status", "created_at", "from_today", "user"]
        expect(res["articles"][0]["user"].keys).to eq ["name"]
        expect(res["meta"].keys).to eq ["current_page", "total_pages", "total_count"]
        expect(res["meta"]["current_page"]).to eq 1
        expect(res["meta"]["total_pages"]).to eq 3
        expect(res["meta"]["total_count"]).to eq 25 
      end
    end
  end
end
