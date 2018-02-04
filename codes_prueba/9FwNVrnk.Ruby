class NotesController < ApplicationController
  before_action :set_note, only: [:edit, :update, :destroy]

  def grid_options_draft
    define_columns_draft
    list_options
    render json: {data: @list_options}
  end

  def index_draft_patient
    set_list_options_draft_patient
    get_default_list(nil, false, true)
    render :json =>  { data: @list }
  end

  def grid_options_signed
    define_columns_signed
    list_options
    render json: {data: @list_options}
  end

  def index_signed_patient
    set_list_options_signed_patient
    get_default_list(nil, false, true)
    render :json =>  { data: @list }
  end

  def new
    data = NotesService.new(@current_user,  params).new_note
    render json: { data: data}
  end

  def edit
    data = NotesService.new(@current_user,  params,nil, @note).edit_note
    render json: { data: data }
  end

  def create
    data = NotesService.new(@current_user, params, note_params).create_note
    return render :json => { errs: data[:errs] }, status: data[:status_code] if data[:has_error]
    render json: { data: data }
  end

  def update
    data = NotesService.new(@current_user, params, note_params, @note).update_note
    return render :json => { errs: data[:errs] }, status: data[:status_code] if data[:has_error]
    render json: { data: data }
  end

  def destroy
    data =  NotesService.new(@current_user, params, nil, @note).destroy_note
    if data.present? and data[:has_error]
      return render :json => { errs: data[:errs] }, status: data[:status_code]
    end
    render  :json => data
  end

  def get_doctor_list
    service =  NotesService.new(@current_user, params)
    render json: { data: service.get_doctor_list }
  end

  private
  def set_note
    @note = Note.find(params[:id])
  end


  def note_params
    params.require(:note).permit(:id, :note, :comment, :status_id, :is_signed, :doctor_id, :mark_for_deletion,
                                  note_links_attributes: [:id, :name, :link_url, :_destroy],
                                  order_task_answer_attributes: [ :order_task_id])
  end

  def define_columns_draft
    result = NotesService.new(@current_user, params).define_columns_draft
    set_list_column_variables(result)
  end

  def set_list_options_draft_patient
    result = NotesService.new(@current_user, params).index_draft
    set_list_option_variables(result)
  end

  def define_columns_signed
    result = NotesService.new(@current_user, params).define_columns_signed
    set_list_column_variables(result)
  end

  def set_list_options_signed_patient
    result = NotesService.new(@current_user, params).index_signed
    set_list_option_variables(result)
  end




end