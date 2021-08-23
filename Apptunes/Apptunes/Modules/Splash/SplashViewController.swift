//
//  SplashViewController.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    // MARK: - IB Outlets
    
    // MARK: - View Life Cycle
    
    // MARK: - User Functions
}
// MARK: - Extensions
extension SplashViewController: StoryboardGenerateable {
    struct Input {}
    struct Output {}

    static func generateFromStoryboard(input: Input, output: Output) -> SplashViewController {
        let viewController = StoryboardScene.Splash.splashViewController.instantiate()
        
        return viewController
    }
}
