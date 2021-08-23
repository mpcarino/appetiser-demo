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

    // MARK: - IB Outlets
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var trackPriceLabel: UILabel!
    
    // MARK: - Class Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    // MARK: - User Functions
    func setup(with itunesTrack: ItunesTrack) {
        artworkImageView.setKfImage(imageURL: itunesTrack.artworkMediumUrl)
        genreLabel.text = itunesTrack.primaryGenreName
        trackNameLabel.text = itunesTrack.trackName
        artistNameLabel.text = itunesTrack.artistName
        trackPriceLabel.text = "\(itunesTrack.currency) \(itunesTrack.trackPrice)"
    }
}
