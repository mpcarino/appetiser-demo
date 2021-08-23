//
//  SongTableViewController.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import UIKit
import Closures

class SongTableViewController: UIViewController {
    // MARK: - Enums
    enum Section {
        case favorite
        case all
    }
    
    // MARK: - Properties
    private let sections: [Section] = [.favorite, .all]
    
    // MARK: - IB Outlets
    @IBOutlet weak var songsTableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSongsTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - User Functions
    private func setupSongsTableView() {
        songsTableView.register(cellType: SongTableViewCell.self)
        
        songsTableView.numberOfSectionsIn { [weak self] in
            guard let self = self else { return .zero }
            
            return self.sections.count
        }
        .numberOfRows { [weak self] _ in
            guard let self = self else { return .zero }
            
            return 50
        }
        .heightForRowAt { [weak self] indexPath in
            guard let self = self else { return .zero }
            
            return SongTableViewCell.Constant.height
        }
        .cellForRow { [weak self] indexPath in
            guard let self = self else { return UITableViewCell() }
            
            let cell = self.songsTableView.dequeueReusableCell(for: indexPath, cellType: SongTableViewCell.self)
            
            return cell
        }
        .didSelectRowAt { [weak self] indexPath in
            guard let self = self else { return }
            
        }
    }
}
// MARK: - Extensions
extension SongTableViewController: StoryboardGenerateable {
    struct Input {}
    struct Output {}

    static func generateFromStoryboard(input: Input, output: Output) -> SongTableViewController {
        let viewController = StoryboardScene.Songs.songTableViewController.instantiate()
        
        return viewController
    }
}
