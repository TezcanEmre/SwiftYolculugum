//  ViewController.swift
//  navigationApp
//
//  Created by Tezcan on 11.11.2023.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager() /** locationmanager değişkenine CLLocationManager ı atıyoruz */
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    var userLatitute : Double = 0
    var userLongitute : Double = 0
    var locationText = ""
    var locationNote = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest /**kullanıcının konum doğruluğu */
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(takeLocation)) /** kullanıcı dokunduğunda haritada işaretleme yapıyor */
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer) }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude) /** kullanıcıdan alınan koordinatı CLLocation dizisinden çekiyoruz */
        let span = MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006) /**haritada gösterilecek alan */
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true) }
    
    @objc func takeLocation(gestureRecognizer : UILongPressGestureRecognizer) { /**burada objc fonksiyonuna gesture recognizer ı atıyoruz ki fonksiyon çalışırken de kontrol sağlanabilsin */
        if gestureRecognizer.state == .began { /** objc fonksiyonunu çalıştırmak için kullanıcının dokunma eylemini kontrol ediyor  */
            let userTouch = gestureRecognizer.location(in: mapView) /** mapview dan kullanıcının dokunduğu konumu alıyor  */
            let touchedCoordinate = mapView.convert(userTouch, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinate
            annotation.title = locationTextField.text
            annotation.subtitle = noteTextField.text
            mapView.addAnnotation(annotation)
            userLatitute = touchedCoordinate.latitude as Double
            userLongitute = touchedCoordinate.longitude as Double } }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        let annotationId = "annotationId"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId)
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier:annotationId)
            pinView?.canShowCallout = true
            pinView?.tintColor = .blue
            let pinButton = UIButton(type: .detailDisclosure)
            pinView?.leftCalloutAccessoryView = pinButton
        }
        else {
            pinView?.annotation = annotation
        }
        return pinView
    }    
    @IBAction func saveButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let savedLocation = NSEntityDescription.insertNewObject(forEntityName: "LocationApp", into: context)
        savedLocation.setValue(locationTextField.text, forKey: "locName")
        savedLocation.setValue(noteTextField.text, forKey: "userNote")
        savedLocation.setValue(userLatitute, forKey: "latitute")
        savedLocation.setValue(userLongitute, forKey: "longitute")
        savedLocation.setValue(UUID(), forKey: "id")
        do { try context.save() }
        catch { print("error") } }
    
    @IBAction func databaseButton(_ sender: Any) {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toDatabaseVC" {
        _ = segue.destination as! SecondViewController } }
        
    }
    

}

