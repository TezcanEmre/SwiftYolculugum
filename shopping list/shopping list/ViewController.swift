//
//  ViewController.swift
//  shopping list
//
//  Created by Tezcan on 2.07.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brandArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = brandArray[indexPath.row]
        return cell
    }
    @objc func dataFetch() {
        brandArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Shopping")
        fetchRequest.returnsObjectsAsFaults = false //daha büyük veritabanıyla çalışırken caching den faydalanmak için kullanılıyor detaylı öğrenirim
        do {
            let sum = try context.fetch(fetchRequest)
            for summary in sum as! [NSManagedObject] {
                if let brand = summary.value(forKey: "seller") as? String {
                    brandArray.append(brand)
                }
                if let id = summary.value(forKey: "id") as? UUID {
                    idArray.append(id)
                }
                
            }
            tableView.reloadData()
        } catch {
            print("error")
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    var brandArray = [String]()
    var idArray = [UUID]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        dataFetch()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetch), name: NSNotification.Name(rawValue: "dataSend"), object: nil)
    }
   
    @objc func addButtonClicked() {
        performSegue(withIdentifier: "toSecondVC", sender: nil)
        
    }

}

