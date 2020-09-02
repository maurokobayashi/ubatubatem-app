# == Schema Information
#
# Table name: opening_hours
#
#  id         :bigint           not null, primary key
#  profile_id :integer          not null
#  day        :integer
#  opens_at   :time
#  closes_at  :time
#  closed     :boolean          default(TRUE)
#
class OpeningHour < ApplicationRecord
  belongs_to :profile

  validates :day, presence: { message: 'Informe o dia da semana' }
  validates :opens_at, presence: { message: 'Informe o horário de abertura' }
  validates :closes_at, presence: { message: 'Informe o horário de fechamento' }
  validate :valid_hours

  enum day: { seg: 0, ter: 1, qua: 2, qui: 3, sex:4, sab:5, dom:6 }

  def day_to_s
    OpeningHour.day_to_s self.day
  end

  def self.day_to_s(day)
    case day.try(:to_sym)
      when :seg
        "Segunda-feira"
      when :ter
        "Terça-feira"
      when :qua
        "Quarta-feira"
      when :qui
        "Quinta-feira"
      when :sex
        "Sexta-feira"
      when :sab
        "Sábado"
      when :dom
        "Domingo"
      end
  end

  def humanize
    result = self.day_to_s
    if self.closed?
      result+= " - Fechado"
    else
      result+= " - #{opens_at.strftime("%Hh%M").delete_prefix("0").delete_suffix("00")} às #{closes_at.strftime("%Hh%M").delete_prefix("0").delete_suffix("00")}"
    end
  end

  def wday
    OpeningHour.days[self.day]+1
  end

private
  def valid_hours
    errors.add(:opens_at, "O horário de abertura deve anteceder ao de fechamento") if self.opens_at >= self.closes_at
  end

end
