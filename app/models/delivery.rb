# == Schema Information
#
# Table name: deliveries
#
#  id                  :bigint           not null, primary key
#  profile_id          :integer          not null
#  has_delivery        :boolean          default(TRUE)
#  has_retirada        :boolean          default(FALSE)
#  has_ponto_comercial :boolean          default(FALSE)
#  delivery_fee        :integer
#  bairro_ids          :integer          default([]), is an Array
#
class Delivery < ApplicationRecord
  belongs_to :profile

  def has_bairros?
    self.bairro_ids.reject{|b| b.nil? || b==""}.present?
  end

  def bairros
    Bairro.where(id: self.bairro_ids)
  end

  def is_configured?
    configured = true
    if has_delivery
      configured = has_bairros? && delivery_fee.present?
    end
    configured
  end

end
