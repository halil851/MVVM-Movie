//
//  ViewController.swift
//  MVVM Movie
//
//  Created by halil dikişli on 22.02.2023.
//

import UIKit

class MovieHomeController: UIViewController {
    
    private var movieListModelView: MovieListModelView!
    
    var serviceManager = ServiceManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceManager.delegate = self
        
        callData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func callData() {
        let url = "https://api.themoviedb.org/3/discover/movie?api_key=959290cac471832e085651c9a892dec9"
        serviceManager.performRequest(with: url)
        
    }
    
    
    
}


extension MovieHomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        let movie = movieListModelView.movieList[indexPath.row]
        cell.textLabel?.text = movie.title
        
        
        /* var content = cell.defaultContentConfiguration()
         content.text = "sada"
         cell.contentConfiguration = content */
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieListModelView == nil ? 0 : movieListModelView.numberOfRowsInSection()
    }
    
    
}

extension MovieHomeController: ServiceManagerDelegate{
    func getData(movie: [Result]) {
        
        movieListModelView = MovieListModelView(movieList: movie)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    
    
}







