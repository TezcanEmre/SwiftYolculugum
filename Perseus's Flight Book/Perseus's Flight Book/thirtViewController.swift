//
//  thirtViewController.swift
//  Perseus's Flight Book
//
//  Created by Tezcan on 1.07.2023.
//

import UIKit

class thirtViewController: UIViewController {
    var flightCounter = 35
    var lastFlightData = ""
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var lastFlightLabel: UILabel!
    @IBOutlet weak var flightTextField: UITextField!
    let savedData1 = UserDefaults.standard.object(forKey: "counterData")
    let savedData2 = UserDefaults.standard.object(forKey: "flightData")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
    }
    

    

}
