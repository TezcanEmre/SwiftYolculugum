//
//  ViewController.swift
//  Dog Lister
//  Created by Tezcan on 1.11.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /** kaç sıra oluşacağını giriyoruz */ return dognameArray.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /**hücrelerin isimlendirilmesinde kullanılıyor */
        let cell = UITableViewCell()
        cell.textLabel?.text = dognameArray[indexPath.row]
        return cell }
    
    @IBOutlet weak var TableView: UITableView!
    var chosenDog = ""
    var chosenUUID2 : UUID?
    var dognameArray = [String]() // gelen NSobject deki isimleri diziye atayacağız
    var idArray = [UUID]() // UUID leri diziye atayacağz
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        // navigation Controller'a veri ekleme butonu ekledim.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        getData() /**getData fonksiyonunu çağırıyoruz */ }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("dataAccepted"), object: nil) }
    
    @objc func getData() {
        dognameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //context i kullanmak için tanımlıyoruz
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogLister")//Coredata dan veri erişim talebi
        fetchRequest.returnsObjectsAsFaults = false //Caching de fayda sağlar büyük verilerde
        do {
           let receivedDatas = try context.fetch(fetchRequest) // gelen verileri atama yapıyoruz
            if receivedDatas.count > 0 {
                for receivedData in receivedDatas as! [NSManagedObject] { //gelen veri adında for döngüsü
                    if let dogname = receivedData.value(forKey: "dogname") as? String { //dogname verileri eğer string oluyorsa dogname değişkenine atanıyor
                        dognameArray.append(dogname) }
                    if let id = receivedData.value(forKey: "id") as? UUID { /** Coredata nın ayarladığı UUID verilerini NSobject den çıkarıp UUID olarak atama yapıyor */ idArray.append(id) }
                    // viewdidload'a getData fonksiyonunu yazmadığım için çalışmıyormuş :D
                    TableView.reloadData() /**viewwillappear a eklenmeli */ }
                                     }
           }
        catch { print("hata var") }
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.chosenDogName = chosenDog
            destinationVC.chosenUUID = chosenUUID2 } }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // performsegue yi buraya eklemeyi unuttuğum için çalışmıyormuş :d
        chosenDog = dognameArray[indexPath.row]
        chosenUUID2 = idArray[indexPath.row]
        performSegue(withIdentifier: "toSecondVC", sender: nil) }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alertMSG = UIAlertController(title: "Warning!", message: "Selected data will removed permanetly", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive) { UIAlertAction in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogLister")
            let uuidString = self.idArray[indexPath.row].uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
            fetchRequest.returnsObjectsAsFaults = false
            do { let receivedDatas = try context.fetch(fetchRequest)
                if receivedDatas.count > 0 {
                    for receivedData in receivedDatas as! [NSManagedObject] {
                        if let id = receivedData.value(forKey: "id") as? UUID {
                            if id == self.idArray[indexPath.row] {
                                context.delete(receivedData)
                                self.dognameArray.remove(at: indexPath.row)
                                self.idArray.remove(at: indexPath.row)
                                tableView.reloadData()
                                do { try context.save() }
                                catch { print("hata var")  }
                                break } }  } }
            }
            catch { print("hata var") }                                               }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertMSG.addAction(okButton)
        alertMSG.addAction(cancelButton)
        self.present(alertMSG, animated: true, completion: nil) }
    
    @objc func addButtonClicked () { //veri ekleme butonuna tıklanınca diğer VC ye geçen objc kodu
        chosenDog = ""
        performSegue(withIdentifier: "toSecondVC", sender: nil) }
}

