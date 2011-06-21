Feature: List and manage Assessments 

    So that I can give quizzes to intrepid learners
    As a quiz creator
    I want to see a list of assessments
    And I want to add new ones

Scenario: Assessments List
    Given I have assessments named Dogs, Whendidji 
    # When I go to the list of assessments
    When I go to path "/assessments"
    Then should see "Dogs"
    And I should see "Whendidji"
    
Scenario: View Assessment
    Given I have assessments named Dogs, Whendidji 
    When I go_to_page "/assessments/index.html"
    # When I go to path "/assessments"
    Then should see "Dogs"
    And I should see "Whendidji"
    
  Scenario: User adds a new assessment
    Given I go to the new assessment page
    And I fill in "Name" with "War & Peace"
    When I press "Create"
    Then I should be on the book list page
    And I should see "War & Peace"    
    
