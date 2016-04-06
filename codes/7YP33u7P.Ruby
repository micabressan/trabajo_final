Then(/^I should see '(.*)' page on \[Rejected Approval Placements\] page$/) do |page|
  case page
    when 'Next'
      sleep 3
      ref_list = Array.new
      @express.live_placements_page.get_live_placements_ref_list.each do |el|
        ref_list.push(el.text)
      end
      expect(ref_list.all?{|z| @ref_list.include?(z)}).to be_falsey
    when 'Previous'
      sleep 3
      ref_list = Array.new
      @express.live_placements_page.get_live_placements_ref_list.each do |el|
        ref_list.push(el.text)
      end
      expect(ref_list.all?{|z| @ref_list.include?(z)}).to be_truthy
    else
      sleep 3
      expect(@express.rejected_approval_placements_page.current_page_button).to have_content(page)
  end
end



When(/^I click '(.*)' pagination button on \[Rejected Approval Placements\] page$/) do |page|
  case page
    when 'Next'
      @express.rejected_approval_placements_page.next_page_button.click
      sleep 2.5
      @express.rejected_approval_placements_page.wait_until_rejected_approval_placements_spinner_invisible
    when 'Previous'
      @express.rejected_approval_placements_page.prev_page_button.click
      sleep 2.5
      @express.rejected_approval_placements_page.wait_until_rejected_approval_placements_spinner_invisible
    else
      @express.rejected_approval_placements_page.click_active_page_number(page)
      sleep 2.5
      @express.rejected_approval_placements_page.wait_until_rejected_approval_placements_spinner_invisible
  end
end


When(/^I open '(.*)' actions menu item for random placement on \[Rejected Approval Placements\] page$/) do |action|
  step 'I get random placement ref on [All Placements] page'
  @express.rejected_approval_placements_page.hover_actions_menu(@number)
  sleep 2
  @express.all_placements_page.open_actions_list_menu_item(action)
end