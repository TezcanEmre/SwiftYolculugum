//
//  ThirdViewController.swift
//  navigationApp
//
//  Created by Tezcan on 17.12.2023.
//

import UIKit
import MapKit
//import CoreLocation

class ThirdViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet weak var mapView2: MKMapView!
    var locName2 = String()
    var userNote2 = String()
    var coordinateX = Double()
    var coordinateY = Double()


    override func viewDidLoad() {
        super.viewDidLoad()
        mapView2.delegate = self
        let initialLocation = CLLocationCoordinate2D(latitude: coordinateX, longitude: coordinateY)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: initialLocation, span: span)
        mapView2.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation
        annotation.title = locName2
        annotation.subtitle = userNote2
        mapView2.addAnnotation(annotation)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        let annotationId = "annotationId"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId)
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
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
    //Bu kod haritaya Apple Maps ile yol tarifi özelliği ekliyor
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let requestLocation = CLLocation(latitude: coordinateX, longitude: coordinateY)
        CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarkArray, hata) in
            if let placemarks = placemarkArray {
                if placemarks.count > 0 {
                    let yeniPlacemark = MKPlacemark(placemark: placemarks[0])
                    let item = MKMapItem(placemark: yeniPlacemark)
                    item.name = self.locName2
                    let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                    item.openInMaps(launchOptions: launchOptions)
                }
            }
        }
    }
    
  

   
}
