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
    var locLatitue1 = Double()
    var locLongitute1 = Double()
    var notifyCheck : Int8 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardHiding() /** bu fonksiyon klavyeyi açtığında view ı 200 pixel kaydırıyor */
        saveButton.isHidden = false ; saveButton.isEnabled = false
        //ViewDidLoad a herhangi bir yere tıklanınca klavyeyi gizlemesi için gesture recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard2))
        view.addGestureRecognizer(gestureRecognizer)
        ImageView.isUserInteractionEnabled = true //imageview etkileşime açan kod
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(takeImage))
        ImageView.addGestureRecognizer(imageGestureRecognizer) }
    
   @objc func receivedData() {
        locLatitue1 = DataTransferManager.shared.tempLatitute
        locLongitute1 = DataTransferManager.shared.tempLongitute
        notifyCheck = 1 }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTakeLocation" {
            let destinationVC = segue.destination as! MapViewController
            destinationVC.locName = DogNameTextField.text! }
    }
    
    @objc func takeImage() { //ayarlanan kaynaktan fotoğrafı alan objc kodu
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil) }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { //görseli aldıktan sonra picker ı kapatıyor
        ImageView?.image = info[.originalImage] as? UIImage
        //saveButton.isEnabled = true
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
    
    @IBAction func locationButtonClicked(_ sender: Any) {
        if DogNameTextField.text! != "" {
            NotificationCenter.default.post(name: NSNotification.Name("takingLocation"), object: nil)
            performSegue(withIdentifier: "toTakeLocation", sender: nil) }
        else {
            let alertMsg4 = UIAlertController(title: "System Message", message: "Please fill Dog Name text line", preferredStyle: UIAlertController.Style.alert)
            let alertButton4 = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            alertMsg4.addAction(alertButton4)
            self.present(alertMsg4, animated: true, completion: nil)
            return } }
    
    
    @IBAction func SaveButtonClicked(_ sender: Any) {
        NotificationCenter.default.addObserver(self, selector: #selector(receivedData), name: NSNotification.Name("locAccepted"), object: nil)
        if Int(DogAgeTextField.text!) != nil {
            if DogBreedTextField.text == "" || OwnerTextField.text == "" || OwnerPhoneTextField.text == "" || VetTextField.text == "" || VetPhoneTextField.text == "" {
            let alertMsg2  = UIAlertController(title: "System Message", message: "Please fill all text lines", preferredStyle: UIAlertController.Style.alert)
            let alertButton2 = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            alertMsg2.addAction(alertButton2)
            self.present(alertMsg2, animated: true, completion: nil)
            return }
            else if notifyCheck == 0 {
                let alertMsg5 = UIAlertController(title: "System Message", message: "Please choose the location", preferredStyle: UIAlertController.Style.alert)
                let alertButton5 = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alertMsg5.addAction(alertButton5)
                self.present(alertMsg5, animated: true, completion: nil)
                return }
            else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate // verileri kaydetmek ve context i kullanmak için tanımladık
                let context = appDelegate.persistentContainer.viewContext
                let Dog_Lister = NSEntityDescription.insertNewObject(forEntityName: "DogLister", into: context)
                Dog_Lister.setValue(DogNameTextField.text!, forKey: "dogname")
                if let age = Int(DogAgeTextField.text!) { Dog_Lister.setValue(age, forKey: "dogage") }
                Dog_Lister.setValue(locLatitue1, forKey: "latitute")
                Dog_Lister.setValue(locLongitute1, forKey: "longitute")
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
                self.present(alertMsg, animated: true, completion: nil) }
        }
        else {
            let alertMsg3 = UIAlertController(title: "Error!", message: "Please type a valid number!", preferredStyle: UIAlertController.Style.alert)
            let alertButton3 = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            alertMsg3.addAction(alertButton3)
            self.present(alertMsg3, animated: true, completion: nil)
            return
        } }
    }
