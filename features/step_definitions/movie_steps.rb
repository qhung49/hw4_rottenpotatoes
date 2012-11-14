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

# From homework 3

Then /I should see sorted (.*)/ do |field|
  start = 0 if field=="title"
  start = 2 if field=="release date"
  count = 0
  list = []
  page.all("table#movies td").each do |element|
    list << element.text if (count%5==start)
    count = count + 1
  end

  list.sort!.each do |element|
    prev = list.index(element)-1
    step %{I should see "#{list[prev]}" before "#{element}"} if (prev>=0)
  end
end

Then /I should (not )?see ratings: (.*)/ do |not_see, rating_list|
  table = page.find("table#movies").text
  rating_list.split(", ").each do |rating|
    count = 0
    table.split.each do |word|
      count = count+1 if word==rating
      assert count==0 if not_see
    end
    assert count>0 if !not_see
  end
end

Then /I should see no movie/ do
  assert page.all("table#movies td").length == 0
end

Then /I should see all movies/ do
  assert page.all("table#movies td").length == 5*10
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(", ").each do |rating|
    if uncheck
      step %{I uncheck "ratings_#{rating}"}
    else 
      step %{I check "ratings_#{rating}"}
    end
  end
end

When /I press Refresh/ do
  step %{I press "ratings_submit"}
end