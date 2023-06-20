//
//  ViewController.swift
//  Perseus's Flight Book
//
//  Created by Tezcan on 16.06.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // kaç row olacak
        return aircraftsModels.count
    }
    var aircraftsModels = [String]()
    var aircraftsImages = [String]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {// row içindeki veriler
        let cell = UITableViewCell()
        cell.textLabel?.text = aircraftsModels[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        aircraftsModels.append("Boeing 737")
        aircraftsModels.append("Boeing 737 MAX")
        aircraftsModels.append("Boeing 747")
        aircraftsModels.append("Boeing 777")
        aircraftsModels.append("Boeing 787")
        aircraftsModels.append("Airbus A340")
        
        aircraftsImages.append("korean737")
        aircraftsImages.append("lot737MAX")
        aircraftsImages.append("luft747")
        aircraftsImages.append("THY777")
        aircraftsImages.append("eth787")
        aircraftsImages.append("thyA340")
        
        
        // Do any additional setup after loading the view.h
    }


}

