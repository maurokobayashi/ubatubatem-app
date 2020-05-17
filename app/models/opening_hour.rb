# == Schema Information
#
# Table name: opening_hours
#
#  id         :bigint           not null, primary key
#  profile_id :integer
#  day        :integer
#  opens_at   :time
#  closes_at  :time
#
class OpeningHour < ApplicationRecord
  belongs_to :profile

  enum day: { seg: 0, ter: 1, qua: 2, qui: 3, sex:4, sab:5, dom:6 }

  def day_to_s
    case self.day.to_sym
      when :seg
        "Segunda"
      when :ter
        "Terça"
      when :qua
        "Quarta"
      when :qui
        "Quinta"
      when :sex
        "Sexta"
      when :sab
        "Sábado"
      when :dom
        "Domingo"
      end
  end

end
