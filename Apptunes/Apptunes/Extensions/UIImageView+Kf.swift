//
//  UIImageView+Kf.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    // Fetch image from a URL and put a placeholder while loading
    func setKfImage(imageURL: String, shouldHideIfNil: Bool = false) {
        let imagePlaceholder = UIImage(named: "imgPlaceholder")
        
        if let url = URL(string: imageURL) {
            self.kf.setImage(with: url,
                             placeholder: imagePlaceholder,
                             options: nil,
                             completionHandler: nil)
        } else {
            self.image = imagePlaceholder
            
            if shouldHideIfNil {
                self.hide()
            }
        }
    }
}
