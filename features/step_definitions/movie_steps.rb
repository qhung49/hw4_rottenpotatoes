# Add a declarative step here for populating the DB with movies.

# Scenario 1, search_movies_by_director

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie, director|
  Movie.find_by_title(movie).director.should == director
end

# Scenario 2, search_movies_by_director

Then /I should see "(.*)" before "(.*)"/ do |movie1, movie2|
  assert (page.body =~ /#{movie1}/) < (page.body =~ /#{movie2}/)
end

Then /I should not see "(.*)" before "(.*)"/ do |movie1, movie2|
  assert (page.body =~ /#{movie1}/) > (page.body =~ /#{movie2}/)
end