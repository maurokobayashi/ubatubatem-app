# == Schema Information
#
# Table name: features
#
#  id              :bigint           not null, primary key
#  profile_id      :integer          not null
#  delivery        :boolean          default(FALSE)
#  ponto_comercial :boolean          default(FALSE)
#  produtor_local  :boolean          default(FALSE)
#  vegetariano     :boolean          default(FALSE)
#  natural         :boolean          default(FALSE)
#  vegano          :boolean          default(FALSE)
#  organico        :boolean          default(FALSE)
#  lactose         :boolean          default(FALSE)
#  gluten          :boolean          default(FALSE)
#  diabetico       :boolean          default(FALSE)
#  plus_size       :boolean          default(FALSE)
#
class Feature < ApplicationRecord
  belongs_to :profile

end
