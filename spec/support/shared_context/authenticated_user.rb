RSpec.shared_context "authenticated user" do
  let(:user) { FactoryGirl.create(:user) }

  before { sign_in(user) }
end
