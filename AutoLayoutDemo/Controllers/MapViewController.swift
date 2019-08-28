//
//  MapViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-21.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var findButton: UIButton!
    @IBAction func findLocation(_ sender: Any) {
        //Clearing the previous markers...
        mapView.clear()
        
        //checking if the textfield has a value
        if (locationTextField.text == "" ){}
        else{
        let address = locationTextField.text!
        let geoCoder = CLGeocoder()
            //changing the address to coordinates
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let placemark = placemarks.first
                else {
                    // handle no location found
                    return
            }
            self.addmarker(placemark)
          }
        }
    }
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        findButton.addBorder()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.isMyLocationEnabled = true  // show my location
        mapView.settings.myLocationButton = true
        
        
        // Do any additional setup after loading the view.
    }
    func reverseGeocodeCoordinates(_ coordinates: CLLocationCoordinate2D){
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinates){response, error in
            guard let address = response?.firstResult(), let lines = address.lines
                else{
                    return
            }
            self.addressLabel.text = lines.first //.joined(separator: "\n")
        }
    }

    func addmarker(_ placemark: CLPlacemark?){
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        if let placemark = placemark{
            let lat = placemark.location!.coordinate.latitude
            let lon = placemark.location!.coordinate.longitude
    
            let position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let marker = GMSMarker(position: position)
            marker.title = placemark.locality
            marker.snippet = placemark.country
            mapView.camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 15.0)
            marker.map = mapView
            }
        locationTextField.resignFirstResponder()
    }
}
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinates(position.target)
    }
}
