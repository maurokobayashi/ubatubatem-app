# == Schema Information
#
# Table name: lists
#
#  id              :bigint           not null, primary key
#  cover_image_url :string
#  title           :string
#  subtitle        :string
#  profile_ids     :integer          default([]), is an Array
#  starts_at       :time
#  finishes_at     :time
#  expires_on      :datetime
#  priority        :integer
#  status          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class List < ApplicationRecord
  enum priority: { normal: 0, alta: 1, exibir_em_primeiro: 2 }
  enum status: { inativo: 0, ativo: 1 }
end
