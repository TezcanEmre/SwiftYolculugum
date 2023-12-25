//
//  SecondViewController.swift
//  navigationApp
//
//  Created by Tezcan on 17.12.2023.
//

import UIKit
import CoreData

class SecondViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
@IBOutlet weak var mainLabel: UILabel!
@IBOutlet weak var tableView: UITableView!
var locArray = [String]()
var noteArray = [String]()
var idArray = [UUID]()
var choosenLoc = ""
var choosenNote = ""
var choosenId : UUID?
var annotationX = Double()
var annotationY = Double()
var annotationXarray = [Double]()
var annotationYarray = [Double]()
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return locArray.count }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let cell = UITableViewCell()
cell.textLabel?.text = locArray[indexPath.row]
return cell }
        
override func viewDidLoad() {
super.viewDidLoad()
tableView.delegate = self
tableView.dataSource = self
getData() }
    
@objc func getData() {
locArray.removeAll(keepingCapacity: false)
idArray.removeAll(keepingCapacity: false)
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationApp")
fetchRequest.returnsObjectsAsFaults = false
do {
    let receivedDatas = try context.fetch(fetchRequest)
    if receivedDatas.count > 0 {
     for receivedData in receivedDatas as! [NSManagedObject] {
     if let choosenLoc = receivedData.value(forKey: "locName") as? String {
     locArray.append(choosenLoc) }
     if let choosenNote = receivedData.value(forKey: "userNote") as? String {
     noteArray.append(choosenNote) }
     if let choosenId = receivedData.value(forKey: "id") as? UUID {
     idArray.append(choosenId) }
     if let annotationX = receivedData.value(forKey: "latitute") as? Double {
     annotationXarray.append(annotationX) }
     if let annotationY = receivedData.value(forKey: "longitute") as? Double {
     annotationYarray.append(annotationY)}
     tableView.reloadData() } }
    }
    catch { print("hata")}
    }
override func viewWillAppear(_ animated: Bool) {
    NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("dataAccepted"), object: nil)
    tableView.reloadData()
}
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "toMapsVC" {
         let destinationVC2 = segue.destination as! ThirdViewController
         destinationVC2.locName2 = choosenLoc
         destinationVC2.userNote2 = choosenNote
         destinationVC2.coordinateX = annotationX
         destinationVC2.coordinateY = annotationY
     }
    }
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    choosenId = idArray[indexPath.row]
    choosenLoc = locArray[indexPath.row]
    choosenNote = noteArray[indexPath.row]
    annotationX = annotationXarray[indexPath.row]
    annotationY = annotationYarray[indexPath.row]
    performSegue(withIdentifier: "toMapsVC", sender: nil)
    }


    
}
