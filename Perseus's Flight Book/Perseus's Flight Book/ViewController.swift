//
//  ViewController.swift
//  Perseus's Flight Book
//
//  Created by Tezcan on 26.06.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var aircrafts = [String]()
    var acImagesName = [String]()
    var userSelection = ""
    var userSelection2 = ""
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aircrafts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = aircrafts[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            aircrafts.remove(at: indexPath.row)
            acImagesName.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        aircrafts.append("Boeing 737")
        aircrafts.append("Boeing 737 MAX 8")
        aircrafts.append("Boeing 747")
        aircrafts.append("Boeing 777")
        aircrafts.append("Boeing 787 Dreamliner")
        aircrafts.append("Airbus A340")
        
        acImagesName.append("korean737")
        acImagesName.append("lot737max")
        acImagesName.append("luft747")
        acImagesName.append("THY777")
        acImagesName.append("eth787")
        acImagesName.append("thyA340")
        
                
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         userSelection = aircrafts[indexPath.row]
         userSelection2 = acImagesName[indexPath.row]
        performSegue(withIdentifier: "tosecondVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tosecondVC" {
            let destinationVC = segue.destination as! secondViewController
            destinationVC.choosenAC = userSelection
            destinationVC.choosenACimage = userSelection2
        }
    }



}

