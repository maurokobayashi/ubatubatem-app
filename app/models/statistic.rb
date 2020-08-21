# == Schema Information
#
# Table name: statistics
#
#  id         :bigint           not null, primary key
#  profile_id :integer          not null
#  event      :integer          not null
#  created_at :datetime
#
class Statistic < ApplicationRecord
  belongs_to :profile

  enum event: { perfil_view: 0, phone_click: 1, instagram_click: 2, compartilhar_click: 3, salvar_click: 4}

  def self.track!(profile, event)
    Statistic.create profile: profile, event: event
  end
end
