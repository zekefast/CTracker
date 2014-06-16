require "rails_helper"


RSpec.describe Collection, :type => :model do
  it { expect(subject).to belong_to(:countries_currency)                   }
  it { expect(subject).to belong_to(:user)                                 }
  it { expect(subject).to have_one(:country).through(:countries_currency)  }
  it { expect(subject).to have_one(:currency).through(:countries_currency) }

  it { expect(subject).to validate_presence_of(:countries_currency)        }
  it { expect(subject).to validate_presence_of(:user)                      }
end
