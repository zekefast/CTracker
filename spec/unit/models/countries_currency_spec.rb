require "rails_helper"


RSpec.describe CountriesCurrency, :type => :model do
  it { expect(subject).to belong_to(:country)                     }
  it { expect(subject).to belong_to(:currency)                    }
  it { expect(subject).to have_many(:collections)                 }
  it { expect(subject).to have_many(:users).through(:collections) }

  it { expect(subject).to validate_presence_of(:country)          }
  it { expect(subject).to validate_presence_of(:currency)         }
end
