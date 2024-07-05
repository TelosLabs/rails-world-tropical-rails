# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  email                        :string           not null
#  in_app_notifications_enabled :boolean          default(TRUE)
#  mail_notifications_enabled   :boolean          default(TRUE)
#  role                         :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { build_stubbed(:user, :with_profile) }

  it "has a valid factory" do
    expect(user).to be_valid
  end
end
