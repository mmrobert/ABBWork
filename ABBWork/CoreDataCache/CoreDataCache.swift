//
//  CoreDataCache.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-22.
//

import Foundation
import SwiftUI
import CoreData

// cache to coredata (only json data)
// thumb imgae cache using third party
// framework "SDWebImageSwiftUI" buit-in cache
// set up in "AppDelegate.swift" file

class CoreDataCache {
    
    static let shared = CoreDataCache()
    
    private init() {}
    
    func cachePodCast(viewModel: PodcastViewModel) {
        
        if !isPodcastSaved(viewModel: viewModel) {
            guard let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
                return
            }
            guard let entity = NSEntityDescription.entity(forEntityName: "Podcast", in: moc) else { return }
            
            let podcast = NSManagedObject(entity: entity, insertInto: moc)
            podcast.setValue(viewModel.artistName, forKeyPath: "artistName")
            podcast.setValue(viewModel.collectionName, forKeyPath: "collectionName")
            podcast.setValue(viewModel.artworkUrl100, forKeyPath: "artworkUrl100")
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
    
    func fetchCachedPodcasts(term: String) -> [PodcastViewModel] {
        // get managed object context from AppDelegate
        guard let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return []
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Podcast")
        //let predicate = NSPredicate(format: "artistName BEGINSWITH[cd] %@", term)
        let predicate = NSPredicate(format: "artistName CONTAINS[c] %@ OR collectionName CONTAINS[c] %@", term, term)
        
        fetchRequest.predicate = predicate
        
        do {
            let podcasts = try moc.fetch(fetchRequest)
            return podcasts.map { object in
                var podcast = PodcastViewModel()
                podcast.artistName = object.value(forKey: "artistName") as? String
                podcast.collectionName = object.value(forKey: "collectionName") as? String
                podcast.artworkUrl100 = object.value(forKey: "artworkUrl100") as? String
                return podcast
            }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
            return []
        }
    }
    
    private func isPodcastSaved(viewModel: PodcastViewModel) -> Bool {
        // get managed object context from AppDelegate
        let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Podcast")
        
        let predicate = NSPredicate(format: "artistName = %@ AND collectionName = %@ AND artworkUrl100 = %@", viewModel.artistName ?? "", viewModel.collectionName ?? "", viewModel.artworkUrl100 ?? "")
        fetchRequest.predicate = predicate
        
        var podcasts: [NSManagedObject]?
        do {
            podcasts = try moc?.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        
        if podcasts?.count ?? 0 > 0 {
            return true
        } else {
            return false
        }
    }
}
