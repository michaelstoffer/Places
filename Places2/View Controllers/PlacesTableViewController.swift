//
//  PlacesTableViewController.swift
//  Places2
//
//  Created by Michael Stoffer on 4/24/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController {

    // MARK: - IBOutlets and Properties
    @IBOutlet weak var locationNameTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    let placeController = PlaceController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeController.places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)

        let place = self.placeController.places[indexPath.row]
        cell.textLabel?.text = place.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let place = self.placeController.places[indexPath.row]
        self.placeController.removePlace(with: place)
        self.tableView.deleteRows(at: [indexPath], with: .none)
        self.tableView.reloadData()
    }

    // MARK: - IBActions and Methods
    @IBAction func savePlaceButtonTapped(_ sender: Any) {
        guard let name = self.locationNameTextField.text,
            let latitudeString = self.latitudeTextField.text,
            let longitudeString = self.longitudeTextField.text,
            let latitude = Double(latitudeString),
            let longitude = Double(longitudeString)
            else { return }
        
        self.placeController.createPlace(with: name, latitude: latitude, longitude: longitude)
        self.clearInputs()
        
        self.tableView.reloadData()
    }
    
    private func clearInputs() {
        self.locationNameTextField.text = nil
        self.latitudeTextField.text = nil
        self.longitudeTextField.text = nil
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMapView" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let mapViewController = segue.destination as? MapViewController else { return }
            
            let place = self.placeController.places[indexPath.row]
            
            mapViewController.place = place
        }
    }
}
