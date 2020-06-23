# == Schema Information
#
# Table name: claims
#
#  id         :bigint           not null, primary key
#  profile_id :integer
#  user_id    :integer
#  uuid       :string
#  status     :integer          default("solicitado")
#
class Claim < ApplicationRecord

  before_validation :generate_uuid, on: [:create]

  belongs_to :user
  alias_attribute :requester, :user
  belongs_to :profile

  enum status: { solicitado: 0, usado: 1 }


private
  def generate_uuid
    self.uuid = SecureRandom.hex(6)
  end

end
