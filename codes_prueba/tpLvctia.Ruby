  has_attached_file :upload, styles: lambda { |u| u.instance.set_styles },
                             path: ':rails_root/public/data/:style/:filename',
                             url: '/data/:style/:filename'
  validates_attachment_content_type :upload,content_type: %w(image/jpg image/jpeg image/png image/gif video/webm video/mp4 application/zip)
  validates_attachment_file_name :upload, matches: [/jpe?g\z/i, /png\z/i, /gif\z/i, /webm\z/i, /mp4\z/i, /zip\z/i]
  validates_attachment_size :upload, less_than: 25.megabytes

  def set_styles
    unless @styles
      @styles = {}
      @styles[:preview] = {
        geometry: '150x150',
        format: :jpg,
        convert_options: '-quality 85 -strip'
      }

      dimensions = Paperclip::Geometry.from_file(upload.queued_for_write[:original])
      if image? && dimensions.width > 850
        @styles[:sample] = {
          geometry: '850',
          format: :jpg,
          convert_options: '-quality 90'
        }
      end
    end

    @styles
  end