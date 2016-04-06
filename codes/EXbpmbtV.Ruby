def massive_create
    if params[:contracts]
      params[:contracts].each do |contract| 
        created_contract = current_user.contracts.create(name: contract.original_filename)
        created_contract.attachments.create(
          document_file_name: contract.original_filename,
          document_content_type: contract.content_type
        )
      end
    end
    redirect_to root_path
  end