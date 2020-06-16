class BookmarksController < ApplicationController

  before_action :require_authentication,  only: [:index, :create, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  RESULTS_PER_PAGE = 10

  def create
    user = current_user
    success = false
    msg = FlashMessages::BOOKMARK_CREATED

    if Bookmark.exists?(user_id: user.id, profile_id: bookmark_params[:profile_id])
      success = true
    elsif Bookmark.create(user: user, profile: Profile.find(bookmark_params[:profile_id]))
      success = true
    else
      msg = FlashMessages::BOOKMARK_CREATE_ERROR
    end

    respond_to do |format|
      format.json do
        render json: {msg: msg}, status: (success ? 200 : 400)
      end
    end
  end

  def destroy
    user = current_user
    success = false
    msg = FlashMessages::BOOKMARK_REMOVED

    bookmark = Bookmark.find_by(user_id: user.id, profile_id: bookmark_params[:profile_id])
    if bookmark.blank?
      success = true
    elsif Bookmark.destroy(bookmark.id)
      success = true
    else
      msg = FlashMessages::BOOKMARK_REMOVE_ERROR
    end

    respond_to do |format|
      format.json do
        render json: {msg: msg}, status: (success ? 200 : 400)
      end
    end
  end

  # GET /salvos?categoria=:c
  def index
    @profiles = current_user.profiles.order(id: :desc)
    if params[:categoria].present?
      @profiles = @profiles.joins(:sub_categ).where(sub_categs: {alias: params[:categoria]})
    end
    @profiles = @profiles.paginate(:page => params[:page], :per_page => RESULTS_PER_PAGE)

    @filtros = @profiles.map{ |p| [p.sub_categ.name, p.sub_categ.alias] if p.sub_categ.present? && p.sub_categ.ativo? }.compact.uniq.sort
  end

private
  def bookmark_params
    params.require(:bookmark).permit(:profile_id)
  end

end