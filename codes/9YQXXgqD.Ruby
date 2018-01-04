  def show
    @image_response = ImageResponse.find(id_param)

    if @image_response.api_client.present?
      @items_start = items_start_param
      @items_stop = items_stop_param
      @items_match_mode = match_mode_param
      @media_request = @image_response.media_request

      @catalog_items = @image_response.api_client.match_catalog_items(@image_response.name.to_s, @items_match_mode.to_sym, 'en', @items_start, @items_stop)
    end
  end