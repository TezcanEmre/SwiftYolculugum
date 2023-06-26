//
//  ViewController.swift
//  Perseus's Flight Book
//
//  Created by Tezcan on 26.06.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
    
    @IBOutlet weak var tableView: UITableView!
    var aircrafts = [String]()
    var acImagesName = [String]()

    
    

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



}

