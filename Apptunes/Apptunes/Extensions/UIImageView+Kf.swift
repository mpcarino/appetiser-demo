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
    func setKfImage(imageURL: String, shouldHideIfNil: Bool = false) {
        if let url = URL(string: imageURL) {
            self.kf.setImage(with: url)
        } else {
            self.image = nil
            
            if shouldHideIfNil {
                self.hide()
            }
        }
    }
}
