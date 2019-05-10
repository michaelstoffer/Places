//
//  PlaceController.swift
//  Places2
//
//  Created by Michael Stoffer on 4/24/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import Foundation

class PlaceController {
    
    init() {
        self.loadFromPersistentStore()
    }
    
    private (set) var places: [Place] = []
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentsDirectory.appendingPathComponent("places.plist")
    }
    
    func createPlace(with name: String, latitude: Double, longitude: Double) {
        let place = Place(name: name, latitude: latitude, longitude: longitude)
        places.append(place)
        self.saveToPersistentStore()
    }
    
    func removePlace(with place: Place) {
        guard let index = places.firstIndex(of: place) else { return }
        places.remove(at: index)
        self.saveToPersistentStore()
    }
    
    // Saving
    func saveToPersistentStore() {
        guard let url = self.persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(self.places)
            try data.write(to: url)
        } catch {
            NSLog("Error saving places data: \(error)")
        }
    }
    
    // Loading
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = self.persistentFileURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            self.places = try decoder.decode([Place].self, from: data)
        } catch {
            NSLog("Error loading places data: \(error)")
        }
    }
}
