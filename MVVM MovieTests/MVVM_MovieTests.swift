//
//  MVVM_MovieTests.swift
//  MVVM MovieTests
//
//  Created by halil dikişli on 22.02.2023.
//

import XCTest
@testable import MVVM_Movie

private var updateView: [MovieViewModel]?


final class MVVM_MovieTests: XCTestCase {
    
    
    private var serviceManager : ServiceManager!
    private var movieMockViewModel = MovieListViewModel()
    private var delegate: MockMovieViewModelDelegate!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        serviceManager = ServiceManager()
        delegate = MockMovieViewModelDelegate()
        movieMockViewModel.delegate = delegate
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testUpdateView_whenAPISuccess_showsSomething() throws {
        let mockMovie = Result(id: 0, overview: "", poster_path: "", release_date: "", first_air_date: "", title: "Game of Thrones", name: "Game of Thrones", vote_average: 0.0)
        
        movieMockViewModel.getData(movie: [mockMovie])
        
        XCTAssertEqual(updateView?.first?.title, "Game of Thrones")
    }

    func testUpdateView_whenAPIFailure_showsSomething() throws {

        movieMockViewModel.getData(movie: nil)
        XCTAssertEqual(updateView?.first?.title, "No Data")
    }

}

class MockMovieViewModelDelegate: MovieListViewModelDelegate {
    let ss = "ss"
    
    func viewDatas(movie: [MVVM_Movie.MovieViewModel]) {
        updateView = movie
    }

}

