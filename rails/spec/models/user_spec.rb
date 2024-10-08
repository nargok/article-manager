require 'rails_helper'

RSpec.describe User, type: :model do
  context "factoryのデフォルトに従った場合" do
    let(:user) { create(:user) }

    it "認証済のuserレコードを正常に新規作成できる" do
      expect(user).to be_valid
      expect(user).to be_confirmed
    end
  end
end
