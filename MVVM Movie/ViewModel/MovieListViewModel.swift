//
//  MovieListModelView.swift
//  MVVM Movie
//
//  Created by halil dikişli on 23.02.2023.
//

import Foundation

struct MovieListViewModel {
    let movieList: [MovieViewModel]
    
    func numberOfRowsInSection() -> Int {
        return movieList.count
    }
    
//     func movieAtIndex(_ index: Int) -> MovieViewModel{
//     let movie = movieList[index]
//         return MovieListViewModel(movies: movie)
//     }
     
}

struct MovieViewModel {
    let title: String
    let id: Int
    let posterPath: String
    let releaseDate: String
    let overview: String
    let voteAverage: Double
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
       /* var title: String {
            guard let movieTitle = movies.title else {return movies.name ?? ""}
            return movieTitle
            
        }
        
        var overview: String {
            return movies.overview
        }
        
        var posterPath: String {
            return movies.poster_path
        }
        
        var voteAverage: Double {
            return movies.vote_average
        } */
    
}
