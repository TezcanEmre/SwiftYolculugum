//
//  ViewController.swift
//  notDefteri
//
//  Created by Tezcan on 2.05.2023.

// Bu uygulamayi biraz gelisi guzel hazirladim. Uygulamanin amaci kullanicidan alinan verilerin "user defaults" kullanarak depolanmasi ve silinmesi. ViewController'da duzenleme yapmadim dolayisiyla gorunum cihazlardaki farkliliktan dolayi bozulabilir.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField1: UITextField! //1. metin kutusu
    @IBOutlet weak var textField2: UITextField! //2. metin kutusu
    
    @IBOutlet weak var firstLine: UILabel! //Kullaniciya gosterilecek ilk label
    @IBOutlet weak var secondLine: UILabel! // Kullaniciya gosterilecek ikinci label
   
    // Burada kaydedilecek verilerin anahtarlarini atadim. ViewDidLoad'a yazsaydim buton fonksiyonlarinda tekrardan tanimlama yapmam gerekecekti.
    let savedData1 = UserDefaults.standard.object(forKey: "firstInput")
    let savedData2 = UserDefaults.standard.object(forKey: "secondInput")
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //ViewDidLoad edildiginde kayitli verileri tutmak icin iki degisken tanimladim. Bu degiskenler butona tiklanmadiginda veya uygulama acildiginde text field dan veri cekemedigi icin kayitli notlara etki etmemekte
        if let noteData1 = savedData1 as? String {
            firstLine.text = "\(noteData1)"
        }
        if let noteData2 = savedData2 as? String {
            secondLine.text = "\(noteData2)"
        }
        
    }
   
        
    @IBAction func saveButtonClick(_ sender: Any) {
        //Kaydet butonuna tiklanince olusacak aksiyonlar
        UserDefaults.standard.set(textField1.text!, forKey: "firstInput")
        UserDefaults.standard.set(textField2.text!, forKey: "secondInput")
        //Bu iki satirda kullanicidan alinan veriyi basta tanimladigim User Defaults lara atadim. Unlem isareti String option'i String e cevirmeye zorlamak icin. Kullanici text field lari bos biraksa da sorun olusturmuyor
        firstLine.text = "\(textField1.text!)"
        secondLine.text = "\(textField2.text!)"
        //bu iki not kaydedildiginde de kullaniciya göstermek icin Label'i yeniden duzenledim
        let systemMessage1 = UIAlertController(title: "Sistem Mesaji", message: "Veriler kaydedildi!", preferredStyle: UIAlertController.Style.alert)  //kullaniciya verileri kaydettigine dair uyari
        
        let okButton1 = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default) { (UIAlertAction) in
            } //Uyari penceresini kapatan fonksiyon
        systemMessage1.addAction(okButton1)
        self.present(systemMessage1, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        //Bu kod sayesinde textfield larda açılan klavyeyi kapatmak için herhangi bir boşluğa tıklamam yeterli.
        
    }
    @IBAction func deleteButtonClick(_ sender: Any) {
        
        let systemMessage2 = UIAlertController(title: "Sistem Mesaji", message: "Veriler silindi!", preferredStyle: UIAlertController.Style.alert) //verilerin silindigine dair uyari
        
        let okButton2 = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.destructive) { (UIAlertAction) in
             } //uyari penceresini kapatan fonksiyon
        systemMessage2.addAction(okButton2)
        self.present(systemMessage2, animated: true, completion: nil)
        
        //uyari pencerelerinden sonra butona tiklaninca kaydedilmis veri var mi yok mu kontrol ediyor != esit degildir anlamina gelir. Eger sonuc nil degilse veriyi kaldiriyor. Label lari temizlemek için bos string atiyor.
        if (savedData1 as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "firstInput")
        }
        if (savedData2 as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "secondInput")
        }
        firstLine.text = ""
        secondLine.text = ""
    }
    
}

