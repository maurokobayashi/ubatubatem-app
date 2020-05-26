class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: []

  # GET profiles/:id
  def show
    @profile = Profile.find(params[:id])

    # instagram scraping
    if @profile.instagram_account.present?
      @instagram_scrap = scrap_from_instagram(@profile.instagram_account.username)
      # override avatar_url on profile
      if @instagram_scrap[:avatar_url] != @profile.avatar_url
        @profile.avatar_url = @instagram_scrap[:avatar_url]
        @profile.save(touch: false)
      end
    end
  end

  # GET /buscar?q=
  def search
    sleep 0.5
    per_page = 10
    @query = params[:q]
    if @query.present?
      @profiles = Profile.where("title ILIKE ? OR tagline ILIKE ?", "%#{@query}%", "%#{@query}%")
      # query_unnacent = @query.gsub(/[^0-9A-Za-z]/, '_')
      # @profiles = Profile.where("title ILIKE ? OR tagline ILIKE ?", "%#{query_unnacent}%", "%#{query_unnacent}%").limit(15)
    else
      @profiles = Profile.none
    end

    @profiles = @profiles.paginate(:page => params[:page], :per_page => per_page)

    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    def scrap_from_instagram(username)
      instagram_scrap = {}
      response = HTTParty.get("https://www.instagram.com/#{username}/?__a=1")
      if response["graphql"].present?
        logger.debug("-------------")
        instagram_scrap[:avatar_url] = response["graphql"]["user"]["profile_pic_url"]
        instagram_scrap[:avatar_url_large] = response["graphql"]["user"]["profile_pic_url_hd"]
        if response["graphql"]["user"]["edge_owner_to_timeline_media"]["count"] > 0
          instagram_scrap[:pictures] = []
          response["graphql"]["user"]["edge_owner_to_timeline_media"]["edges"].each do |post|
            instagram_scrap[:pictures].push({original: post["node"]["thumbnail_src"], thumbnail: post["node"]["thumbnail_resources"].first["src"]})
          end
        end
      end
      return instagram_scrap
    end
end
