//
//  SongTableViewCell.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import UIKit
import Reusable

class SongTableViewCell: UITableViewCell, NibReusable {
    // MARK: - Enums
    enum Constant {
        static let height: CGFloat = 84.0
    }

    // MARK: - Properties
    private let shouldAnimateWhenTapped = true
    
    // MARK: - Closures
    var wantsToFavorite: (() -> Void)?
    
    // MARK: - IB Outlets
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var trackPriceLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Class Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        setupButtonActions()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard shouldAnimateWhenTapped else { return }
        self.animateTouchDown()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard shouldAnimateWhenTapped else { return }
        self.animateTouchUp()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard shouldAnimateWhenTapped else { return }
        self.animateTouchUp()
    }
    
    // MARK: - User Functions
    private func setupButtonActions() {
        favoriteButton.onTap { [weak self] in
            guard let self = self else { return }
            
            self.wantsToFavorite?()
        }
    }
    
    /// Update cell UI with track data
    func setup(with song: ItunesTrack, isFavorite: Bool = false) {
        artworkImageView.setKfImage(imageURL: song.artworkMediumUrl)
        genreLabel.text = song.primaryGenreName
        trackNameLabel.text = song.trackName
        artistNameLabel.text = song.artistName
        trackPriceLabel.text = "\(song.currency) \(song.trackPrice)"
        
        let favoriteImage = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: favoriteImage), for: .normal)
    }
}
