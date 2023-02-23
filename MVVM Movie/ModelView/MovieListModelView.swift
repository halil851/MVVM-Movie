//
//  MovieListModelView.swift
//  MVVM Movie
//
//  Created by halil dikişli on 23.02.2023.
//

import Foundation

struct MovieListModelView {
    let movieList: [Result]
    
    func numberOfRowsInSection() -> Int {
        return movieList.count
    }
    /*
    func movieAtIndex(_ index: Int) -> MovieViewModel{
        let movie = movieList[index]
        return MovieViewModel(movie: movie)
    }
    */
}

struct MovieViewModel {
    let movie: Result
    
    var title: String {
        return movie.title
    }
    
    var overview: String {
        return movie.overview
    }
    
    var posterPath: String {
        return movie.poster_path
    }
    
    var voteAverage: Double {
        return movie.vote_average
    }
}
