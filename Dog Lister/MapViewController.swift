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
        saveButton.isEnabled = false
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(takeLocation))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)}
    
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
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationId = "annotationId"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId)
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
            pinView?.canShowCallout = true
            pinView?.tintColor = .blue
            let pinButton = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = pinButton
        }
        else { pinView?.annotation = annotation}
        return pinView }
   
    
    @IBAction func locSaveButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("locAccepted"), object: nil)
        locationManager.stopUpdatingLocation()
        navigationController?.popViewController(animated: true) }
    }
