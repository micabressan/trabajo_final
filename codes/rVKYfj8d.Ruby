ARR_COMPUTER_MOUSE_KEY = %w(device computer wireless usb dpi sensor relax elbow practice your\ mouse click hold onscreen display optical vertical\ wheel horizontal\ wheel personal mouse\ pad desktop plug pointer dimensions graphical designers surface)

def convert_type_of_mouse(text)
  ARR_COMPUTER_MOUSE_KEY.each do |computer_mouse|
    return 'computer-mouse' if text.downcase.include?(computer_mouse)
  end
  'animal'
end

# put the file input.txt in this directory
File.open('input.txt').each_with_index do |line, index|
  next if index.zero?
  puts convert_type_of_mouse(line)
end