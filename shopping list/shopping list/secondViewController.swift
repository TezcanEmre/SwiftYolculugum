//
//  secondViewController.swift
//  shopping list
//
//  Created by Tezcan on 2.07.2023.
//

import UIKit

class secondViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var productTextLine: UITextField!
    @IBOutlet weak var priceTextLine: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // I added a gesture recognizer for hiding keyboard. I created a constants and named as gesture recognizer. After that set UITap gesture recognizer and created a obj-c function. This function stop view editing. When gesture recognizer triggered function will hide keyboard
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDisapper))
        view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func keyboardDisapper() {
        view.endEditing(true)
        
    }
    

}
