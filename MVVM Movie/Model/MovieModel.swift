//
//  MovieModel.swift
//  MVVM Movie
//
//  Created by halil dikişli on 22.02.2023.
//

import Foundation

struct MoviesModel: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let id: Int?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let first_air_date: String?
    let title: String?
    let name: String?
    let vote_average: Double?
    
}

