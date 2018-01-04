require 'excon'
require 'fileutils'
require 'nokogiri'
require 'open-uri'
require 'rmagick'
require 'ruby-progressbar'

@working_directory = Dir.pwd
@headers = {
  'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
  'Accept-Language' => 'en-US,en;q=0.5',
  'Connection' => 'keep-alive',
  'DNT' => 1,
  'Host' => 'teengallery.com',
  'Upgrade-Insecure-Requests' => 1,
  'User-Agent' => 'Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101 Firefox/57.0'
}

def url_encode(str)
  return URI::encode(str).gsub("[","%5B").gsub("]","%5D")
end

# Perform an HTTP GET and parse the response
def fetch_html(uri)
  connection = Excon.new(url_encode(uri))
  response = connection.request(method:'GET', idempotent:true, retry_limit:5, headers:@headers)
  return Nokogiri::HTML(response.body)
end

# Create symlinks from image to associated image-list directories
def create_image_lists(html)
  image_num = html.css('div.maincolumn--title h1').text().split('#').last.to_i()
  image_filename = "%07d.jpg" % image_num
  filepath = "#{@working_directory}/images/#{image_filename}"
  lists = html.css('span.sidelist--name')
  lists.each_with_index do |list, i|
    list_directory = "lists/#{list.text().strip()}"
    FileUtils::mkdir_p(list_directory)
    FileUtils::ln_sf(filepath, "#{list_directory}/#{image_filename}")
  end
end

# teengallery splits fullsize images up into vertical slices. This method stitches them together
def save_fullsize_image(image_name, filepath)
  # Retrieve image slice names
  html = fetch_html("https://www.teengallery.com/fullsize.php?f=#{image_name}")
  image_slices = html.css('img').collect {|img| img['src'].split('/').last()}
  return nil if image_slices.empty?()

  # Fetch image slices
  threads = []
  image_slices.each do |slice_name|
    threads.push(Thread.new {
      url = "https://www.teengallery.com/fullslices/#{url_encode(slice_name)}"
      connection = Excon.new(url)
      response = connection.request(method:'GET', idempotent:true, retry_limit:5, headers:@headers)
      File.open("tmp/#{slice_name}", 'w') {|f| f.write(response.body)}
    })
  end
  threads.each(&:join)

  # Stitch together image slices and save to file
  image_list = Magick::ImageList.new()
  image_slices.each {|slice_name| image_list.read('tmp/' + slice_name) }
  image_list.append(false).write(filepath)

  # Cleanup tmp files
  FileUtils.rm_f(image_slices.map {|slice_name| 'tmp/' + slice_name})
end

def process_page(num)
  html = fetch_html("https://www.teengallery.com/index.php?id=#{num}")
  img = html.at_css('div#mainphoto img')
  unless img.nil? || img['src'] == '/resized/'
    img_name = img['src'].split('/').last()
    image_filename = "%07d.jpg" % num
    filepath = "#{@working_directory}/images/#{image_filename}"
    create_image_lists(html) if save_fullsize_image(img_name, filepath)
  end
end

# Setup our working directory
FileUtils.mkdir_p('images')
FileUtils.mkdir_p('tmp')

# Determine what the latest image is so we know when to stop
html = fetch_html('https://www.teengallery.com')
image_limit = html.css('div.maincolumn--title h1').text().split('#').last.to_i()

progressbar = ProgressBar.create(:title => 'Downloading Images',
                                 :total => image_limit,
                                 :format => "%a%f %b\u{15E7}%i %p%% %t",
                                 :progress_mark => ' ',
                                 :remainder_mark => "\u{FF65}"
                                )

image_number = 88093
num_threads = 16
while image_number <= image_limit
  threads = []
  (image_number..image_number+num_threads-1).each do |num|
    next if num > image_limit
    progressbar.increment()
    threads.push(Thread.new { process_page(num) })
  end
  threads.each(&:join)
  image_number += num_threads
end