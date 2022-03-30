//
//  StudentCell.swift
//  DetailAppUsingCoreData
//
//  Created by MacBook on 28/03/2022.
//

import UIKit

class StudentCell: UITableViewCell {
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var mobile: UILabel!

    var student: Student! {
        didSet {
            name.text = student.name
            address.text = student.address
            city.text = student.city
            mobile.text = student.mobile
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        
        customView.backgroundColor = .white
        customView.layer.cornerRadius = 5
        customView.layer.shadowRadius = 2
        customView.layer.shadowOffset = CGSize(width: -1, height: 1)
       // customView.layer.shadowOpacity = 0.2
        //customView.layer.shadowColor = UIColor.gray.cgColor
        customView.clipsToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

