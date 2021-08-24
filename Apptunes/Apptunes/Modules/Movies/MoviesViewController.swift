//
//  MoviesViewController.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/23/21.
//

import Foundation
import UIKit
import Closures
import PromiseKit
import SnapKit

class MoviesViewController: UIViewController {
    // MARK: - Properties
    private let itunesService = ItunesService()
    private var sections: [String] = []
    private var movies: [ItunesTrack] {
        return UserDataManager.shared.movies
    }
    
    // MARK: - IB Outlets
    @IBOutlet weak var moviesTableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMoviesTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTracks()
    }
    
    // MARK: - User Functions
    private func setupMoviesTableView() {
        moviesTableView.register(cellType: MovieTableViewCell.self)
        
        moviesTableView.numberOfSectionsIn { [weak self] in
            guard let self = self else { return .zero }
            
            return self.sections.count
        }
        .numberOfRows { _ in
            return 1
        }
        .heightForHeaderInSection { _ in
            return 44.0
        }
        .viewForHeaderInSection { [weak self] section in
            guard let self = self else { return UIView() }
            
            return self.moviesTableView.createHeaderView(with: self.sections[section])
        }
        .heightForRowAt { indexPath in
            return MovieTableViewCell.Constant.height
        }
        .cellForRow { [weak self] indexPath in
            guard let self = self else { return UITableViewCell() }
            
            let cell = self.moviesTableView.dequeueReusableCell(for: indexPath, cellType: MovieTableViewCell.self)
            
            let genre = self.sections[indexPath.section]
            let movies = self.movies.filter { $0.primaryGenreName == genre }
            
            cell.setup(with: movies)
            
            cell.didSelectMovie = { movie in
                print("Did select movie: ", movie)
            }
            
            return cell
        }
    }
    
    // MARK: - API Requests
    private func updateTracks() {
        itunesService.downloadTracks(completion: { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                var sectionsSet: Set<String> = []
                
                for movie in self.movies {
                    sectionsSet.insert(movie.primaryGenreName)
                }
                
                self.sections = Array(sectionsSet)
                self.sections.sort()
                
                self.moviesTableView.reloadData()
            }
        })
    }
}
// MARK: - Extensions
extension MoviesViewController: StoryboardGenerateable {
    struct Input {}
    struct Output {}

    static func generateFromStoryboard(input: Input, output: Output) -> MoviesViewController {
        let viewController = StoryboardScene.Movies.moviesViewController.instantiate()

        return viewController
    }
}
