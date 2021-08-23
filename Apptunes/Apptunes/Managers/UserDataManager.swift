//
//  UserDataManager.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/23/21.
//

import Foundation
import CoreData

class UserDataManager {
    static let shared = UserDataManager()
    
    var itunesTracks: [ItunesTrack] = []
}
