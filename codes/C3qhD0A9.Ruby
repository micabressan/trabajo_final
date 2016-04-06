Scenario: User is able to navigate between pages on [Rejected Approval Placements] page

    When I navigate to 'Rejected Approval' placement page
    Then I should see placement 'Rejected Approval' page
    And I get 'Live Placement Ref' on [Live Placements] page
    And I click 'Next' pagination button on [Rejected Approval Placements] page
    Then I should see 'Next' page on [Rejected Approval Placements] page
    When I click 'Previous' pagination button on [Rejected Approval Placements] page
    Then I should see 'Previous' page on [Rejected Approval Placements] page
    When I click '2' pagination button on [Rejected Approval Placements] page
    Then I should see '2' page on [Rejected Approval Placements] page

Scenario Outline: User is able to search on [Rejected Approval Placements] page

    When I navigate to 'Rejected Approval' placement page
    Then I should see placement 'Rejected Approval' page
    When I fill '<text>' in '<field>' filtering field on [Rejected Approval Placements] page
    Then I should see columns under '<field>' field equals with '<text>' text on [Rejected Approval Placements] page
    When I click 'Clear Filter' button on [Rejected Approval Placements] page
    Then I should see 'all search fields empty' on [Rejected Approval Placements] page
    Examples:
      | text           | field         |
      | L18174.1       | Placement Ref |
      | Echo           | Forename      |
      | Merritt        | Surname       |
      | Nec Associates | Supplier      |
      | A Company      | Company       |


  Scenario: User is able to insert date in 'Start Date', 'End Date' filter field from pop up calendar on [Rejected Approval Placements] page

    When I navigate to 'Rejected Approval' placement page
    Then I should see placement 'Rejected Approval' page
    When I fill 'today' in 'Start Date' filtering field on [Rejected Approval Placements] page
    Then I should see columns under 'Start Date' field equals with 'today' text on [Rejected Approval Placements] page
    When I click 'Clear Start Date' button on [Rejected Approval Placements] page
    Then I should see 'all search fields empty' on [Rejected Approval Placements] page
    When I fill 'today' in 'End Date' filtering field on [Rejected Approval Placements] page
    Then I should see columns under 'End Date' field equals with 'today' text on [Rejected Approval Placements] page
    When I click 'Clear End Date' button on [Rejected Approval Placements] page
    Then I should see 'all search fields empty' on [Rejected Approval Placements] page