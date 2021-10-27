//
//  DetailViewController.swift
//  CS275-Lists-Project
//
//  Created by Sam Pitonyak on 10/27/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var recordLabel: UILabel!
    @IBOutlet var foundedLabel: UILabel!
    @IBOutlet var scheduleField: UITextView!
    
    
    var item: Item!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        recordLabel.text = item.record
        foundedLabel.text = String(item.established)
        for i in item.schedule {
            scheduleField.text += ("\(i)")
        }
    }
}
