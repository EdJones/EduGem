Feature: (Developers) Assessment Generator
  As a Developer of learning apps
  In order to Quickly build assessments (matching, multiple choice,...) into my apps
  I want a generator that does the work for me
  I want to focus on making learning fun and effective.

  # 
  Scenario: Generate True-False Bonus question
    Given Rails App development setup
    When I type "edugem g TF bonus"
    Then then educgem will fill my rails app with the partials, helpers, and controllers for a simple T/F game bonus.
