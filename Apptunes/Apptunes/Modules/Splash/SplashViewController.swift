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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            
            self.setupMainControllers()
        }
    }
    
    // MARK: - User Functions
    // Setup app main controller after displaying splash screen
    private func setupMainControllers() {
        let viewController = StoryboardScene.Main.initialScene.instantiate()
        
        self.navigationController?.viewControllers = [viewController]
    }
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
