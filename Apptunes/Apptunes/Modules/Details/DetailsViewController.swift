//
//  DetailsViewController.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/24/21.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    // MARK: - Properties
    private var track: ItunesTrack?
    
    // MARK: - Closures
    private var wantsToUpdateFavoriteList: (() -> Void)?
    
    // MARK: - IB Outlets
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var collectionNameLabel: UILabel!
    @IBOutlet private weak var trackPriceLabel: UILabel!
    @IBOutlet private weak var longDescriptionLabel: UILabel!
    @IBOutlet private weak var closeButton: DesignableButton!
    @IBOutlet private weak var playPreviewButton: DesignableButton!
    @IBOutlet private weak var viewOnWebButton: DesignableButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard track != nil else {
            self.dismiss(animated: false, completion: nil)
            return
        }
        
        setupButtonActions()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - User Functions
    private func setupButtonActions() {
        closeButton.onTap { [weak self] in
            guard let self = self else { return }
            
            self.dismiss(animated: true, completion: nil)
        }
        
        playPreviewButton.onTap { [weak self] in
            guard let self = self, let track = self.track else { return }
            
            self.openURL(track.previewUrl)
        }
        
        viewOnWebButton.onTap { [weak self] in
            guard let self = self, let track = self.track else { return }
            
            self.openURL(track.trackViewUrl)
        }
        
        favoriteButton.onTap { [weak self] in
            guard let self = self, let track = self.track else { return }
            
            UserDataManager.shared.addFavoriteTrack(track)
            self.updateFavorite()
            self.wantsToUpdateFavoriteList?()
        }
    }
    
    /// Update details UI with track data
    private func setup() {
        guard let track = track else { return }
        
        artworkImageView.setKfImage(imageURL: track.artworkLargeUrl)
        trackNameLabel.text = track.trackName
        genreLabel.text = track.primaryGenreName
        artistNameLabel.text = track.artistName
        collectionNameLabel.text = track.collectionName
        trackPriceLabel.text = "\(track.currency) \(track.trackPrice)"
        longDescriptionLabel.text = track.longDescription.isEmpty ? "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." : track.longDescription
        
        playPreviewButton.isHidden = track.previewUrl.isEmpty
        playPreviewButton.isHidden = track.trackViewUrl.isEmpty
        
        updateFavorite()
    }
    
    /// Update favorite button UI
    private func updateFavorite() {
        guard let track = track else { return }
        
        let isFavorite =  UserDataManager.shared.favoriteTracks.contains(where: {
            if let id = $0.value(forKey: "id") as? Int32 {
                return id == track.id
            }
            
            return false
        })
        
        let favoriteImage = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: favoriteImage), for: .normal)
    }
}
// MARK: - Extensions
extension DetailsViewController: StoryboardGenerateable {
    struct Input {
        let track: ItunesTrack
    }
    
    struct Output {
        let wantsToUpdateFavoriteList: (() -> Void)?
    }
    
    static func generateFromStoryboard(input: Input, output: Output) -> DetailsViewController {
        let viewController = StoryboardScene.Details.detailsViewController.instantiate()
        viewController.track = input.track
        viewController.wantsToUpdateFavoriteList = output.wantsToUpdateFavoriteList
        
        return viewController
    }
}
