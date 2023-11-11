//
//  secondViewController.swift
//  Plane Book
//
//  Created by Tezcan on 1.07.2023.
//

import UIKit

class secondViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var acNameLabel: UILabel!
    @IBOutlet weak var acDetailsLabel: UILabel!
    var choosedAC : Aircrafts?

    override func viewDidLoad() {
        super.viewDidLoad()
        acNameLabel.text = choosedAC?.name
        acDetailsLabel.text = choosedAC?.infoAC
        imageView.image = choosedAC?.imageAC
        
    }
    

    

}
