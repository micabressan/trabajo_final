class AssetsController < ApplicationController

  respond_to :json

  # GET /campaigns/:campaign_id/assets
  def index
    @campaign = current_user.campaigns.find(params[:campaign_id])
    @assets   = InfiniteAssets.new(@campaign).fetch!(params)

    respond_with @assets
  end

  # POST /flights/:flight_id/assets
  def create
    @flight = current_user.flights.find(params[:flight_id])
    @asset  = AssetCreation.new(current_user, @flight).execute(asset_params)

    respond_with @asset
  end

  # PUT /assets/:id
  def update
    @asset = current_user.assets.find(params[:id])
    @asset = AssetUpdate.new(@asset, current_user).execute(asset_params)

    respond_with @asset
  end

  # PUT /assets/:asset_id/clear
  def clear
    @asset = current_user.assets.find(params[:asset_id])
    @asset = AssetClear.new(@asset, current_user).execute

    respond_with @asset
  end

  # DELETE /assets/:id
  def destroy
    @asset = Asset.find(params[:id])
    AssetDelete.new(@asset, current_user).execute

    head :no_content
  end

  private

  # @return [Hash]
  def asset_params
    params.permit(:flight_id, :file, :featured, :start, :end, :name, :notes, :approved, :width, :height, :pos_x, :pos_y, :cropped)
  end

end