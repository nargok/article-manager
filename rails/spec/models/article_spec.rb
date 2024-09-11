require 'rails_helper'

RSpec.describe Article, type: :model do
  context "factoryのデフォルト設定に従った時" do
    subject { create(:article) }

    it "正常にレコードを新規作成できる" do
      expect { subject }.to change { Article.count }.by(1)
    end
  end

  describe "Validations" do
    subject { article.valid? }

    let(:article) { build(:article, title: , content:, status:, user:) }
    let(:title) { Faker::Lorem.sentence }
    let(:content) { Faker::Lorem.paragraph }
    let(:status) { :published }
    let(:user) { create(:user) }

    context "すべての値が正常な時" do
      it "検証が通る" do
        expect(subject).to be_truthy
      end
    end

    context "ステータスが公開済み, タイトルが空のとき" do
      let(:title) { "" }

      it "エラーメッセージが返る" do
        expect(subject).to be_falsy
        expect(article.errors.full_messages).to eq ["タイトルを入力してください"]
      end
    end

    context "ステータスが公開済み, 本文が空のとき" do
      let(:content) { "" }

      it "エラーメッセージが返る" do
        expect(subject).to be_falsy
        expect(article.errors.full_messages).to eq ["本文を入力してください"]
      end
    end

    context "ステータスが未保存かつ、すでに同一ユーザーが未保存の記事を登録していた時" do
      let(:status) { :unsaved }
      before { create(:article, status: :unsaved, user:) }

      it "例外が発生" do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
