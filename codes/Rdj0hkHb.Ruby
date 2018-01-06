Then /^I output (.*) Number$/ do |arg|
  case arg
  when 'Home Quote'
    puts "Q#{BROWSER.text.scan(/Q(\d+)/).to_s}"
  when 'Mobile Quote'
    puts "QM#{BROWSER.text.scan(/QM(\d+)/).to_s}"
  end
end