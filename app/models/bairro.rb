# == Schema Information
#
# Table name: bairros
#
#  id     :bigint           not null, primary key
#  name   :string
#  lat    :float
#  lng    :float
#  regiao :integer
#
class Bairro < ApplicationRecord
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

  has_many :addresses
  enum regiao: { centro: 0, serra: 1, sul: 2, norte: 3 }

end
