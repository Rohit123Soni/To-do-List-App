//
//  Student+CoreDataProperties.swift
//  DetailAppUsingCoreData
//
//  Created by MacBook on 28/03/2022.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var city: String?
    @NSManaged public var address: String?
    @NSManaged public var mobile: String?
    @NSManaged public var name: String?

}

extension Student : Identifiable {

}
