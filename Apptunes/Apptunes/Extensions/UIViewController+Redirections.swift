//
//  UIViewController+Redirections.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/24/21.
//

import Foundation
import UIKit

extension UIViewController {
    /// Present details screen with a specific track data
    func showTrackDetails(input: DetailsViewController.Input, output: DetailsViewController.Output) {
        let viewController = DetailsViewController.generateFromStoryboard(input: input, output: output)
        
        self.present(viewController, animated: true, completion: nil)
    }
}
