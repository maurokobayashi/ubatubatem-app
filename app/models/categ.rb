# == Schema Information
#
# Table name: categs
#
#  id          :bigint           not null, primary key
#  name        :string
#  search_tags :string
#  status      :integer
#
class Categ < ApplicationRecord
  has_many :subcategs, dependent: :destroy

  enum status: { sugerido: 0, ativo: 1, inativo: 2 }
end