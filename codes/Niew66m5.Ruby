  def get_doctor_list
    @params[:page] ||= 1
    @params[:page_limit] ||= 25

    user_id = @current_user.id
    order_task_id =  @params[:order_task_id].present? ?  @params[:order_task_id] : nil

    filter_joins = [
        "LEFT JOIN order_tasks ON order_tasks.id = #{order_task_id}",
        "LEFT JOIN orders ON orders.id = order_tasks.order_id",
        'LEFT JOIN user_business_units ON user_business_units.user_id = users.id'
    ]
    filter = {mark_for_deletion: 0, doctor_interface: 1}
    filter_string = "(user_business_units.business_unit_id = orders.business_unit_id OR limited_by_unit = 0)"

    if params[:input_term]
      filter_string += 'AND users.name LIKE :input_text '
      filter[:input_text] =  '%' + params[:input_term].to_s + '%'
    end

    user_selection =  "= #{user_id}"

    if @current_user.user_option.id_name == 'list_employees'
      user_selection = "IN (SELECT usr.id FROM user_option_employees
                                          INNER JOIN users AS usr ON user_option_employees.user_id = #{user_id}
                                          AND usr.employee_id = user_option_employees.employee_id)"
    end

    where_string = @current_user.user_option.id_name == 'all_employees' ? '' : " WHERE users.id #{user_selection}"

    if order_task_id.present?
      filter_joins << "LEFT JOIN order_products ON order_products.order_id = orders.id"
      filter_joins << "INNER JOIN (SELECT order_product_id AS product_id
              FROM order_performers
               LEFT JOIN users ON (
                    (order_performers.performer_type = 'User' AND users.id = order_performers.performer_id)
                    OR
                    (order_performers.performer_type = 'UserGroup'  AND order_performers.performer_id IN
                                                                  (SELECT user_id
                                                                    FROM user_group_members
                                                                    WHERE user_group_id = order_performers.performer_id))
                    ) #{where_string}
              GROUP BY order_product_id
             ) as performer ON performer.product_id = order_products.id"
    end


    filter_string += 'AND users.mark_for_deletion = :mark_for_deletion AND
                     doctor_interface = :doctor_interface AND performer.product_id IS NOT NULL'


    User.
        select(:id, :name).
        joins(filter_joins).
        where(filter_string, filter).
        paginate(:page => params[:page], :per_page => params[:page_limit].to_i)
  end