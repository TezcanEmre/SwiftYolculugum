//
//  SecondViewController.swift
//  Dog Lister
//
//  Created by Tezcan on 1.11.2023.
// Ekran döndürme ve diğer görünümler devre dışı bırakıldı, secondVC'de dinamik hale getirilince bu özellik de eklenecek

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
    @IBOutlet weak var saveButton: UIButton!
    
    var chosenDogName = ""
    var chosenUUID: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardHiding() /** bu fonksiyon klavyeyi açtığında view ı 200 pixel kaydırıyor */
        if chosenDogName != "" { /** core datadan veri çek */ saveButton.isHidden = true
             if let stringUUID = chosenUUID?.uuidString {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogLister")
                fetchRequest.predicate = NSPredicate(format: "id = %@", stringUUID)
                fetchRequest.returnsObjectsAsFaults = false
                do {
                    let receivedDatas = try context.fetch(fetchRequest)
                    if receivedDatas.count > 0 {
                        for receivedData in receivedDatas as! [NSManagedObject] {
                            if let dogname = receivedData.value(forKey: "dogname") as? String {DogNameTextField.text = dogname}
                            if let dogage = receivedData.value(forKey: "dogage") as? Int {DogAgeTextField.text = String(dogage) }
                            if let dogbreed = receivedData.value(forKey: "dogbreed") as? String {DogBreedTextField.text = dogbreed}
                            if let ownername = receivedData.value(forKey: "ownername") as? String {OwnerTextField.text = ownername }
                            if let ownerphone = receivedData.value(forKey: "ownertel") as? String {OwnerPhoneTextField.text = ownerphone }
                            if let vetname = receivedData.value(forKey: "vetname") as? String {VetTextField.text = vetname }
                            if let vetphone = receivedData.value(forKey: "vettel") as? String {VetPhoneTextField.text = vetphone }
                            if let imgData = receivedData.value(forKey: "dogimage") as? Data { let image = UIImage(data: imgData)
                                ImageView.image = image }                  }
                                              }
                }
                catch { print("hata var") }
                                                   }                                 }
        else { saveButton.isHidden = false ; saveButton.isEnabled = false
            DogNameTextField.text = ""
            DogAgeTextField.text = ""
            DogBreedTextField.text = ""
            OwnerTextField.text = ""
            VetTextField.text = ""
            OwnerPhoneTextField.text = ""
            VetPhoneTextField.text = "" }
        //ViewDidLoad a herhangi bir yere tıklanınca klavyeyi gizlemesi için gesture recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard2))
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
        present(picker, animated: true, completion: nil) }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { //görseli aldıktan sonra picker ı kapatıyor
        ImageView?.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil) }
    
    func setupKeyboardHiding() {
        /** https://www.youtube.com/watch?v=O4tP7egAV1I kaynak burası daha sonra döneceğim şu an bu kod çalışıyor ancak 2 text field a tıklanınca ekstra view kayıyor. Bunu dinamik hale getirmek lazım ancak başlangıç aşamasında bu kalabilir */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShifting), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil) }
    
    @objc func keyboardShifting(sender: NSNotification) {
        view.frame.origin.y = view.frame.origin.y - 200}
     
    
    @objc func keyboardWillHide(notification: NSNotification) {
     view.frame.origin.y = 0 }
     
    
    
    @objc func hideKeyboard2() { //Gesture recognizer ın çalıştıracağı klavyeyi gizleyen objc kodu
        view.endEditing(true) }
    
    @IBAction func SaveButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // verileri kaydetmek ve context i kullanmak için tanımladık
        let context = appDelegate.persistentContainer.viewContext
        let Dog_Lister = NSEntityDescription.insertNewObject(forEntityName: "DogLister", into: context)
        Dog_Lister.setValue(DogNameTextField.text!, forKey: "dogname")
        if let age = Int(DogAgeTextField.text!) { Dog_Lister.setValue(age, forKey: "dogage") }
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
            print("kaydedildi") }
        catch { print("hata") }
        NotificationCenter.default.post(name: NSNotification.Name("dataAccepted"), object: nil)
        let alertMsg = UIAlertController(title: "System Message", message: "All datas saved succesfully!", preferredStyle: UIAlertController.Style.alert)
        let alertButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in self.navigationController?.popViewController(animated: true) }
        alertMsg.addAction(alertButton)
        self.present(alertMsg, animated: true, completion: nil)
                                                }
    }
