//
//  ViewController.swift
//  Dog Lister
//
//  Created by Tezcan on 1.11.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //kaç sıra oluşacağını giriyoruz
        return dognameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //hücrelerin isimlendirilmesinde kullanılıyor
        let cell = UITableViewCell()
        cell.textLabel?.text = dognameArray[indexPath.row]
        return cell
    }
    

    var SecilenKopek = ""
    var SecilenUUID2 : UUID?
    @IBOutlet weak var TableView: UITableView!
    var dognameArray = [String]() // gelen NSobject deki isimleri diziye atayacağız
    var idArray = [UUID]() // UUID leri diziye atayacağz
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        // navigation Controller'a veri ekleme butonu ekledim.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        getData()
                
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("dataAccepted"), object: nil)
    }
    
    @objc func getData() {
        dognameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //context i kullanmak için tanımlıyoruz
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogLister")//Coredata dan veri erişim talebi
        fetchRequest.returnsObjectsAsFaults = false //Caching de fayda sağlar büyük verilerde
        do {
           let gelenVeriler = try context.fetch(fetchRequest) // gelen verileri atama yapıyoruz
            for gelenVeri in gelenVeriler as! [NSManagedObject] { //gelen veri adında for döngüsü
                if let dogname = gelenVeri.value(forKey: "dogname") as? String { //dogname verileri eğer string oluyorsa dogname değişkenine atanıyor
                    dognameArray.append(dogname)
                }
                if let id = gelenVeri.value(forKey: "id") as? UUID { // Coredata nın ayarladığı UUID verilerini NSobject den çıkarıp UUID olarak atama yapıyor
                    idArray.append(id)
                }
                // viewdidload'a getData fonksiyonunu yazmadığım için çalışmıyormuş :D
                TableView.reloadData() // viewwillappear a eklenmeli
            }
        }
        catch {
            print("hata var")
        }
        
    }
    // segue de sorun var secondVC ye geçmiyor kodları incelemem gerek
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.SecilenDogName = SecilenKopek
            destinationVC.secilenUUID = SecilenUUID2
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SecilenKopek = dognameArray[indexPath.row]
        SecilenUUID2 = idArray[indexPath.row]
    }
    @objc func addButtonClicked () { //veri ekleme butonuna tıklanınca diğer VC ye geçen objc kodu
        SecilenKopek = ""
        performSegue(withIdentifier: "toSecondVC", sender: nil)
        
        
    }

}

