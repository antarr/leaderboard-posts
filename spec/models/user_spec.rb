# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  login      :citext           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_login  (login) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should validate_presence_of(:login) }
  it { should validate_uniqueness_of(:login).case_insensitive }
end
