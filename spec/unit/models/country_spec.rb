require "rails_helper"


RSpec.describe Country, :type => :model do
  it { expect(subject).to have_one(:countries_currency)                       }
  it { expect(subject).to have_many(:currencies).through(:countries_currency) }

  it { expect(subject).to validate_presence_of(:name)                         }
  it { expect(subject).to validate_presence_of(:code)                         }
  it { expect(subject).to validate_uniqueness_of(:code)                       }
end
