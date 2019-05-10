//
//  MapViewController.swift
//  Places2
//
//  Created by Michael Stoffer on 4/24/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    // MARK: - Properties and Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    var place: Place? {
        didSet {
            updateMapLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateMapLocation()
    }
    
    private func updateMapLocation() {
        guard let place = self.place,
            isViewLoaded else { return }

        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let coordinate = CLLocationCoordinate2D(latitude: place.location.latitude, longitude: place.location.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)

        mapView.setRegion(region, animated: true)
    }
}
