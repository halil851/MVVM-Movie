//
//  ViewController.swift
//  MVVM Movie
//
//  Created by halil dikişli on 22.02.2023.
//

import UIKit

enum ResolutionOfImages: String {
    case low = "w300"
    case medium = "w500"
}

final class MovieHomeController: UIViewController {
    
    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var movieListViewModel: MovieListViewModel!
    private var serviceManager = ServiceManager()
    private var sendOverview = String()
    private var sendPosterPath = String()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceManager.delegate = self
        
        if let boldFont = UIFont(name: "Helvetica-Bold", size: 16.0){
            segmentedControlOutlet.setTitleTextAttributes([NSAttributedString.Key.font: boldFont], for: .normal)
        }
        
        serviceManager.getDiscoverMovies()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        let index = segmentedControlOutlet.selectedSegmentIndex
        
        switch index {
        case 0:
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
            serviceManager.getDiscoverMovies()
        case 1:
            scrollView.contentOffset = CGPoint(x: 40, y: 0)
            serviceManager.getDiscoverTVs()
        case 2:
            scrollView.contentOffset = CGPoint(x: 140, y: 0)
            serviceManager.getTopRatedMovies()
        case 3:
            scrollView.contentOffset = CGPoint(x: 200, y: 0)
            serviceManager.getTopRatedTV()
        default:
            print("")
        }
    }
}


extension MovieHomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? MovieHomeCell else {
            print("An error occur at cell")
            return UITableViewCell()
        }
        
        let movie = movieListViewModel.movieList[indexPath.row]
        cell.movieNameLabel.text = movie.title
        cell.releasedDate.text = movie.releaseDate
        cell.voteAverage.text = "Vote Average: \(movie.voteAverage)"
        
        serviceManager.getImages(with: movie.posterPath, to: cell.moviePoster, resolution: .low)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return movieListViewModel == nil ? 0 : movieListViewModel.movieList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sendOverview = movieListViewModel.movieList[indexPath.row].overview
        sendPosterPath = movieListViewModel.movieList[indexPath.row].posterPath
        
        performSegue(withIdentifier: "overview", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "overview" {
            guard let destinationVC = segue.destination as? OverviewVC else {return}
            destinationVC.overview = sendOverview
            destinationVC.posterPath = sendPosterPath
        }
    }
}

extension MovieHomeController: ServiceManagerDelegate{
    internal func getData(movie: [MovieViewModel]) {
        
        movieListViewModel = MovieListViewModel(movieList: movie)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}







