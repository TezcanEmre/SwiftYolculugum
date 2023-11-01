//
//  SecondViewController.swift
//  Dog Lister
//
//  Created by Tezcan on 1.11.2023.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var DogNameTextField: UITextField!
    @IBOutlet weak var DogAgeTextField: UITextField!
    @IBOutlet weak var DogBreedTextField: UITextField!
    @IBOutlet weak var OwnerTextField: UITextField!
    @IBOutlet weak var VetTextField: UITextField!
    @IBOutlet weak var OwnerPhoneTextField: UITextField!
    @IBOutlet weak var VetPhoneTextField: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //ViewDidLoad a herhangi bir yere tıklanınca klavyeyi gizlemesi için gesture recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        ImageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(takeImage))
        ImageView.addGestureRecognizer(imageGestureRecognizer)
    }
    @objc func takeImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ImageView?.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() { //Gesture recognizer ın çalıştıracağı klavyeyi gizleyen objc kodu
        view.endEditing(true)
        
    }
    @IBAction func SaveButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let Dog_Lister = NSEntityDescription.insertNewObject(forEntityName: "DogLister", into: context)
        Dog_Lister.setValue(DogNameTextField.text!, forKey: "dogname")
        if let age = Int(DogAgeTextField.text!) {
            Dog_Lister.setValue(age, forKey: "dogage")
        }
        Dog_Lister.setValue(DogBreedTextField.text!, forKey: "dogbreed")
        Dog_Lister.setValue(OwnerTextField.text!, forKey: "ownername")
        Dog_Lister.setValue(OwnerPhoneTextField.text!, forKey: "ownertel")
        Dog_Lister.setValue(VetTextField.text!, forKey: "vetname")
        Dog_Lister.setValue(VetPhoneTextField.text!, forKey: "vettel")
        Dog_Lister.setValue(UUID(), forKey: "id")
        let image = ImageView.image!.jpegData(compressionQuality: 0.6)
        Dog_Lister.setValue(image, forKey: "dogimage")
        
        do {
            try context.save()
            print("kaydedildi")
        }
        catch { print("hata")}
    }
    
    

}
