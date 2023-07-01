//
//  ViewController.swift
//  Plane Book
//
//  Created by Tezcan on 1.07.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = acArray[indexPath.row].name
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    var acArray = [Aircrafts]()
    var userChoice : Aircrafts?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let boeing737 = Aircrafts(name: "Boeing 737", infoAC: "Dar govdeli yolcu ucagi, ortalama 186 koltuk kapasiteli ", imageAC: UIImage(named: "korean737")!)
        let boeing737max = Aircrafts(name: "Boeing 737 Max8", infoAC: "Dar govdeli yolcu ucagi, ortalama 170 koltuk kapasiteli ", imageAC: UIImage(named: "lot737max")!)
        let boeing747 = Aircrafts(name: "Boeing 747", infoAC: "Genis govdeli jumbo jet, ortalama 371 koltuk kapasiteli ", imageAC: UIImage(named: "luft747")!)
        let boeing777 = Aircrafts(name: "Boeing 777", infoAC: "Genis govdeli yolcu ucagi, ortalama 349 yolcu kapasiteli ", imageAC: UIImage(named: "THY777")!)
        let boeing787 = Aircrafts(name: "Boeing 787", infoAC: "Genis govdeli modern yolcu ucagi, ortalama 299 yolcu kapasiteli ", imageAC: UIImage(named: "eth787")!)
         acArray = [boeing737,boeing737max,boeing747,boeing777,boeing787]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         userChoice = acArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! secondViewController
            destinationVC.choosedAC = userChoice
            
            
        }
    }

}

