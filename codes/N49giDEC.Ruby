class AssetCreation
  # @param [User] user.
  # @param [Flight] flight.
  def initialize(user, flight)
    @user   = user
    @flight = flight
  end

  # @param [Hash] params.
  # @return [Asset]
  def execute(params)
    ActiveRecord::Base.transaction do
      asset = BlankAssetCreation.new(@flight).execute(params.except(:file))

      AssetUploadFile.new(asset, @user).execute(params[:file]) if params.has_key?(:file)

      UserCreatedAssetEvent.new(@user, asset).notify!

      asset
    end
  end
end