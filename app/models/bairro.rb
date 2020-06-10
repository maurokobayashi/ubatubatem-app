# == Schema Information
#
# Table name: bairros
#
#  id     :bigint           not null, primary key
#  name   :string
#  lat    :float
#  lng    :float
#  regiao :integer
#  alias  :string
#
class Bairro < ApplicationRecord
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

  has_many :addresses

  scope :order_by_name, -> { order( name: :asc) }

  enum regiao: { centro: 0, serra: 1, sul: 2, norte: 3 }

  def profile_count
    Profile.joins(:bairro).where(bairros: {id: self.id}).count
  end

end
