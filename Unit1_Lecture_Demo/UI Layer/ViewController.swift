//
//  ViewController.swift
//  Unit1_Lecture_Demo
//
//  Created by Rolan Marat on 9/6/22.
//

import UIKit
import SkeletonView

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    private let networkService = MovieService()
    
    private var movies: [Movie] = []
    
    struct Constants {
        static let cellIdentifier = "MovieCell"
    }
    
    fileprivate func setupMovies(_ movies: ([Movie]?)) {
        if let movies = movies {
            self.movies = movies
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Movies"
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: Constants.cellIdentifier)
        
//        networkService.getPopularMoviesUsingApple { [weak self] result in
//            switch result {
//            case .success(let movies):
//                self?.setupMovies(movies)
//            case .failure(let error):
//                print(error)
//            }
//        }
        networkService.getPopularMoviesUsingAlamoFire { [weak self]  result in
            switch result {
            case .success(let movies):
                self?.setupMovies(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier,
                                                 for: indexPath)
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = movies[indexPath.row].title
        contentConfiguration.secondaryText = "\(indexPath.row)"
        cell.contentConfiguration = contentConfiguration
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController {
            if let movie = sender as? Movie {
                vc.movie = movie
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        performSegue(withIdentifier: "showMovieDetail",
                     sender: movie)
//        let movie = movies[indexPath.row]
//        let vc = UIViewController()
//        vc.view.backgroundColor = .blue
//        vc.modalTransitionStyle = .flipHorizontal
//        vc.modalPresentationStyle = .overCurrentContext
//        present(vc,
//                animated: true)
//        navigationController?.pushViewController(vc,
//                                                 animated: true)
    }
}
