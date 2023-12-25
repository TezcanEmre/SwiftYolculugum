//
//  MapViewController.swift
//  Dog Lister
//
//  Created by Tezcan on 25.12.2023.
//

import UIKit
import CoreLocation
import MapKit
class DataTransferManager {
    static let shared = DataTransferManager()
    var tempLatitute = Double()
    var tempLongitute = Double() }

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var locLatitue3 = Double()
    var locLongitute3 = Double()
    var locName = String()
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    @IBOutlet weak var saveButton: UIButton!
    func transferData() {
        DataTransferManager.shared.tempLatitute = locLatitue3
        DataTransferManager.shared.tempLongitute = locLongitute3 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isHidden = false ; saveButton.isEnabled = false
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true) }
    
    @objc func takeLocation(gestureRecognizer : UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let userTouch = gestureRecognizer.location(in: mapView)
            let touchedCoordinate = mapView.convert(userTouch, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinate
            annotation.title = locName
            mapView.addAnnotation(annotation)
            locLatitue3 = touchedCoordinate.latitude as Double
            locLongitute3 = touchedCoordinate.longitude as Double
            transferData()
            saveButton.isEnabled = true } }
    
    @objc func newReg() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(takeLocation))
        mapView.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer.minimumPressDuration = 3 }
    
    @objc func existedReg() {
        mapView.delegate = self
        let initialLoc = CLLocationCoordinate2D(latitude: locLatitue3, longitude: locLongitute3)
        let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
        let region = MKCoordinateRegion(center: initialLoc, span: span)
        mapView.setRegion(region, animated: true)
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = initialLoc
        annotation2.title = locName
        mapView.addAnnotation(annotation2) }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(existedReg), name: NSNotification.Name("showLocation"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(newReg), name: NSNotification.Name("takingLocation"), object: nil)
    }
    
    @IBAction func locSaveButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("locAccepted"), object: nil)
        locationManager.stopUpdatingLocation()
        navigationController?.popViewController(animated: true)
    }
    
    
}
