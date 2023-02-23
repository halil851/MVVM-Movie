//
//  ServiceManager.swift
//  MVVM Movie
//
//  Created by halil dikişli on 22.02.2023.
//

import Foundation

protocol ServiceManagerDelegate {
    func getData(movie: [Result])
}

struct ServiceManager {
    
    var delegate: ServiceManagerDelegate?
    
    func performRequest(with urlString: String) {
        
        
        guard let url = URL(string: urlString) else {
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
    
    
    func parseJSON(_ data: Data) -> [Result]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(MoviesModel.self, from: data)
           
            
            return decodedData.results
            
        } catch {
            print("Couldn't parse JSON")
            return nil
        }
        
    }
    
}
