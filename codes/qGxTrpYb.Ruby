def index
    @page = params[:page].to_i || 1

    if @page < 1
      @page = 1
    end

    offset = (@page - 1)* 10

    @search = params[:search] || ''

    if @search != ''
      @designers = User.find(:all, 
            :joins => 'LEFT JOIN "follows" ON "follows"."followee_id" = "users"."id" 
                   LEFT JOIN "projects" ON ("projects"."user_id" = "users"."id" and "projects"."active" = \'t\')',  
            :select => 'users.*, count(follows.id) as followers_count, count(projects.id) as projects_count, count(projects.competition_id) as entries_count', 
            :conditions => ['visible = ? AND access = ? AND (lower(name) LIKE ? OR lower(location) LIKE ?)', true, User.DESIGNER, "%#{@search.gsub(' ', '%').downcase}%", "%#{@search.gsub(' ', '%').downcase}%"],
            :group => '"users"."id"', 
            :order => 'followers_count DESC, entries_count DESC, projects_count DESC, users.id ASC',
            :limit => 10,
            :offset => offset
           )

      #@designers = User.where('access = ? AND (name LIKE ?)', User.DESIGNER, "%#{@search.gsub(' ', '%')}%").limit(10).offset(offset)
    else
    
      @designers = User.find(:all, 
            :joins => 'LEFT JOIN "follows" ON "follows"."followee_id" = "users"."id" 
                   LEFT JOIN "projects" ON ("projects"."user_id" = "users"."id" and "projects"."active" = \'t\')',  
            :select => 'users.*, count(follows.id) as followers_count, count(projects.id) as projects_count, count(projects.competition_id) as entries_count', 
            :conditions => { :access => User.DESIGNER, :visible => true },
            :group => '"users"."id"', 
            :order => 'followers_count DESC, entries_count DESC, projects_count DESC, users.id ASC',
            :limit => 10,
            :offset => offset
           )
    end

    @more_pages = (offset+10) < User.where('access = ?', User.DESIGNER).count
		@number_of_pages = ((User.where('access = ?', User.DESIGNER).count + 9)/10).floor
  end

  def show
    if params[:username]
      if is_integer? params[:username]
        @user = User.find(params[:username]) rescue nil
      else
        @user = User.where('lower(username) = ?', params[:username].downcase).first
      end
    else
      redirect_to "/#{current_user.identifier}" and return
    end

    if (not @user) or (not @user.visible) 
      render_404_page and return
    else
      @likes = @user.likes.joins('INNER JOIN projects ON projects.id = thing_id').where('object_type = ?', getLikeObjectType(:project)).order('likes.created_at DESC')
      @follows = @user.followees.order('created_at DESC').limit(4)
      @comments = @user.comments.joins(:project).order('comments.created_at DESC').limit(4)
      @is_current_user = (signed_in? and current_user.id == @user.id)
      @recent_activity = ((@likes.count + @follows.count + @comments.count) > 0)
	  @is_client = @user.is_client?

      places = @user.projects.select('place, count(*) as total, created_at').where('place is not null').group(:place, :created_at)
      @winner = @user.projects.select { |p| p.place == 1 }.count rescue 0
      @runner = @user.projects.select { |p| p.place == 2 }.count rescue 0
    end

    if @is_current_user
      @notifications = @user.notifications
      @transactions = @user.transactions.order('created_at DESC')
      @active_dialogs = @user.dialogs.active
      @deleted_dialogs = @user.dialogs.deleted
      @unread_notifications_count = @notifications.select{ |n| n.viewed == false }.count
      @unread_messages_count = Message.where(recipient_id: @user.id, viewed: false).count
      total_items_to_purchase # call this to get @winners variable
      @shopping_list = @winners.reject do |project|
        project.orders.select{ |o| o.status == 'Completed.' }.count > 0
      end
    end
  end