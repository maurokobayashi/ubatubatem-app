# == Schema Information
#
# Table name: sub_categs
#
#  id          :bigint           not null, primary key
#  categ_id    :integer
#  name        :string
#  search_tags :string
#  status      :integer
#
class SubCateg < ApplicationRecord
  belongs_to :categ

  enum status: { sugerido: 0, ativo: 1, inativo: 2 }
end
