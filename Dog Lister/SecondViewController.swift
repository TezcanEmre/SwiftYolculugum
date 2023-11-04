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
    
    var SecilenDogName = ""
    var secilenUUID: UUID?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if SecilenDogName != "" {
            // core datadan veri çek
            if let stringUUID = secilenUUID?.uuidString {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogLister")
                fetchRequest.predicate = NSPredicate(format: "id = %@", stringUUID)
                fetchRequest.returnsObjectsAsFaults = false
                do {
                    let gelenVeriler = try context.fetch(fetchRequest)
                    if gelenVeriler.count > 0 {
                        for gelenVeri in gelenVeriler as! [NSManagedObject] {
                            if let dogname = gelenVeri.value(forKey: "dogname") as? String {DogNameTextField.text = dogname}
                            if let dogage = gelenVeri.value(forKey: "dogage") as? Int {DogAgeTextField.text = String(dogage) }
                            if let dogbreed = gelenVeri.value(forKey: "dogbreed") as? String {DogBreedTextField.text = dogbreed}
                            if let ownername = gelenVeri.value(forKey: "ownername") as? String {OwnerTextField.text = ownername }
                            if let ownerphone = gelenVeri.value(forKey: "ownertel") as? String {OwnerPhoneTextField.text = ownerphone }
                            if let vetname = gelenVeri.value(forKey: "vetname") as? String {VetTextField.text = vetname }
                            if let vetphone = gelenVeri.value(forKey: "vettel") as? String {VetPhoneTextField.text = vetphone }
                            if let imgData = gelenVeri.value(forKey: "dogimage") as? Data { let image = UIImage(data: imgData)
                                ImageView.image = image }
                        }
                    
                    }
                }
                catch {
                    print("hata var")
                }
        }
            
            
        }
        else {
            DogNameTextField.text = ""
            DogAgeTextField.text = ""
            DogBreedTextField.text = ""
            OwnerTextField.text = ""
            VetTextField.text = ""
            OwnerPhoneTextField.text = ""
            VetPhoneTextField.text = ""
        }

        //ViewDidLoad a herhangi bir yere tıklanınca klavyeyi gizlemesi için gesture recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        ImageView.isUserInteractionEnabled = true //imageview etkileşime açan kod
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(takeImage))
        ImageView.addGestureRecognizer(imageGestureRecognizer)
    }
    @objc func takeImage() { //ayarlanan kaynaktan fotoğrafı alan objc kodu
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { //görseli aldıktan sonra picker ı kapatıyor
        ImageView?.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() { //Gesture recognizer ın çalıştıracağı klavyeyi gizleyen objc kodu
        view.endEditing(true)
        
    }
    @IBAction func SaveButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // verileri kaydetmek ve context i kullanmak için tanımladık
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
        NotificationCenter.default.post(name: NSNotification.Name("dataAccepted"), object: nil)
        self.navigationController?.popViewController(animated: true)

    }
    

}
