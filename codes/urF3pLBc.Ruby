class NotesService
  attr_reader :current_user, :params, :note_params, :note, :action
  attr_accessor :status

  def initialize(current_user = nil, params = nil, note_params = nil, note = nil, action = nil)
    @current_user = current_user
    @params = params
    @note_params = note_params
    @note = note
    @action = action
  end

  def new_note
    @note = Note.new(@note_params)
    @note.doctor_id = get_doctor_id
    @note.status = NoteStatus.find_by_id_name(:draft)
    @note.order_task = OrderTask.find_by_id(params[:task_id])
    @note.current_user_id = @current_user.id
    @action = :new
    return_response
  end

  def edit_note
    @action = :edit
    @note.current_user_id = @current_user.id
    # @note.order_answer_task.order_task.order.current_user_id = @current_user.id
    return_response
  end

  def create_note
    ActiveRecord::Base.transaction do
      @note = Note.new(@note_params)
      @note.current_user_id = @current_user.id

      if try_save
        if @params[:attach]
          attach_files_to_note
        end
      end
    end

    @action = :create
    return_response
  end

  def update_note
    @note.current_user_id = @current_user.id
    @note.attributes = @note_params
    if try_save
      if @params[:attach]
        attach_files_to_note
      end
    end
    @action = :update
    return_response
  end

  def destroy_note
    @action = :destroy
    ActiveRecord::Base.transaction do
      if user_can_delete_note
        @note.mark_for_deletion = true
        @note.save!
      end
    end
    if @note.errors.full_messages.count.zero?
      {data: nil}
    else
      {errs: @note.errors.full_messages.as_json, status_code: 500, has_error: true }
    end
  end


  def define_columns_draft
    num = 1000
    column_list = Array.new


    column_list << {name: 'action_changed_at', caption: I18n.t(:date), order: (num+=1), alt_name: 'CONVERT(date, order_task_revisions.action_changed_at)', type: 'date', filter: {component: 'date', period: true, value: {startDate: nil, endDate: nil} }}
    column_list << {name: 'doctor', caption: I18n.t(:doctor_alt), order: (num+=1), preload: 'doctor', displayProp: 'name', keyProp: 'id', type: 'dictionary', model: 'User', filter: {component: 'multiselect'} }
    column_list << {name: 'product', caption: I18n.t(:product_name), order: (num+=1), alt_name: 'order_products.id', filter_name: 'order_products.id',  displayProp: 'name', keyProp: 'id', type: 'dictionary', model: 'Product', filter: {component: 'multiselect'}}
    column_list << {name: 'order_type', caption: I18n.t(:type_order), order: (num+=1), alt_name: 'order_types.id', filter_name: 'order_types.id',  displayProp: 'name', keyProp: 'id', type: 'dictionary', model: 'OrderType', filter: {component: 'multiselect'}}
    column_list << {name: 'order_task_number', caption: I18n.t(:order_hashtag), order: (num+=1), type: 'string', alt_name: 'order_tasks.number', filter: {component: 'input'}}
    column_list << {name: 'business_unit', caption: I18n.t(:business_unit), order: (num+=1), skip_key_prop: true, alt_name: 'convert(char(34), business_unit._IDRRef,1)',filter_name: 'convert(char(34), business_unit._IDRRef,1)', displayProp: 'name', keyPropm: 'id', type: 'dictionary', model: 'OrganizationStructure', filter: {component: 'multiselect', query: {type: 'business_unit'}} }
    column_list << {name: 'source_medical_case', caption: I18n.t(:revision_act_case_number), order: (num+=1), alt_name: 'medical_cases.name', type: 'string',  filter: { component: 'input' } }
    column_list << {name: 'medical_card_number', caption: I18n.t(:medical_card), order: (num+=1), alt_name: 'medical_cards.number', type: 'string', filter: {component: 'input'} }
    column_list << {name: 'executive_user', caption: I18n.t(:user_label), order: (num+=1), alt_name: 'executive_users.name', filter_name: 'executive_users.id', type: 'dictionary', model: 'User', filter: {component: 'multiselect'} }

    default_columns = [{column: 'action_changed_at', visible: true, sort_priority: 1, order_asc: false},
                       {column: 'doctor.name', visible: true},
                       {column: 'product.name', visible: true},
                       {column: 'order_type.name', visible: true},
                       {column: 'business_unit', visible: true},
                       {column: 'executive_user.name', visible: true}]

    model_name = 'NoteDraft'
    model_name_url = 'note_draft'

    return column_list, default_columns, model_name, model_name_url
  end

  def define_columns_signed
    num = 1000
    column_list = Array.new


    column_list << {name: 'signed_at', caption: I18n.t(:date), order: (num+=1), alt_name: 'CONVERT(date, notes.signed_at)', type: 'date', filter: {component: 'date', period: true, value: {startDate: nil, endDate: nil} }}
    column_list << {name: 'doctor', caption: I18n.t(:doctor_alt), order: (num+=1), preload: 'doctor', displayProp: 'name', keyProp: 'id', type: 'dictionary', model: 'User', filter: {component: 'multiselect'} }
    column_list << {name: 'product', caption: I18n.t(:product_name), order: (num+=1), alt_name: 'order_products.id', filter_name: 'order_products.id',  displayProp: 'name', keyProp: 'id', type: 'dictionary', model: 'Product', filter: {component: 'multiselect'}}
    column_list << {name: 'order_type', caption: I18n.t(:type_order), order: (num+=1), alt_name: 'order_types.id', filter_name: 'order_types.id',  displayProp: 'name', keyProp: 'id', type: 'dictionary', model: 'OrderType', filter: {component: 'multiselect'}}
    column_list << {name: 'order_task_number', caption: I18n.t(:order_hashtag), order: (num+=1), type: 'string', alt_name: 'order_tasks.number', filter: {component: 'input'}}
    column_list << {name: 'business_unit', caption: I18n.t(:business_unit), order: (num+=1), skip_key_prop: true, alt_name: 'convert(char(34), business_unit._IDRRef,1)',filter_name: 'convert(char(34), business_unit._IDRRef,1)', displayProp: 'name', keyPropm: 'id', type: 'dictionary', model: 'OrganizationStructure', filter: {component: 'multiselect', query: {type: 'business_unit'}} }
    column_list << {name: 'source_medical_case', caption: I18n.t(:revision_act_case_number), order: (num+=1), alt_name: 'medical_cases.name', type: 'string',  filter: { component: 'input' } }
    column_list << {name: 'medical_card_number', caption: I18n.t(:medical_card), order: (num+=1), alt_name: 'medical_cards.number', type: 'string', filter: {component: 'input'} }
    column_list << {name: 'signed_by', caption: I18n.t(:user_label), order: (num+=1), preload:'signed_by', displayProp: 'name', keyProp: 'id', type: 'dictionary', model: 'User', filter: {component: 'multiselect'}}

    default_columns = [{column: 'signed_at', visible: true, sort_priority: 1, order_asc: false},
                       {column: 'doctor.name', visible: true},
                       {column: 'product.name', visible: true},
                       {column: 'order_type.name', visible: true},
                       {column: 'signed_by.name', visible: true}]

    model_name = 'Note'
    model_name_url = 'note'

    return column_list, default_columns, model_name, model_name_url
  end

  def user_can_delete_note
   if @note.status.id_name != 'draft'
     @note.errors[:base] << I18n.t('note_not_draft')
     return false
   end
   unless user_is_eligible
     @note.errors[:base] << I18n.t('cant_destroy_note')
     return false
   end
   true
  end

  def try_save
    count = 0
    ActiveRecord::Base.transaction do
      if validations_passed
          @note.save!
          set_status
      end
    end
  rescue ActiveRecord::StaleObjectError
      count += 1
      retry if count < 3
      @note.errors[:base] << 'task is already executed'
      return false
  rescue ActiveRecord::RecordNotUnique
    @note.errors[:base] << 'record not unique'
      return false
  rescue => e
      @note.errors[:base] << e
      return false
    true
  end

  def set_status
    if @note_params[:order_task_answer_attributes].present?
      @note.order_task_answer.order_task = OrderTask.find_by_id(@note_params[:order_task_answer_attributes][:order_task_id])
      task =  @note.order_task_answer.order_task
      if @note_params[:is_signed] and task_is_not_done_yet

        @note.status_id = NoteStatus.find_by_id_name(:signed).id
        @note.signed_at = DateTime.server_time
        @note.signed_by_id = @current_user.id
        Ordering::TaskService.new(@current_user,nil, nil, task, nil).set_signed_answer(@note.order_task_answer.id)
        @note.save!
        params[:tasks] = [ task.id ]
        params[:current_date] = DateTime.server_time
        params[:order_id] = task.order_id
        Ordering::NotificationsService.new(@current_user, params, nil).insert_order_notifications
      else
        @note.errors[:base] << 'task is already executed' if @note_params[:is_signed]
      end
    end
  end


  def task_is_not_done_yet
    result =  OrderTask.where(id: @note_params[:order_task_answer_attributes][:order_task_id], mark_for_deletion: false)
    if result.any?
      task = result.first
      if task.answer_id.nil? and task.revision.status.id_name != 'executed'
        return true
      else
        @note.errors[:base] << 'task is already done'
        return false
      end
    else
      @note.errors[:base] << 'task does not exist'
      return false
    end
  end

  def validations_passed
    task_is_not_done_yet and user_is_eligible and is_first_draft
  end

  def is_first_draft
    task_id = @note_params[:order_task_answer_attributes][:order_task_id]
    draft_answers_for_doctor = OrderTaskAnswer.
        joins("LEFT JOIN notes ON order_task_answers.answer_type = 'Note' AND order_task_answers.answer_id = notes.id
               LEFT JOIN note_statuses ON notes.status_id = note_statuses.id").
        where("order_task_answers.order_task_id = #{task_id} AND notes.doctor_id = #{@current_user.id} AND note_statuses.id_name = 'draft'")
    if draft_answers_for_doctor.present?
      @note.errors[:base] << 'draft answer for doctor already exists'
      return false
    end
    true
  end

  def user_is_eligible
   user_is_performer and user_is_note_doctor
  end

  def user_is_note_doctor
    doctor = @note.doctor_id
    if @note_params.present?
      doctor =  @note_params[:doctor_id]
    end
    if Ordering::OrdersService.is_user_eligible_doctor(@current_user.id, doctor)
      return true
    else
      @note.errors[:base] << 'user must be doctor'
    end
  end

  def return_response
    if @note.errors.blank?
      json_object = build_json_object

      {
          note: @note.as_json(
              except: json_object[:note][:except],
              :include => json_object[:note][:include],
              methods: json_object[:note][:methods]),
          has_error: false
      }
    else
      {
          errs: @note.errors[:base],
          status_code: 500,
          has_error: true
      }
    end
  end

  def build_json_object
    case @action
      when :new
        edit_json
      when :create
        edit_json
      when :edit
        edit_json
      when :update
        edit_json
      else
        { except: [], include: {}, methods: [] }
    end
  end

  def get_doctor_id
    if @current_user.user_option.id_name == 'own'
      return @current_user.id
    end
    nil
  end

  def edit_json
    {
      note: {
        except: [ :mark_for_deletion, :doctor_id, :updated_at, :updated_by_id, :signed_by_id, :created_at ],
        :include => {
                     status: {only: [:id, :name]},
                     order_task_answer: {
                         only: [:id],
                         :include => {
                             order_task: {
                                 only: [:id, :number],
                                          :include => {
                                             revision: {
                                                 only: [:id]},
                                             order: {
                                                 only: [:id, :number], include: {
                                                     patient: {only: [:id, :name]},
                                                     medical_case: {only: [:id, :name]}},
                                                 methods: [:business_unit, :get_service_or_medicament_name]
                                             }
                                          }
                             }
                        }
                     },
                     doctor: {only: [:id, :name]},
                     created_by: {only: [ :id, :name ]},
                     signed_by: {only: [ :id, :name ]},
                     note_links: {only: [:id, :name]},
                     attach_files: {only: [:id, :name, :text, :size, :created_at], methods: [:category_object, :user_data]}

        }, methods: [:is_editable]
      }
    }
  end

  def get_doctor_list

    user_id = @current_user.id
    order_task_id =  @params[:order_task_id].present? ?  @params[:order_task_id] : nil

    filter_string = get_filter_string(order_task_id, user_id)
    sql_select = <<~SQL
        SELECT users.id, users.name
        FROM (
              SELECT user_group_members.user_id, order_products.order_id FROM order_performers
              INNER JOIN user_group_members ON order_performers.performer_id = user_group_members.user_group_id
                                               AND order_performers.performer_type = 'UserGroup'
              LEFT JOIN order_products ON order_performers.order_product_id = order_products.id
              UNION
              SELECT performer_id AS user_id, order_products.order_id FROM order_performers
              LEFT JOIN order_products ON order_products.id = order_performers.order_product_id
              WHERE order_performers.performer_type = 'User'
              ) AS performers
          LEFT JOIN users ON users.id = performers.user_id
          LEFT JOIN user_business_units ON user_business_units.user_id = users.id
          LEFT JOIN orders ON performers.order_id = orders.id
          LEFT JOIN order_tasks ON orders.id = order_tasks.order_id
        WHERE #{filter_string}
         ORDER BY users.id
    SQL

    OrderPerformer.find_by_sql(sql_select)

  end

  def get_filter_string(order_task_id, user_id)
    user_selection =  "#{user_id}"

    if @current_user.user_option.id_name == 'list_employees'
      user_selection = "IN (SELECT usr.id FROM user_option_employees
                                          INNER JOIN users AS usr ON user_option_employees.user_id = #{user_id}
                                          AND usr.employee_id = user_option_employees.employee_id)"
    end

    where_string = @current_user.user_option.id_name == 'all_employees' ? '' : " AND users.id #{user_selection}"

    filter_string = "order_tasks.id = #{order_task_id} #{where_string} AND
      (orders.business_unit_id in (user_business_units.business_unit_id)
                                                      OR limited_by_unit = 0)"

    if params[:input_term]
      filter_string += 'AND users.name LIKE :input_text '
      filter[:input_text] =  '%' + params[:input_term].to_s + '%'
    end

    filter_string += 'AND users.mark_for_deletion = 0 AND
                     doctor_interface = 1'
    return filter_string
  end


  def index_signed
    model_name = 'Note'
    base_name = Rails.configuration.database_configuration['hr_backend']['database']
    table_name = '_' + TABLE['Справочник.Подразделения']


    patient_id = params[:patient_id]

    filter_joins = ["INNER JOIN order_task_answers ON order_task_answers.answer_type = 'Note' AND order_task_answers.answer_id = notes.id",
                    "INNER JOIN order_tasks ON order_tasks.id = order_task_answers.order_task_id",
                    'INNER JOIN order_task_revisions ON order_tasks.revision_id = order_task_revisions.id',
                    'INNER JOIN orders ON orders.id = order_tasks.order_id',
                    'LEFT JOIN order_products ON order_products.order_id = orders.id',
                    'LEFT JOIN products ON order_products.product_id = products.id',
                    'LEFT JOIN order_task_statuses ON order_task_revisions.status_id = order_task_statuses.id',
                    'LEFT JOIN order_performers ON order_performers.order_product_id = order_products.id',
                    'LEFT JOIN users AS executive_users ON notes.signed_by_id = executive_users.id',
                    'LEFT JOIN order_types ON orders.order_type_id = order_types.id',
                    'LEFT JOIN order_task_statuses ON order_task_revisions.status_id = order_task_statuses.id',
                    'LEFT JOIN order_statuses ON orders.status_id = order_statuses.id',
                    'LEFT JOIN note_statuses ON notes.status_id = note_statuses.id',
                    'LEFT JOIN users AS requester_users ON orders.requester_doctor_id = requester_users.id',
                    'LEFT JOIN medical_cases ON orders.medical_case_id = medical_cases.id',
                    'LEFT JOIN medical_cards ON medical_cards.id = medical_cases.medical_card_id',
                    "LEFT JOIN [#{base_name}].[dbo].[#{table_name}] AS business_unit ON convert(char(34),
                   business_unit._IDRRef,1) = orders.business_unit_id"]


    filter = {}
    filter[:patient_id] = patient_id
    where_string = " AND orders.patient_id = :patient_id AND note_statuses.id_name = 'signed' AND notes.mark_for_deletion = 0"

    filter_string = "orders.mark_for_deletion = 0 #{where_string} "
    preload = ['status']

    columns = 'order_task_revisions.status_id, order_types.name AS order_type,
                products.name AS product, business_unit._Description AS business_unit'

    {
        model_name: model_name,
        filter_joins: filter_joins,
        filter: filter,
        columns: columns,
        preload: preload,
        filter_string: filter_string
    }
  end

  def index_draft
    model_name = 'Note'

    base_name = Rails.configuration.database_configuration['hr_backend']['database']
    table_name = '_' + TABLE['Справочник.Подразделения']

    patient_id = params[:patient_id]

    filter_joins = ["INNER JOIN order_task_answers ON order_task_answers.answer_type = 'Note' AND order_task_answers.answer_id = notes.id",
                    "INNER JOIN order_tasks ON order_tasks.id = order_task_answers.order_task_id",
                    'INNER JOIN order_task_revisions ON order_tasks.revision_id = order_task_revisions.id',
                    'INNER JOIN orders ON orders.id = order_tasks.order_id',
                    'LEFT JOIN order_products ON order_products.order_id = orders.id',
                    'LEFT JOIN order_types ON orders.order_type_id = order_types.id',
                    'LEFT JOIN products ON order_products.product_id = products.id',
                    'LEFT JOIN users AS executive_users ON order_task_revisions.action_changed_by_id = executive_users.id',
                    'LEFT JOIN order_task_statuses ON order_task_revisions.status_id = order_task_statuses.id',
                    'LEFT JOIN order_performers ON order_performers.order_product_id = order_products.id',
                    'LEFT JOIN order_task_statuses ON order_task_revisions.status_id = order_task_statuses.id',
                    'LEFT JOIN order_statuses ON orders.status_id = order_statuses.id',
                    'LEFT JOIN note_statuses ON notes.status_id = note_statuses.id',
                    'LEFT JOIN users AS requester_users ON orders.requester_doctor_id = requester_users.id',
                    'LEFT JOIN medical_cases ON orders.medical_case_id = medical_cases.id',
                    'LEFT JOIN medical_cards ON medical_cards.id = medical_cases.medical_card_id',
                    "LEFT JOIN [#{base_name}].[dbo].[#{table_name}] AS business_unit ON convert(char(34),
                   business_unit._IDRRef,1) = orders.business_unit_id"]





    filter = {}
    filter[:patient_id] = patient_id
    where_string = " AND orders.patient_id = :patient_id AND note_statuses.id_name = 'draft' AND notes.mark_for_deletion = 0"

    filter_string = "orders.mark_for_deletion = 0 #{where_string} "
    columns = 'order_products.id, order_types.id, order_tasks.number,
              order_task_revisions.status_id, order_types.name AS order_type,
                                                                products.name AS product, business_unit._Description AS business_unit, executive_users.name as executive_user'
    filter_joins, filter_string = Ordering::BasketsService.new(@current_user, nil).
        user_option_filters(filter_joins, filter_string, true, false, false)

    {
        model_name: model_name,
        filter_joins: filter_joins,
        filter: filter,
        columns: columns,
        filter_string: filter_string
    }
  end

  private
  def user_is_performer
    order = @note.order_task_answer.order_task.order
    order.current_user_id = @current_user.id
    performers = order.order_product.order_performers
    business_filter = {include_filter: true, id: order.business_unit_id}
    if Ordering::OrdersService.is_user_eligible_performer(@current_user.id, performers, business_filter)
      return true
    else
      @note.errors[:base] << 'user must be in performers'
    end
  end

  def attach_files_to_note
    @params[:parent_id] = @note.id.to_s
    @params[:model] = 'Note'
    attach = AttachFilesService.new(@current_user, @params).create
    if attach[:has_error]
      @note.errors[:base] << attach[:errs].first
    end
  end


end