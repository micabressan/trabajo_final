 Scenario: User is able to insert date in 'Start Date', 'End Date' filter field from pop up calendar on [Finishers Placements] page

    When I navigate to 'Finishers' placement page
    Then I should see placement 'Finishers' page
    When I fill 'today' in 'Start Date' filtering field on [Finishers Placements] page
    Then I should see columns under 'Start Date' field equals with 'today' text on [Finishers Placements] page
    When I click 'Clear Filter' button on [Finishers Placements] page
    Then I should see 'all search fields empty' on [Finishers Placements] page
    When I fill 'today' in 'End Date' filtering field on [Finishers Placements] page
    Then I should see columns under 'End Date' field equals with 'today' text on [Finishers Placements] page
    When I click 'Clear Filter' button on [Finishers Placements] page
    Then I should see 'all search fields empty' on [Finishers Placements] page


  Scenario: User is able update placements 'End Date' by 'Update' button on [Finishers Placements] page

    When I navigate to 'Finishers' placement page
    Then I should see placement 'Finishers' page
    When I 'check' '1' Placement on [Live Placements] page
    And I 'check' '2' Placement on [Live Placements] page
    Then I click 'Update Status' button on [Finishers Placements] page
    When I set 'Starter' on 'Status' field on [Update Placement Status] pop-up
    And I set 'All Rate Decrease' on 'Reason' field on [Update Placement Status] pop-up
    And I set '30/08/2040' on 'End Date' field on [Update Placement Status] pop-up
    Then I click 'Update' button on [Update Placement Status] pop-up
    Then I should see '30/08/2040' end date on '1' placement on [Finishers Placements] page
    Then I should see '30/08/2040' end date on '2' placement on [Finishers Placements] page

  Scenario: User is able to navigate between pages on [Finishers Placements] page

    When I navigate to 'Finishers' placement page
    Then I should see placement 'Finishers' page
    And I get 'Live Placement Ref' on [Live Placements] page
    And I click 'Next' pagination button on [Finishers Placements] page
    Then I should see 'Next' page on [Finishers Placements] page
    When I click 'Previous' pagination button on [Finishers Placements] page
    Then I should see 'Previous' page on [Finishers Placements] page
    When I click '2' pagination button on [Finishers Placements] page
    Then I should see '2' page on [Finishers Placements] page