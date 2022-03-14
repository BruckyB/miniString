//
//  ViewController.swift
//  mapKit
//
//  Created by JOHN BRUCKER on 1/18/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapOutlet: MKMapView!
    @IBOutlet weak var textField: UITextField!
    
    let locationManager = CLLocationManager()
    var places : [MKMapItem] = []
    var currentLocation: CLLocation!
    let alert = UIAlertController(title: "Error", message: "Please put a valid search in the search bar", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.addAction(UIAlertAction(title: "bet", style: .default, handler: nil))
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        locationManager.requestWhenInUseAuthorization()
        mapOutlet.showsUserLocation = true
        let center = CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3226)
        let region = MKCoordinateRegion(center: center,latitudinalMeters: 400, longitudinalMeters: 400)
        mapOutlet.setRegion(region, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        if textField.text != "" {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = textField.text
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response
            else{return}
            for mapItem in response.mapItems {
                self.places.append(mapItem)
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.mapOutlet.addAnnotation(annotation)
            }
            }
        } else {
            present(alert, animated: true, completion: nil)
        }
    }
    
}

