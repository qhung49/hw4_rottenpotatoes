require 'spec_helper'

describe Movie do
  describe '.find_similar_movies' do
    it 'should return an array of movies when find_similar_movies is called' do
      movie = Movie.create!(:director => 'Kitty')
      movie2 = Movie.new(:director => 'Kitty')
      movie2.find_similar_movies.should == [movie]
    end
  end
end