//
//  ServiceManager.swift
//  MVVM Movie
//
//  Created by halil dikişli on 22.02.2023.
//

import Foundation

class ServiceManager {
    
    weak var delegate: ServiceManagerDelegate?
    
    func performRequest(with url: String) {
        
        guard let url = URL(string: url) else {
            print("Error with url")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, resp, err in
            if err != nil {
                print(err?.localizedDescription ?? "Error in ServiceManager")
            }
            
            let movie = self.parseJSON(data)
            self.delegate?.getData(movie: movie)
        }
        task.resume()
    }
    
    
    func parseJSON(_ data: Data?) -> [Result]? {
        let decoder = JSONDecoder()
        do {
            guard let dataSafe = data else {return nil}
            let decodedData = try decoder.decode(MoviesModel.self, from: dataSafe)
          
            return decodedData.results
        
        } catch {
            print("Couldn't parse JSON")
            return nil
        }
        
    }
    
}
