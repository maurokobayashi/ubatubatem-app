class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: []

  def show
    @profile = Profile.find(params[:id])

    # instagram scraping
    @instagram_scrap = {}
    if @profile.instagram_account.present?
      response = HTTParty.get("https://www.instagram.com/#{@profile.instagram_account.username}/?__a=1")
      bio = response["graphql"].present? ? response["graphql"]["user"]["biography"] : nil
      if response["graphql"].present?
        @instagram_scrap[:avatar_url] = response["graphql"]["user"]["profile_pic_url"]
        if response["graphql"]["user"]["edge_owner_to_timeline_media"]["count"] > 0
          @instagram_scrap[:pictures] = []
          response["graphql"]["user"]["edge_owner_to_timeline_media"]["edges"].each do |post|
            @instagram_scrap[:pictures].push({original: post["node"]["thumbnail_src"], thumbnail: post["node"]["thumbnail_resources"].first["src"]})
          end
        end

        # override avatar_url on profile
        if @instagram_scrap[:avatar_url] != @profile.avatar_url
          @profile.avatar_url = @instagram_scrap[:avatar_url]
          @profile.save
        end
      end
    end

  end

  # get @ /buscar?q=
  def search
    @query = params[:q]
    if @query.present?
      @profiles = Profile.where("title ILIKE ? OR tagline ILIKE ?", "%#{@query}%", "%#{@query}%").limit(15)
    else
      @profiles = []
    end
  end
end
