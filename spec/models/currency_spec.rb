require "rails_helper"


RSpec.describe Currency, :type => :model do
  it { expect(subject).to have_many(:collection_items) }

  it { expect(subject).to validate_presence_of(:name)  }
  it { expect(subject).to validate_presence_of(:code)  }
end
