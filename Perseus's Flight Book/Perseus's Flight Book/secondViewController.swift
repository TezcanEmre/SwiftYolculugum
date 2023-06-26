//
//  secondViewController.swift
//  Perseus's Flight Book
//
//  Created by Tezcan on 26.06.2023.
//

import UIKit

class secondViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    var choosenAC = ""
    var choosenACimage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLabel.text = choosenAC
        imageView.image = UIImage(named: choosenACimage )
        // Do any additional setup after loading the view.
    }
    

    

}
