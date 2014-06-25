require "rails_helper"


RSpec.describe User, :type => :model do
  it { expect(subject).to have_many(:collection_items)                      }
  it { expect(subject).to have_many(:currencies).through(:collection_items) }
  it { expect(subject).to have_many(:countries).through(:collection_items)  }

  it { expect(subject).to validate_presence_of(:email)   }
  it { expect(subject).to validate_uniqueness_of(:email) }
  it { expect(subject).to allow_value("a@a.a", "mail@example.com").for(:email) }
  it { expect(subject).not_to allow_value("a.a", "A_example.com").for(:email)  }
  it { expect(subject).to validate_presence_of(:password) }
  it { expect(subject).to ensure_length_of(:password).is_at_least(8).is_at_most(128) }
  it { expect(subject).to validate_confirmation_of(:password) }

  describe "#visited?" do
    subject { user.visited?(country) }


    context "when country is visited" do
      let(:collection_item) { FactoryGirl.create(:collection_item) }
      let(:user)            { collection_item.user                 }
      let(:country)         { collection_item.currency.country     }


      it { expect(subject).to eq(true) }
    end # when user visited country

    context "when country is not visited" do
      let(:user)    { FactoryGirl.create(:user)    }
      let(:country) { FactoryGirl.create(:country) }


      it { expect(subject).to eq(false) }
    end # when user does not visited country
  end # #visited?

  describe "collected?" do
    subject { user.collected?(currency) }


    context "when currency is collected" do
      let(:collection_item) { FactoryGirl.create(:collection_item) }
      let(:user)            { collection_item.user                 }
      let(:currency)        { collection_item.currency             }


      it { expect(subject).to eq(true) }
    end # when user collected currency

    context "when currency is not collected" do
      let(:user)     { FactoryGirl.create(:user)     }
      let(:currency) { FactoryGirl.create(:currency) }


      it { expect(subject).to eq(false) }
    end # when currency is not collected
  end # #collected?
end
