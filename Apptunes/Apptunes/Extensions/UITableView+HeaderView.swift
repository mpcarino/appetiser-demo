//
//  UITableView+HeaderView.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/24/21.
//

import Foundation
import UIKit

extension UITableView {
    func createHeaderView(with title: String) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let headerLabel = UILabel()
        headerLabel.text = title
        headerLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24.0)
        
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16.0)
        }
     
        return headerView
    }
}
