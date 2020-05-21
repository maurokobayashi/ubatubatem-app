# == Schema Information
#
# Table name: lead_excels
#
#  id         :bigint           not null, primary key
#  instagram  :string
#  name       :string
#  whatsapp   :string
#  website    :string
#  logradouro :string
#  numero     :string
#  bairro     :string
#  horarios   :string
#  categoria  :string
#  porte      :string
#
class LeadExcel < ApplicationRecord
end
