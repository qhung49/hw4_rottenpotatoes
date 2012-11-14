require 'spec_helper'

describe MoviesController do
  describe 'searching for similar movies' do
    it 'should invoke the model to find similar movies' do
      fake_results = [mock('movie1'), mock('movie2')]
      fake_movie = Movie.new(:id => 1, :director => 'me')
      Movie.should_receive(:find).with('1').and_return(fake_movie)
      fake_movie.should_receive(:find_similar_movies).and_return(fake_results)
      post :find_similar, {:id => 1}
    end
    
    it 'should not call the model when it doesn\'t have a director' do
      fake_movie = Movie.new(:id => 3, :title => 'Alien', :director => nil)
      Movie.should_receive(:find).with('3').and_return(fake_movie)
      fake_movie.should_not_receive(:find_similar_movies)
      post :find_similar, {:id => 3}
    end
  end
end