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

    // MARK: - IB Outlets
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    
    // MARK: - Class Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    // MARK: - User Functions
    func setup() {
        
    }
}
