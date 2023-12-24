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
    
    
  

   
}
