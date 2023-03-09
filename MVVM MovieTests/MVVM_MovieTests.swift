//
//  MVVM_MovieTests.swift
//  MVVM MovieTests
//
//  Created by halil dikişli on 22.02.2023.
//

import XCTest
@testable import MVVM_Movie

var updateViewArray: [[MovieViewModel]]? = []


final class MVVM_MovieTests: XCTestCase {
    
    
    private var delegate: MocMovieService!
    private var serviceManager : ServiceManager!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        serviceManager = ServiceManager()
        delegate = MocMovieService()
        serviceManager.delegate = delegate
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testUpdateView_whenAPISuccess_showsSomething() throws {
        let mockMovie = MovieViewModel(title: "Game of Thrones", id: 2, posterPath: "", releaseDate: "", overview: "", voteAverage: 7.8)
        
        serviceManager.delegate?.getData(movie: [mockMovie])
        
        XCTAssertEqual(updateViewArray?.first?.first?.title, "Game of Thrones")
    }

    func testUpdateView_whenAPIFailure_showsSomething() throws {
        
    }

}


class MocMovieService: ServiceManagerDelegate {
    private var mockMovieViewModelDelegate = MockMovieViewModelDelegate()
    weak var delegate: MovieListViewModelDelegate?
    
    init(delegate: MovieListViewModelDelegate? = nil) {
        self.delegate = mockMovieViewModelDelegate
        
    }
    
    func getData(movie: [MVVM_Movie.MovieViewModel]) {
        delegate?.viewDatas(movie: movie)
    }
    
    
}


class MockMovieViewModelDelegate: MovieListViewModelDelegate {
    
    func viewDatas(movie: [MVVM_Movie.MovieViewModel]) {
        updateViewArray?.append(movie)
    }

}

