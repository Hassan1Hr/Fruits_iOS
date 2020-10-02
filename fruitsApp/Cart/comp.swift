//
//  comp.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 9/25/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
class comp: common , CLLocationManagerDelegate{
    // MARk:- Map
    let geocoder = GMSGeocoder()
    @IBOutlet var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    let marker = GMSMarker()
    // The currently selected place.
    var selectedPlace: GMSPlace?
    var long:Double?
    var lat:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = GMSMapView()
        mapView.delegate = self
        locationManager.delegate = self
        // add button to current location
        self.locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 20)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.last
        
        showMarker(position: userLocation!.coordinate)
        self.locationManager.stopUpdatingLocation()
    }
    func showMarker(position: CLLocationCoordinate2D){
        
        self.long = position.longitude
        self.lat = position.latitude
        geocoder.reverseGeocodeCoordinate(position) { (response, error) in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            self.marker.position = position
            self.marker.title = lines.joined(separator: "\n")
            self.marker.map = self.mapView
           // self.address.text = lines.joined(separator: "\n")
        }
        self.mapView.camera = GMSCameraPosition.camera(withLatitude: lat ?? 21.555940, longitude: long ?? 39.194628, zoom: 12.0)
    }
    
    @IBAction func gpsAction(_ sender: Any){
        self.mapView.isMyLocationEnabled = true
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = 1.0
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied , .restricted , .authorizedAlways:
            print("denied")
        @unknown default:
            print("default")
        }
    }
}
extension comp: GMSMapViewDelegate{
    //MARK - GMSMarker Dragging
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("didBeginDragging")
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("didDrag")
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("didEndDragging")
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        print("didDrag")
        // mapView.clear()
        self.showMarker(position: coordinate)
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
    }
}
