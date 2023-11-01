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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //hücrelerin isimlendirilmesinde kullanılıyor
        let cell = UITableViewCell()
        cell.textLabel?.text = "test"
        return cell
    }
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        // Do any additional setup after loading the view.
        // navigation Controller'a veri ekleme butonu ekledim.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        
        
    }
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogLister")
        fetchRequest.returnsObjectsAsFaults = false //Caching de fayda sağlar büyük verilerde
        do {
           let gelenVeriler = try context.fetch(fetchRequest)
            for gelenVeri in gelenVeriler as! [NSManagedObject] {
                let dogname = gelenVeri.value(forKey: "dogname") as? String
                print(dogname)
                // en son burada kaldım komut satırında print etmiyor bakacağım
            }
        }
        catch {
            print("hata var")
        }
        
    }
    @objc func addButtonClicked () { //veri ekleme butonuna tıklanınca diğer VC ye geçen objc kodu
        performSegue(withIdentifier: "toSecondVC", sender: nil)
        
        
    }

}

