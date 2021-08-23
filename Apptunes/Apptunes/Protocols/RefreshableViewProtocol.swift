//
//  RefreshableViewProtocol.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import UIKit

protocol RefreshableViewProtocol {
    func refresh()
}

extension RefreshableViewProtocol where Self: UIView {
    func refresh() {
        self.setNeedsDisplay()
        self.setNeedsLayout()
    }
}
