  def download
    file_stream = AwsS3ZipStream.new
    send_data file_stream.run, filename: "video.zip", type: 'application/zip'
  end