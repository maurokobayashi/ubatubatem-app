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

  validates :day, presence: { message: 'Informe o dia da semana' }
  validates :opens_at, presence: { message: 'Informe o horário de abertura' }
  validates :closes_at, presence: { message: 'Informe o horário de fechamento' }
  validate :valid_hours

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

  def humanize
    "#{self.day_to_s} - #{opens_at.strftime("%Hh%M").delete_prefix("0").delete_suffix("00")} às #{closes_at.strftime("%Hh%M").delete_prefix("0").delete_suffix("00")}"
  end

  def wday
    OpeningHour.days[self.day]+1
  end

private
  def valid_hours
    errors.add(:opens_at, "O horário de abertura deve anteceder ao de fechamento") if self.opens_at >= self.closes_at
  end

end
