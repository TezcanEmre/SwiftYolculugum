//
//  secondViewController.swift
//  shopping list
//
//  Created by Tezcan on 2.07.2023.
//

import UIKit
import CoreData

class secondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var productTextLine: UITextField!
    @IBOutlet weak var priceTextLine: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // I added a gesture recognizer for hiding keyboard. I created a constants and named as gesture recognizer. After that set UITap gesture recognizer and created a obj-c function. This function stop view editing. When gesture recognizer triggered function will hide keyboard
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDisapper))
        view.addGestureRecognizer(gestureRecognizer)
        
        
        imageView.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(imageChoose))
        imageView.addGestureRecognizer(imageGesture)
    }
    @objc func imageChoose(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    @objc func keyboardDisapper() {
        view.endEditing(true)
        
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let shopping = NSEntityDescription.insertNewObject(forEntityName: "Shopping", into: context)
        shopping.setValue(brandTextField.text!, forKey: "seller")
        shopping.setValue(productTextLine.text!, forKey: "product")
        if let price = Int(priceTextLine.text!) {
            shopping.setValue(price, forKey: "price")
        }
        shopping.setValue(UUID(), forKey: "id")
        let imgData = imageView.image!.jpegData(compressionQuality: 0.7)
        shopping.setValue(imgData, forKey: "image")
        
        do {
            try context.save()
        } catch {
        print("hata")
        
        }
        NotificationCenter.default.post(name: NSNotification.Name("dataSend"), object: nil)
        self.navigationController?.popViewController(animated: true)
            
            
            
            }
    
    
    

}
