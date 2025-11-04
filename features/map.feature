Feature: ActionMap Shows State and County Maps

Scenario: Navigating States and counties
  Given I am on the homepage
  Then I should see "National Map"
  When I click the state "CA"
  Then I should see "California"
  And I should be on the state page for "CA"
