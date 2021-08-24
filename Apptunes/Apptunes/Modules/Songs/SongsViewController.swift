//
//  SongsViewController.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import UIKit
import Closures
import PromiseKit
import SnapKit

class SongsViewController: UIViewController {
    // MARK: - Enums
    enum Section {
        case favorite
        case all
        
        var title: String {
            switch self {
            case .favorite: return "Favorites"
            case .all: return "All"
            }
        }
    }
    
    // MARK: - Properties
    private let itunesService = ItunesService()
    private let sections: [Section] = [.favorite, .all]
    private var songs: [ItunesTrack] {
        return UserDataManager.shared.songs
    }
    
    // MARK: - IB Outlets
    @IBOutlet weak var songsTableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSongsTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTracks()
    }
    
    // MARK: - User Functions
    private func setupSongsTableView() {
        songsTableView.register(cellType: SongTableViewCell.self)
        
        songsTableView.numberOfSectionsIn { [weak self] in
            guard let self = self else { return .zero }
            
            return self.sections.count
        }
        .numberOfRows { [weak self] _ in
            guard let self = self else { return .zero }
            
            return self.songs.count
        }
        .heightForHeaderInSection { _ in
            return 44.0
        }
        .viewForHeaderInSection { [weak self] section in
            guard let self = self else { return UIView() }
        
            return self.songsTableView.createHeaderView(with: self.sections[section].title)
        }
        .heightForRowAt { indexPath in
            return SongTableViewCell.Constant.height
        }
        .cellForRow { [weak self] indexPath in
            guard let self = self else { return UITableViewCell() }
            
            let cell = self.songsTableView.dequeueReusableCell(for: indexPath, cellType: SongTableViewCell.self)
            cell.setup(with: self.songs[indexPath.row])
            
            return cell
        }
        .didSelectRowAt { [weak self] indexPath in
            guard let self = self else { return }
            
            self.showTrackDetails(self.songs[indexPath.row])
        }
    }
    
    // MARK: - API Requests
    private func updateTracks() {
        itunesService.downloadTracks(completion: { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.songsTableView.reloadData()
            }
        })
    }
}
// MARK: - Extensions
extension SongsViewController: StoryboardGenerateable {
    struct Input {}
    struct Output {}

    static func generateFromStoryboard(input: Input, output: Output) -> SongsViewController {
        let viewController = StoryboardScene.Songs.songsViewController.instantiate()
        
        return viewController
    }
}
