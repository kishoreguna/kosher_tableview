//
//  ViewController.swift
//  kishore tableview
//
//  Created by macbook on 04/07/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var fetchData: [NSManagedObject] = []
    
    @IBOutlet weak var txt1: UITextField!
    
    @IBOutlet weak var txt2: UITextField!
    
    @IBOutlet weak var btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.isHidden = true
        
        
        
        
    }
    
    

    
    @IBAction func savebtn(_ sender: Any) {
        
        tableview.isHidden = false
        guard let name = txt1.text, !name.isEmpty,
              let phone = txt2.text, !phone.isEmpty else {
            print("empty")
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let obj = NSManagedObject(entity: entity, insertInto: managedContext)
        
        obj.setValue(name, forKey: "name")
        obj.setValue(phone, forKey: "phone")
        
        
       
        
        do {
            try managedContext.save()
            print("Saved")
            fetchDataFromCoreData()
        } catch {
            print(error)
        }
    }
    
    func fetchDataFromCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        
        
        do {
            fetchData = try managedContext.fetch(fetchRequest)
            
            tableview.reloadData()
            
            
        } catch {
            print("Failed to fetch data:")
        }
        
        

           }
    }

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! oneTableViewCell
        
        
        let data = fetchData[indexPath.row]
//        let name = data.value(forKey: "name") as? String
//        print("name")
//        let phone = data.value(forKey: "phone") as? String
//        print("phone")
        
        cell.namelabel?.text = data.value(forKey: "name") as? String
        cell.phonelabel?.text = data.value(forKey: "phone") as? String
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                   let appDelegate = UIApplication.shared.delegate as! AppDelegate
                   let managedContext = appDelegate.persistentContainer.viewContext
                   
                   let user = fetchData[indexPath.row]
                   managedContext.delete(user)
                   
                   do {
                       try managedContext.save()
                       fetchDataFromCoreData()
                       print("delete")
                       
                   } catch {
                       print("Failed to delete user: \(error)")
                   }
               }
           }
}
