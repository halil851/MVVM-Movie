//
//  UserService.swift
//  MVVM Movie
//
//  Created by halil dikişli on 3.03.2023.
//

import Foundation

protocol ServiceManagerDelegate: AnyObject {
    func getData(movie: [MovieViewModel])
    
}

