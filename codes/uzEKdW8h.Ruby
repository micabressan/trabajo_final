# POST /guestlists
  def create
    @guestlist = Guestlist.new(first_name: guestlist_params["first name"], last_name: guestlist_params["last name"])

    if @guestlist.save
      render json: @guestlist, status: :created, location: @guestlist
    else
      render json: @guestlist.errors, status: :unprocessable_entity
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def guestlist_params
      params.require(:guestlist).permit("first name", "last name")
    end