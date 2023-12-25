//
//  DetailsViewController.swift
//  Dog Lister
//
//  Created by Tezcan on 7.11.2023.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var textView: UITextView!
    var chosenDogName2 = String()
    var chosenUUID2 : UUID?
    var locX = Double()
    var locY = Double()
    var (string1, string2, string3, string4, string5, string6, string7) = ("","","","","","","")
    
    override func viewDidLoad() {
        super.viewDidLoad()
         if chosenDogName2 != "" { /** core datadan veri çek */
         if let stringUUID = chosenUUID2?.uuidString {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogLister")
            fetchRequest.predicate = NSPredicate(format: "id = %@", stringUUID)
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let receivedDatas = try context.fetch(fetchRequest)
                if receivedDatas.count > 0 {
                    for receivedData in receivedDatas as! [NSManagedObject] {
                        if let dogname = receivedData.value(forKey: "dogname") as? String {string1 = dogname}
                        if let dogage = receivedData.value(forKey: "dogage") as? Int {string2 = String(dogage) }
                        if let dogbreed = receivedData.value(forKey: "dogbreed") as? String {string3 = dogbreed}
                        if let ownername = receivedData.value(forKey: "ownername") as? String {string4 = ownername }
                        if let ownerphone = receivedData.value(forKey: "ownertel") as? String {string5 = ownerphone }
                        if let vetname = receivedData.value(forKey: "vetname") as? String {string6 = vetname }
                        if let vetphone = receivedData.value(forKey: "vettel") as? String {string7 = vetphone }
                        if let locLatitue2 = receivedData.value(forKey: "latitute") as? Double {
                             locX = locLatitue2 }
                        if let locLongitute2 = receivedData.value(forKey: "longitute") as? Double {
                             locY = locLongitute2 }
                        if let imgData = receivedData.value(forKey: "dogimage") as? Data { let image = UIImage(data: imgData)
                            imageView2.image = image } }
                                          }
            }
            catch { print("hata var") } }  }
        let combiendText = "\(string1)\n\(string2)\n\(string3)\n\(string4)\n\(string5)\n\(string6)\n\(string7)"
        textView.text = combiendText }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShowLocation" {
            NotificationCenter.default.post(name: NSNotification.Name("showLocation"), object: nil)
            let destinationVC = segue.destination as! MapViewController
            destinationVC.locLatitue3 = locX
            destinationVC.locLongitute3 = locY
            destinationVC.locName = string1 } }
    
    @IBAction func toNavigationButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("showLocation"), object: nil)
        performSegue(withIdentifier: "toShowLocation", sender: nil)
    }
    
    

   

    
    
    
    
    
    
    
    
    
    
    
    
}
