module Site
  class DirectionsController < NamespaceController

    def index
      group       = params[:id].nil? ? nil                           : Group.find_by_id(params[:id])
      @active     = params[:id].nil? ? 0                             : group.id
      @directions = params[:id].nil? ? Direction.order(weight: :asc) : group.directions.order(weight: :asc)
      @groups     = Group.order(weight: :asc)
    end

    def show
      @direction = params[:id].nil? ? nil : Direction.find_by_id(params[:id])
      if params[:show]
        @content = true
      else
        news = @direction.new_items
        if news.count > 0
          per_page = 9
          @news = news.paginate(:page => params[:page], :per_page => per_page)
          @page = params[:page] ? params[:page] : 1
          @page_count = (@news.count().to_f/per_page.to_f).ceil
        else
          redirect_to site_direction_path(id: @direction.id, show: '1')
        end
      end

    end

  end
end