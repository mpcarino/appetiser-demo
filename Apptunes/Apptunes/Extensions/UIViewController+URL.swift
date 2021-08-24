//
//  UIViewController+URL.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import UIKit

extension UIViewController {
    /// Open Safari with a URL
    func openURL(_ stringURL: String) {
        if let url = URL(string: stringURL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
