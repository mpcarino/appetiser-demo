//
//  ShadowProtocol.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import UIKit

protocol ShadowProtocol {
    var shadowColor: UIColor { get set }
    var shadowRadius: CGFloat { get set }
    var shadowOpacity: CGFloat { get set }
    var shadowOffset: CGSize { get set }
}
