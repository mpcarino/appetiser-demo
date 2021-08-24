//
//  MovieCollectionViewCell.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/23/21.
//

import Foundation
import UIKit
import Reusable

class MovieCollectionViewCell: UICollectionViewCell, NibReusable {
    // MARK: - Properties
    private let shouldAnimateWhenTapped = true
    
    // MARK: - IB Outlets
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var trackPriceLabel: UILabel!
    
    // MARK: - Class Functions
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    // MARK: - User Functions
    func setup(with itunesTrack: ItunesTrack) {
        artworkImageView.setKfImage(imageURL: itunesTrack.artworkLargeUrl)
        trackNameLabel.text = itunesTrack.trackName.isEmpty ? "-" : itunesTrack.trackName
        artistNameLabel.text = itunesTrack.artistName.isEmpty ? "-" : itunesTrack.artistName
        trackPriceLabel.text = "\(itunesTrack.currency) \(itunesTrack.trackPrice)"
    }
}
