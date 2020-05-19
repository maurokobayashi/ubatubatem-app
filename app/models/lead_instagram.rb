# == Schema Information
#
# Table name: lead_instagrams
#
#  id                :bigint           not null, primary key
#  instagram_user_id :string
#  username          :string
#  title             :string
#  avatar_url        :string
#  created_at        :datetime
#
class LeadInstagram < ApplicationRecord
end
