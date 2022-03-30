//
//  ViewController.swift
//  DetailAppUsingCoreData
//
//  Created by MacBook on 26/03/2022.
//

import UIKit
import CoreData

var studentList = [Student]()

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var studentData : Student?
    var firstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        studentList = DatabaseHelper.sharedInstance.getStudentData()
        print("viewDidLoad \(studentList.count)")
        
        if (firstLoad) {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let s = result as! Student
                    studentList.append(s)
                }
            } catch {
                print("Fetch Failed")
            }
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear \(studentList.count)")
        tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddVC") as! AddVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if studentList.count < 1 {
            tableView.backgroundColor  = .red
        }
        
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentCell
        cell.student = studentList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editData", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editData" {
            let indexPath = tableView.indexPathForSelectedRow!
            let vc = segue.destination as? AddVC
            
            let selectedStudent : Student!
            selectedStudent = studentList[indexPath.row]
            
            vc!.selectedStudent = selectedStudent
            
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
    
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
            let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
                let  remove = studentList[indexPath.row]
                DatabaseHelper.sharedInstance.context?.delete(remove)
               // studentList.
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
                do {
                     try  DatabaseHelper.sharedInstance.context?.save()
                    } catch {
    
                }
                
    
    
            }
    
            return UISwipeActionsConfiguration(actions: [action])
        }
}


