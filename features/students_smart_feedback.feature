Feature: [Students] Smart Feedback 
  As a Learner
  In order to Learn faster and sepend less time being stuck
  I want hints and suggestions
    that go beyond one question
   and notice if i'm missing the bigger concept

  # 
  Scenario: Cross-scene feedback
    Given Am interactive about acceleration
    When Learner misses two questions in a row 
    Then App asks studentt more basic questons about velocity vs acceleration

  # 
  Scenario: Single0scene feedback
    Given A drag-frop map of US geeographic features
    When Learner drops the Potomac near Mt. Ranier
    Then App innediately suggests learner look much further to the east.
