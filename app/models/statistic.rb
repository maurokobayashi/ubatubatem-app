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

  enum event: { perfil_view: 0, phone_click: 1, whatsapp_send: 2, instagram_click: 3, link_click: 4, compartilhar_click: 5, foto_click: 6, salvar_click: 7, address_click: 8 }
end
