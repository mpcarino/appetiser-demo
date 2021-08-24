//
//  UserDataManager.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/23/21.
//

import Foundation
import CoreData

class UserDataManager {
    // MARK: - Enums
    enum Constant {
        static let favoriteTrackEntityName = "FavoriteTrack"
    }
    
    static let shared = UserDataManager()
    
    var itunesTracks: [ItunesTrack] = []
    
    // Songs from all tracks data
    var songs: [ItunesTrack] {
        return self.itunesTracks.filter { $0.officialKind == .song }
    }
    
    // Movies from all tracks data
    var movies: [ItunesTrack] {
        return self.itunesTracks.filter { $0.officialKind == .movie }
    }
    
    // Favorite tracks saved from CoreData model
    var favoriteTracks: [NSManagedObject] {
        return self.getFavoriteTracks()
    }
    
    // MARK: - CoreData
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserDataStore")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    
    // MARK: - User Functions
    // Fetch favorite tracks saved in CoreData
    func getFavoriteTracks() -> [NSManagedObject] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constant.favoriteTrackEntityName)
        
        do {
            let favoriteTracks = try context.fetch(fetchRequest)
            
            return favoriteTracks
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
            return []
        }
    }
    
    // Fetch specific favorite track saved in CoreData
    func getFavoriteTrack(id: Int32) -> [NSManagedObject] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constant.favoriteTrackEntityName)
        fetchRequest.predicate = NSPredicate(format: "id = %i", id)

        var results: [NSManagedObject] = []

        do {
            results = try context.fetch(fetchRequest)
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return results
    }
    
    // If track is not existing, save. Else, delete
    func addFavoriteTrack(_ track: ItunesTrack) {
        let context = persistentContainer.viewContext
        
        if let track = getFavoriteTrack(id: Int32(track.id)).first {
            deleteFavoriteTrack(track)
        } else {
            let entity = NSEntityDescription.entity(forEntityName: Constant.favoriteTrackEntityName, in: context)!
            
            let person = NSManagedObject(entity: entity, insertInto: context)
            person.setValue(track.id, forKey: "id")
            person.setValue(track.trackName, forKey: "name")
        }
        
        saveContext()
    }
    
    func deleteFavoriteTrack(_ track: NSManagedObject) {
        let context = persistentContainer.viewContext
        
        context.delete(track)
        
        saveContext()
    }
    
    // Save changes in CoreData context if it has any
    func saveContext () {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
