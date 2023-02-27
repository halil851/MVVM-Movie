//
//  ServiceManager.swift
//  MVVM Movie
//
//  Created by halil dikişli on 22.02.2023.
//

import UIKit

protocol ServiceManagerDelegate {
    func getData(movie: [MovieViewModel])
}

struct ServiceManager {
    
    var delegate: ServiceManagerDelegate?
    
    let baseURL = "https://api.themoviedb.org"
    let APIKEY = "959290cac471832e085651c9a892dec9"
    
    func getDiscoverMovies() {
        let movieDiscoverURL = "\(baseURL)/3/discover/movie?api_key=\(APIKEY)"
        performRequest(with: movieDiscoverURL)
    }
    func getDiscoverTVs() {
        let TVDiscoverURL = "\(baseURL)/3/discover/tv?api_key=\(APIKEY)"
        performRequest(with: TVDiscoverURL)
    }
    
    
    func performRequest(with url: String) {
        
        guard let url = URL(string: url) else {
            print("Error with url")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, resp, err in
            if err != nil {
                print(err?.localizedDescription ?? "Error in ServiceManager")
                return
            }
            
            guard let safeData = data else {
                print("The Data is nil!")
                return
            }
            
            if let safeMovie = self.parseJSON(safeData){
                delegate?.getData(movie: safeMovie)
            }
        }
        task.resume()
    }
    
    
    func getImages(with posterPath: String, to image: UIImageView, resolution: ResolutionOfImages) {
        let imageURL = "https://image.tmdb.org/t/p/\(resolution.rawValue)\(posterPath)"
        image.downloaded(from: imageURL, contentMode: .scaleAspectFill)
    }
    
    func parseJSON(_ data: Data) -> [MovieViewModel]? {
        let decoder = JSONDecoder()
        var movieVM = [MovieViewModel]()
        do {
            let decodedData = try decoder.decode(MoviesModel.self, from: data)
            
            for movie in decodedData.results {
                let title = movie.title ?? movie.name ?? ""
                let id = movie.id
                let posterPath = movie.poster_path
                let releasedDate = movie.release_date ?? movie.first_air_date ?? ""
                let overview = movie.overview
                let voteAverage = movie.vote_average
                
                let newMovie = MovieViewModel(title: title, id: id, posterPath: posterPath, releaseDate: releasedDate, overview: overview, voteAverage: voteAverage)
                movieVM.append(newMovie)
                
            }
                        
            return movieVM
            
            
        } catch {
            print("Couldn't parse JSON")
            return nil
        }
        
    }
    
}
