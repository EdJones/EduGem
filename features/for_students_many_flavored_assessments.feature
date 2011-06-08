Feature: (For Students) Many Flavored Assessments
  As a K-12 student (or any other)
  In order to Learn at my speed, according to my interests and abilities
  I want Immediate gratification to help me learn
   and prove that I learned.

  # 
  Scenario: 
    Then 

  # 
  Scenario: Multiple Choice--Incorrect Answer
    Given Teacher-generated quiz (multiple choice)
    When Incorrect answer is selected
    Then learner is notified
    And smart tutoring feedback engine is notified
    And penalty (if any) is calculated
    And time taken to answer is noted
    And app scoring module is notified
