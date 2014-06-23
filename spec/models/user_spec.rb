require "rails_helper"


RSpec.describe User, :type => :model do
  it { expect(subject).to validate_presence_of(:email)   }
  it { expect(subject).to validate_uniqueness_of(:email) }
  it { expect(subject).to allow_value("a@a.a", "mail@example.com").for(:email) }
  it { expect(subject).not_to allow_value("a.a", "A_example.com").for(:email)  }
  it { expect(subject).to validate_presence_of(:password) }
  it { expect(subject).to ensure_length_of(:password).is_at_least(8).is_at_most(128) }
  it { expect(subject).to validate_confirmation_of(:password) }
end
