# == Schema Information
#
# Table name: profiles
#
#  id                     :integer          not null, primary key
#  bio                    :text
#  github_url             :string
#  is_public              :boolean          default(FALSE), not null
#  job_title              :string
#  linkedin_url           :string
#  mail_notifications     :boolean          default(FALSE), not null
#  name                   :string
#  profileable_type       :string           not null
#  twitter_url            :string
#  uuid                   :string           not null
#  web_push_notifications :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  profileable_id         :integer          not null
#
# Indexes
#
#  index_profiles_on_profileable  (profileable_type,profileable_id)
#  index_profiles_on_uuid         (uuid) UNIQUE
#
require "rails_helper"

RSpec.describe Profile, type: :model do
  let(:profile) { build_stubbed(:profile, :with_user) }

  it "has a valid factory" do
    expect(profile).to be_valid
  end

  describe "callbacks" do
    let(:profile) { build(:profile, :with_user) }

    it "sets a UUID before creation" do
      profile.save
      expect(profile.uuid).to be_present
    end
  end

  describe "validations" do
    it "validates github url" do
      profile.github_url = "github.com"
      expect(profile).not_to be_valid
      profile.github_url = "https://github.com"
      expect(profile).to be_valid
    end

    it "validates linkedin url" do
      profile.linkedin_url = "linkedin.com"
      expect(profile).not_to be_valid
      profile.linkedin_url = "https://linkedin.com"
      expect(profile).to be_valid
    end

    it "validates twitter url" do
      profile.twitter_url = "x.com"
      expect(profile).not_to be_valid
      profile.twitter_url = "https://x.com"
      expect(profile).to be_valid
    end
  end
end
