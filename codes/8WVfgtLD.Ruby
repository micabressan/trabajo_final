  def kill_job
    @job = Delayed::Backend::ActiveRecord::Job.find_by_owner_id_and_owner_type(@filetable_ecr_task.ecr_id,@filetable_ecr_task.ecr.name)
    if @job
      @job.destroy!
      @filetable_ecr_task.update_attributes(status:5,progress:100)
      redirect_to filetable_ecr_tasks_path, notice: t('job_deleted')
    else
      @filetable_ecr_task.update_attributes(status:5,progress:100)
      redirect_to filetable_ecr_tasks_path, notice: t('job_deleted')
    end
  end