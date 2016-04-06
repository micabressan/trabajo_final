When(/^I click '(.*)' pagination button on \[Finishers Placements\] page$/) do |page|
  case page
    when 'Next'
      @express.finishers_placements_page.next_page_button.click
      sleep 2
    when 'Previous'
      @express.finishers_placements_page.prev_page_button.click
      sleep 2
    else
      @express.finishers_placements_page.click_active_page_number(page)
      sleep 2
  end
end

Then(/^I should see '(.*)' page on \[Finishers Placements\] page$/) do |page|
  case page
    when 'Next'
      @express.finishers_placements_page.wait_for_finishers_placements_spinner
      wait_until {@express.finishers_placements_page.has_no_finishers_placements_spinner? == true}
      sleep 3
      ref_list = Array.new
      @express.live_placements_page.get_live_placements_ref_list.each do |el|
        ref_list.push(el.text)
      end
      expect(ref_list.all?{|z| @ref_list.include?(z)}).to be_falsey
    when 'Previous'
      @express.finishers_placements_page.wait_for_finishers_placements_spinner
      wait_until {@express.finishers_placements_page.has_no_finishers_placements_spinner? == true}
      sleep 3
      ref_list = Array.new
      @express.live_placements_page.get_live_placements_ref_list.each do |el|
        ref_list.push(el.text)
      end
      expect(ref_list.all?{|z| @ref_list.include?(z)}).to be_truthy
    else
      @express.finishers_placements_page.wait_for_finishers_placements_spinner
      wait_until {@express.finishers_placements_page.has_no_finishers_placements_spinner? == true}
      sleep 3
      expect(@express.finishers_placements_page.current_page_button).to have_content(page)
  end
end


Then(/^I should see '(.*)' end date on '(.*)' placement on \[Finishers Placements\] page$/) do |status, placement|
  sleep 2
  expect(@express.finishers_placements_page.get_finishers_placement_date(placement.to_i).value).to have_content(status)
end