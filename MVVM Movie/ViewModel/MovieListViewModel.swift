//
//  MovieListModelView.swift
//  MVVM Movie
//
//  Created by halil dikişli on 23.02.2023.
//

import UIKit

class MovieListViewModel {
    weak var delegate: MovieListViewModelDelegate?
    
    var serviceManager = ServiceManager()
    
    init(serviceManager: ServiceManager = ServiceManager()) {
        self.serviceManager = serviceManager
        self.serviceManager.delegate = self
    }
    
    let baseURL = "https://api.themoviedb.org"
    let APIKEY = "959290cac471832e085651c9a892dec9"
    
     func getDiscoverMovies() {
        let movieDiscoverURL = "\(baseURL)/3/discover/movie?api_key=\(APIKEY)"
        serviceManager.performRequest(with: movieDiscoverURL)
    }
     func getDiscoverTVs() {
        let tvDiscoverURL = "\(baseURL)/3/discover/tv?api_key=\(APIKEY)"
        serviceManager.performRequest(with: tvDiscoverURL)
    }
     func getTopRatedMovies() {
        let movieTopRatedURL = "\(baseURL)/3/movie/top_rated?api_key=\(APIKEY)"
        serviceManager.performRequest(with: movieTopRatedURL)
    }
     func getTopRatedTV() {
        let tvTopRatedURL = "\(baseURL)/3/tv/top_rated?api_key=\(APIKEY)"
        serviceManager.performRequest(with: tvTopRatedURL)
    }
    
    func getImages(with posterPath: String, to image: UIImageView, resolution: ResolutionOfImages) {
        let imageURL = "https://image.tmdb.org/t/p/\(resolution.rawValue)\(posterPath)"
        image.downloaded(from: imageURL, contentMode: .scaleAspectFill)
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

extension MovieListViewModel: ServiceManagerDelegate {
    func getData(movie: [MovieViewModel]) {
        delegate?.viewDatas(movie: movie)
    }
}
