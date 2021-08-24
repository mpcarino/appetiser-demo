//
//  UIViewController+Redirections.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/24/21.
//

import Foundation
import UIKit

extension UIViewController {
    func showTrackDetails(_ track: ItunesTrack) {
        let viewController = DetailsViewController.generateFromStoryboard(input: .init(track: track), output: .init())
        
        self.present(viewController, animated: true, completion: nil)
    }
}
