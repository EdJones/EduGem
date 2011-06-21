Given /^I have assessments named (.+)$/ do |names|
  names.split(', ').each do |name|
    Assessment.create!(:name => name)
  end
end
