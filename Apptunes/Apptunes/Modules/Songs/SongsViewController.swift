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
import CoreData

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
    private var sections: [Section] = [.all]
    private var favoriteSongObjects: [NSManagedObject] = []
    
    private var songs: [ItunesTrack] {
        return UserDataManager.shared.songs
    }
    
    private var favoriteSongs: [ItunesTrack] {
        let songs = self.songs.filter { song in
            self.favoriteSongObjects.contains(where: {
                if let id = $0.value(forKey: "id") as? Int32 {
                    return id == song.id
                }
                
                return false
            })
        }
        
        return songs
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
        .numberOfRows { [weak self] section in
            guard let self = self else { return .zero }
            
            switch self.sections[section] {
            case .favorite: return self.favoriteSongs.count
            case .all: return self.songs.count
            }
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
            
            let song = self.getSong(using: indexPath)
            
            let isFavorite = self.favoriteSongObjects.contains(where: {
                if let id = $0.value(forKey: "id") as? Int32 {
                    return id == song.id
                }
                
                return false
            })
            
            let cell = self.songsTableView.dequeueReusableCell(for: indexPath, cellType: SongTableViewCell.self)
            cell.setup(with: song, isFavorite: isFavorite)
            
            cell.wantsToFavorite = {
                UserDataManager.shared.addFavoriteTrack(song)
                self.updateFavoriteSongs()
                self.songsTableView.reloadData()
            }
            
            return cell
        }
        .didSelectRowAt { [weak self] indexPath in
            guard let self = self else { return }
            
            self.showTrackDetails(input: .init(track: self.getSong(using: indexPath)),
                                  output: .init(wantsToUpdateFavoriteList: {
                                    self.updateFavoriteSongs()
                                    self.songsTableView.reloadData()
                                  }))
        }
    }
    
    private func updateFavoriteSongs() {
        favoriteSongObjects = UserDataManager.shared.favoriteTracks
        
        if favoriteSongs.isEmpty {
            sections = [.all]
        } else {
            sections = [.favorite, .all]
        }
    }
    
    private func getSong(using indexPath: IndexPath) -> ItunesTrack {
        switch self.sections[indexPath.section] {
        case .favorite:
            return self.favoriteSongs[indexPath.row]
        case .all:
            return self.songs[indexPath.row]
        }
    }
    
    // MARK: - API Requests
    // Fetch data from API then update favorite songs and tableview data
    private func updateTracks() {
        itunesService.downloadTracks(completion: { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.updateFavoriteSongs()
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
