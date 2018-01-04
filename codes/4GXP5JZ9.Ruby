class OrderTask < ActiveRecord::Base
  belongs_to :order, foreign_key: 'order_id'
  belongs_to :revision, class_name: 'OrderTaskRevision', foreign_key: :revision_id
  accepts_nested_attributes_for :revision, allow_destroy: true
  belongs_to :answer, class_name: 'OrderTaskAnswer', foreign_key: :answer_id
  has_one :order_type , through: :order
  has_one :status, through: :revision
  has_one :patient, through: :order
  has_one :requester_doctor, through: :order

  attr_accessor :current_user_id

  default_scope  { where(mark_for_deletion: [nil, false])}

  before_create { |object| object.created_at = DateTime.server_time; true }
  after_create :set_number
  after_save :set_revision_after_save

  def set_number
    true unless Numerator.generate_number(self, 'OrderTask', '%010d', self.created_at.strftime('%y'), true)
  end

  def set_revision_after_save
    self.revision.update_active_revision(self.id, self.revision_id)
  end

  def task_service_name
    self.order.get_service_or_medicament_name
  end

  def has_performers
    if self.order.order_product.present?
      return self.order.order_product.order_performers.present?
    end
    false
  end

  def user_is_performer
    performers = self.order.order_product.order_performers
    business_filter = {include_filter: true, id: self.order.business_unit_id}
    if Ordering::OrdersService.is_user_eligible_performer(current_user_id, performers, business_filter)
      return true
    end
    false
  end

  def is_editable
    has_performers and self.revision.status.id_name == 'registered' and
       user_is_performer
  end

  def order_answer
    @final_answer = Array.new
    if self.answer_id.present?
      signed_answer = OrderTaskAnswer.where(id: self.answer_id).first
      @final_answer = signed_answer.answer
    end
    if @final_answer.class.name == 'Note'
      json_object = {
          note: {
              except: [ :mark_for_deletion ],
              :include => {status: {only: [:id, :name]},
                           created_by: {only: [ :id, :name ]},
                           note_links: {only: [:id, :name, :link_url]},
                           attach_files: {only: [:id, :name, :ext, :size, :created_at], methods: [:category_object, :user_data]}
              },
              methods: []
          },

      }
      @final_answer.as_json(
                except: json_object[:note][:except],
                :include => json_object[:note][:include],
                methods: json_object[:note][:methods])
    end
  end

  def my_drafts
    response = {
        draft_exist: false,
        draft_answers: []
    }

    current_user = User.find_by_id(current_user_id)
    my_draft_answer = get_my_draft_answer(current_user)
    if my_draft_answer.present?
      response[:draft_exist] = true
      response[:draft_answers] << my_draft_answer
    end

    response
  end

  def get_my_draft_answer(current_user)
    joins = "INNER JOIN notes ON order_task_answers.answer_id = notes.id AND order_task_answers.answer_type = 'NOTE'
                                               INNER JOIN users ON notes.doctor_id = users.id"
    where_string = "order_task_id = #{self.id} AND is_signed = 0 AND notes.mark_for_deletion = 0"
    case current_user.user_option.id_name
      when 'own'
        where_string += " AND doctor_id = #{current_user_id}"
      when 'employees_list'
        eligible_employee_ids = current_user.user_option_employees.pluck(:employee_id)
        eligible_employee_ids = eligible_employee_ids.map {|employee_id|  "'" + employee_id.to_s + "'"}
        eligible_user_ids = User.select(:id).where("users.employee_id IN (#{eligible_employee_ids.join(', ')})").pluck(:id)
        where_string += " AND doctor_id IN (#{eligible_user_ids.join(',')})"
      else

    end
    OrderTaskAnswer.select('notes.id, users.name').joins(joins).where(where_string)
  end

end