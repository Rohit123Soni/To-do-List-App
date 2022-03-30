//
//  DatabaseHelper.swift
//  DetailAppUsingCoreData
//
//  Created by MacBook on 28/03/2022.
//

import Foundation
import UIKit
import CoreData

class DatabaseHelper {

    static var sharedInstance = DatabaseHelper()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //MARK: - save()
    func save(object: [String: String]) {
        let student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context!) as! Student
        student.name = object["name"]
        student.address = object["address"]
        student.city = object["city"]
        student.mobile = object["mobile"]
        do {
            try context?.save()
        } catch {
            print("Data not saved")
        }
    }
    
    //MARK: - getStudentData()
    func getStudentData() -> [Student] {
        var student = [Student]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        do {
            student = try context?.fetch(fetchRequest) as! [Student]
        } catch {
            print("Can not Get Data")
        }
        return student
    }
    
    //MARK: - deleteData()
    func deleteData(index: Int) -> [Student] {
        
        var student = getStudentData()
        context?.delete(student[index])
        student.remove(at: index)
        do {
            try context?.save()
        } catch {
         print("Can not delete Data")
        }
        return student
    }
    
    
    
    
}
