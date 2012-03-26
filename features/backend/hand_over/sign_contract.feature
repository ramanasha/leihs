Feature: Sign Contract

  In order to hand things over and sign a contract
  As a lending manager
  I want to be able to hand selected things over and generate a contract

  @javascript
  Scenario: Hand over a selection of items
    Given I am "Pius"
     When I open a hand over
      And I select an item line by assigning an inventory code
      And I click hand over
     Then I see a summary of the things I selected for hand over
     When I click hand over inside the dialog
     Then the contract is signed for the selected items
