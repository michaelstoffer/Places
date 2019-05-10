//
//  Place.swift
//  Places2
//
//  Created by Michael Stoffer on 4/24/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import Foundation

struct Coordinate: Equatable, Codable {
    var latitude: Double
    var longitude: Double
}

class Place: Equatable, Codable {
    let name: String
    let location: Coordinate
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.location = Coordinate(latitude: latitude, longitude: longitude)
    }
    
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.name == rhs.name && lhs.location == rhs.location
    }
}
