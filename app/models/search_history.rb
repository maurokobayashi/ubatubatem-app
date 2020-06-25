# == Schema Information
#
# Table name: search_histories
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  query      :string
#  result_qty :integer
#  created_at :datetime
#
class SearchHistory < ApplicationRecord
  include PgSearch::Model
    pg_search_scope :search_full,
    against: :query,
    using: {
      tsearch: {
        prefix: true,
        any_word: true
      }
    }

  belongs_to :user, optional: true

  def self.track!(user, query, result_qty)
    SearchHistory.create user: user, query: query, result_qty: result_qty
  end

end
