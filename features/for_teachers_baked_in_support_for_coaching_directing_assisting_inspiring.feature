Feature: (For Teachers) Baked in support for coaching, directing, assisting, inspiring. 
  As a Teacher
  In order to Give my students all the help I can and give parents and community evidence I did
  I want Hooks for smart hinting/feedback engines,
  I want Support for LMS like Edu2.0
  I want Developers to focus on the learning experience, not reinventing the wheel.
  I want To create my own interactive assessments

  # 
  Scenario: User-customized matching
    Given A deployed learning app
    When Teacher/developer  enters custom editor
    Then Forms for entering two lists of concepts are presented
    And User can select which pairs are "correct" matches
    And User can save assesment for future use by students
