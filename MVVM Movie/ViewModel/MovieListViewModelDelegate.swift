//
//  MovieListViewModelDelegate.swift
//  MVVM Movie
//
//  Created by halil dikişli on 6.03.2023.
//

import Foundation

protocol MovieListViewModelDelegate: AnyObject {
     func viewDatas(movie: [MovieViewModel])
}
