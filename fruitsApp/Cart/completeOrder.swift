//
//  completeOrder.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 9/22/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import DropDown
import GoogleMaps
import GooglePlaces
class completeOrder: common , CLLocationManagerDelegate{
    let datePicker = UIDatePicker()
    let dropDown = DropDown()
    
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
    
    
    
    var cartID: Int?
    var promoCode: String?
    var availableId: Int?
    var availableTimes = [availableTimeData]()
    
    @IBOutlet var deliveryDate: UITextField!
    @IBOutlet var notes: UITextView!
    @IBOutlet var time: UITextField!
    @IBOutlet var address: UILabel!
    @IBOutlet var totalCost: UILabel!
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.delegate = self
        locationManager.delegate = self
        // add button to current location
        self.locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 20)
 
        time.delegate = self
        showDatePicker()
        getAvailableTimes()
    }
    @IBAction func dropDown(_ sender: UIButton) {
        dropDown.anchorView = (sender as AnchorView)
        dropDown.dataSource = parsingData(self.availableTimes)
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = {
            [unowned self](index : Int , item : String) in
            self.time.text = self.dropDown.selectedItem
            self.availableId = index
        }
        dropDown.show()
    }
    @IBAction func submit(){
        self.loading()
        let url = AppDelegate.LocalUrl + "checkout"
        let headers = [
            "Content-Type": "application/json" ,
            "Accept" : "application/json",
            "Authorization" : "Bearer " + (CashedData.getUserApiKey() ?? "")
        ]
        let info = [
                "cart_id": cartID ?? 0,
                "payment_way": "cach",
                "day": deliveryDate.text ?? "",
                "availability_id": availableId ?? 0,
                "lat": lat ?? 0.0,
                "lon":long ?? 0.0,
                "address":address.text ?? "",
                "promo_code":promoCode ?? ""
        ] as [String : Any]
        AlamofireRequests.PostMethod(methodType: "POST", url: url, info: info, headers: headers){
            (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil {
                    if success {
                        
                        self.stopAnimating()
                    }else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                        self.stopAnimating()
                    }
                    
                }else{
                    let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                    self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    self.stopAnimating()
                }
            }catch {
                self.present(common.makeAlert(), animated: true, completion: nil)
                self.stopAnimating()
            }
        }
    }
    func getAvailableTimes(){
        self.loading()
        let url = AppDelegate.LocalUrl + "available-times"
        let headers = [
            "Content-Type": "application/json" ,
            "Accept" : "application/json"
        ]
        
        AlamofireRequests.getMethod(url: url, headers: headers){
            (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil {
                    if success {
                        let dataReceived = try decoder.decode(availableTime.self, from: jsonData)
                        self.availableTimes.removeAll()
                        self.availableTimes.append(contentsOf: dataReceived.data ?? [])
                        self.stopAnimating()
                    }else{
                        self.stopAnimating()
                    }
                    
                }else{
                    let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                    self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    self.stopAnimating()
                }
            }catch {
                self.present(common.makeAlert(), animated: true, completion: nil)
                self.stopAnimating()
            }
        }
    }
    
}
// MARK:- Alamofire
extension completeOrder{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.last
        
        showMarker(position: userLocation!.coordinate)
        self.locationManager.stopUpdatingLocation()
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        deliveryDate.inputAccessoryView = toolbar
        deliveryDate.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        deliveryDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    func parsingData(_ data : [availableTimeData])->[String]{
        var ResData = [String]()
        for x in data {
            ResData.append("\(x.timeFrom ?? "") : \(x.timeTo ?? "") من")
        }
        return ResData
    }
    
    
}
extension completeOrder: GMSMapViewDelegate{
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
            self.address.text = lines.joined(separator: "\n")
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
extension completeOrder: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
