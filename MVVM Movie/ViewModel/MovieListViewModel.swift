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
    
}

struct MovieViewModel {
    let title: String
    let id: Int
    let posterPath: String
    let releaseDate: String
    let overview: String
    let voteAverage: Double
 
}
