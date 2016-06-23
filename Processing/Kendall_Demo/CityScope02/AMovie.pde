import processing.video.*;

Movie[] movie;

// Link to movie files 
String[] movie_name = {
  //"Kendall_MobilityLG.mov"
  "Comp1.mov"
};

int movieindex = 0;

public void setupMovie() {
  //Allow canvas size to be scalable!  Generally set to 1280x1280
  
  movie = new Movie[movie_name.length];
  
  for (int i=0; i<movie.length; i++) {
    movie[i] = new Movie(this, movie_name[i]);
    movie[i].speed(.5);
    movie[i].loop();
  }
  
}

public void drawMovie() {
  movie[movieindex].read();
  image(movie[movieindex], 0, 0);
}
