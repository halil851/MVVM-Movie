//
//  ViewController.swift
//  MVVM Movie
//
//  Created by halil dikişli on 22.02.2023.
//

import UIKit

final class MovieHomeController: UIViewController {
    
    private var movieListViewModel: MovieListViewModel!
    
    private var serviceManager = ServiceManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceManager.delegate = self
        
        callData()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func callData() {
        let url = "https://api.themoviedb.org/3/discover/movie?api_key=959290cac471832e085651c9a892dec9"
        serviceManager.performRequest(with: url)
        
    }
    
    
    
}


extension MovieHomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? MovieHomeCell else {
            print("An error occur at cell")
            return UITableViewCell()
        }
        let movie = movieListViewModel.movieList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = movie.title
        cell.contentConfiguration = content
//        tableView.rowHeight = 200
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieListViewModel == nil ? 0 : movieListViewModel.numberOfRowsInSection()
    }
    
    
}

extension MovieHomeController: ServiceManagerDelegate{
    func getData(movie: [Result]) {
        
        movieListViewModel = MovieListViewModel(movieList: movie)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    
    
}







