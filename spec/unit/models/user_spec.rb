require "rails_helper"


RSpec.describe User, :type => :model do
  it { expect(subject).to have_many(:collections)                                    }
  it { expect(subject).to have_many(:countries_currencies).through(:collections)     }

  it { expect(subject).to validate_presence_of(:email)                               }
  it { expect(subject).to allow_value("ab@example.com").for(:email)                  }
  it { expect(subject).not_to allow_value("abc").for(:email)                         }

  it { expect(subject).to validate_presence_of(:password)                            }
  it { expect(subject).to validate_confirmation_of(:password)                        }
  it { expect(subject).to ensure_length_of(:password).is_at_least(8).is_at_most(128) }
end
