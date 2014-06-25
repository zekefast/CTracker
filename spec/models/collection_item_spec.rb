require "rails_helper"


RSpec.describe CollectionItem, :type => :model do
  it { expect(subject).to belong_to(:user)                      }
  it { expect(subject).to belong_to(:currency)                  }
  it { expect(subject).to have_one(:country).through(:currency) }

  it { expect(subject).to validate_presence_of(:user)           }
  it { expect(subject).to validate_presence_of(:currency)       }
end
