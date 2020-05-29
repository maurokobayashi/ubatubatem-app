# == Schema Information
#
# Table name: sub_categs
#
#  id          :bigint           not null, primary key
#  categ_id    :integer          not null
#  name        :string
#  search_tags :string
#  status      :integer          default("sugerido"), not null
#  alias       :string           not null
#
class SubCateg < ApplicationRecord
  belongs_to :categ
  has_many :profiles

  enum status: { sugerido: 0, ativo: 1, inativo: 2 }

  def profile_count
    self.profiles.count
  end
end
