//
//  StoryboardGenerateable.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import UIKit

protocol StoryboardGenerateable {
    associatedtype Input
    associatedtype Output
    associatedtype ViewController: UIViewController
    
    static func generateFromStoryboard(input: Input, output: Output) -> ViewController
}
