# expiration
# password, locales, publicity

class PastesController < ApplicationController
  def index
    @js_data = {
      create_paste_url: pastes_path,
      expiration_types: Paste.expiration_types,
      visibility_types: Paste.visibilities
    }.to_json
  end

  def show
    @paste = Paste.find_by(share_key: params[:id])
    @paste.increment! :views
    @js_data = {
      paste: build_paste_presenter(@paste),
      links: build_links(@paste)
    }.to_json
  end

  def create
    @paste = Paste.new paste_params.merge share_key: generate_share_key

    return redirect_to(paste_path(@paste.share_key)) if @paste.save
    redirect_to pastes_path
  end

  private

  def build_paste_presenter(paste)
    {
      body: paste.body,
      title: paste.title,
      highlight: paste.highlight,
      share_key: paste.share_key,
      views: paste.views,
      created_at: paste.created_at.strftime('%d.%m.%Y')
    }
  end

  def build_links(paste)
    share_key = paste.share_key

    {
      raw_paste_url: paste_raw_path(paste_id: share_key),
      embed_paste_url: paste_embedded_url(paste_id: share_key, host: ENV['DOMAIN_URL'])
    }
  end

  def paste_params
    params.require(:paste).permit \
      :title, :body, :expiration_type, :highlight, :visibility
  end

  def generate_share_key
    SecureRandom.hex(10)
  end
end