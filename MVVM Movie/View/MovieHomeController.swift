//
//  ViewController.swift
//  MVVM Movie
//
//  Created by halil dikişli on 22.02.2023.
//

import UIKit

final class MovieHomeController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    private var movieListViewModel = MovieListViewModel()
    private var movieList = [MovieViewModel]()
    
    private var sendOverview = String()
    private var sendPosterPath = String()
    private var lastSelected = "0"
    
   
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListViewModel.delegate = self
        button0.isSelected = true
        
        movieListViewModel.getDiscoverMovies()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func buttonsTapped(_ sender: UIButton) {
        guard let id = sender.restorationIdentifier else {print("Restoration id of button is nil"); return}
        isButtonSelected(sender)
        tableView.contentOffset = CGPoint(x: 0, y: 0)
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        
        if lastSelected == id {
            return
        }
        lastSelected = id
        
        switch id {
        case "0":
            movieListViewModel.getDiscoverMovies()
        case "1":
            movieListViewModel.getDiscoverTVs()
        case "2":
            scrollView.contentOffset = CGPoint(x: 120, y: 0)
            movieListViewModel.getTopRatedMovies()
        case "3":
            scrollView.contentOffset = CGPoint(x: 180, y: 0)
            movieListViewModel.getTopRatedTV()
        default:
            print("The Restoration ID: \(id), It is not defined to a button.")
        }
        
    }
    
    func isButtonSelected(_ button: UIButton) {
        button0.isSelected = false
        button1.isSelected = false
        button2.isSelected = false
        button3.isSelected = false
        
        button.isSelected = !button.isSelected
    }
}


extension MovieHomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? MovieHomeCell else {
            print("An error occur at cell")
            return UITableViewCell()
        }
        
        let movie = movieList[indexPath.row]
        movieListViewModel.getImages(with: movie.posterPath, to: cell.moviePoster, resolution: .low)
        
        cell.movieNameLabel.text = movie.title
        cell.releasedDate.text = movie.releaseDate
        cell.voteAverage.text = "Vote Average: \(movie.voteAverage)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sendOverview = movieList[indexPath.row].overview
        sendPosterPath = movieList[indexPath.row].posterPath
        
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



extension MovieHomeController: MovieListViewModelDelegate {
    func viewDatas(movie: [MovieViewModel]) {
        movieList = movie
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}











