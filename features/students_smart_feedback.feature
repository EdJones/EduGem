Feature: [Students] Smart Feedback 
  As a Learner
  In order to Learn faster and spend less time being stuck
  I want hints and suggestions
   that go beyond one question
   and notice if i'm missing the bigger concept

  # 
  Scenario: Single-scene feedback
    Given A drag-drop map of US geeographic features
    When Learner drops the Potomac near Mt. Ranier
    Then App can immediately suggest learner look much further to the east.

  # 
  Scenario: Cross-scene feedback
    Given A learning interactive about acceleration
    When Learner misses two questions about rate of change
    Then App asks student more basic queston(s) about velocity vs. acceleration
    And Suggests another chunk of teaching media
