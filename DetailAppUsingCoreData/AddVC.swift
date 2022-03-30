//
//  AddVC.swift
//  DetailAppUsingCoreData
//
//  Created by MacBook on 26/03/2022.
//

import UIKit
import CoreData

class AddVC: UIViewController {
    
    @IBOutlet weak var nametxtField: UITextField!
    @IBOutlet weak var addresstxtField: UITextField!
    @IBOutlet weak var citytxtField: UITextField!
    @IBOutlet weak var mobiletxtField: UITextField!
    
    var selectedStudent: Student? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(white: 0.95, alpha: 1)
        if selectedStudent != nil {
            nametxtField.text = selectedStudent?.name
            addresstxtField.text = selectedStudent?.address
            citytxtField.text = selectedStudent?.city
            mobiletxtField.text = selectedStudent?.mobile
        }
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if selectedStudent == nil {
            let entity = NSEntityDescription.entity(forEntityName: "Student", in: context)
            let student = Student(entity: entity!, insertInto: context)
            student.name = nametxtField.text
            student.address = addresstxtField.text
            student.city = citytxtField.text
            student.mobile = mobiletxtField.text
            do {
                try context.save()
                studentList.append(student)
                navigationController?.popViewController(animated: true)
            }
            catch {
                print("context save error")
            }
        } else  {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let check = result as! Student
                    if(check == selectedStudent)
                    {
                        check.name = nametxtField.text
                        check.address = addresstxtField.text
                        check.city = citytxtField.text
                        check.mobile = mobiletxtField.text
                        try context.save()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
        
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let s = result as! Student
                if(s == selectedStudent)
                {
                    s.name = nametxtField.text
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch
        {
            print("Fetch Failed")
        }
    }
    
}
