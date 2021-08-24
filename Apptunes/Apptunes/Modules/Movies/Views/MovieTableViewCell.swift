//
//  MovieTableViewCell.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/23/21.
//

import Foundation
import UIKit
import Reusable

class MovieTableViewCell: UITableViewCell, NibReusable {
    // MARK: - Enums
    enum Constant {
        static let height: CGFloat = 184.0
        static let width: CGFloat = 164.0
    }
    
    // MARK: - Properties
    var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
      
        layout.itemSize = CGSize(width: Constant.width, height: Constant.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12.0, bottom: 0, right: 12.0)
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    // MARK: - Closures
    var didSelectMovie: ((ItunesTrack) -> Void)?

    // MARK: - IB Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Class Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    // MARK: - User Functions
    func setup(with movies: [ItunesTrack]) {
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        collectionView.register(cellType: MovieCollectionViewCell.self)
        
        collectionView.numberOfItemsInSection { _ in
            return movies.count
        }
        .cellForItemAt { [weak self] indexPath in
            guard let self = self else { return UICollectionViewCell() }
            
            let cell = self.collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self)
            cell.setup(with: movies[indexPath.row])
            
            return cell
        }
        .didSelectItemAt { [weak self] indexPath in
            guard let self = self else { return }
            
            self.didSelectMovie?(movies[indexPath.row])
        }
    }
}
