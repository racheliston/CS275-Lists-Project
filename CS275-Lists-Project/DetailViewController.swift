//
//  DetailViewController.swift
//  CS275-Lists-Project
//
//  Created by Sam Pitonyak on 10/27/21.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                print("Present camera")
        }
        alertController.addAction(cameraAction)
        
        let photoLibraryAction
                = UIAlertAction(title: "Photo Library", style: .default) { _ in
            print("Present photo library")
        }
        alertController.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBOutlet var recordLabel: UITextField!
    @IBOutlet var foundedLabel: UITextField!
    @IBOutlet var scheduleField: UITextView!
    
    
    var item: Team! {
        didSet {
                navigationItem.title = item.teamName
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        recordLabel.text = item.record
        foundedLabel.text = String(item.established)
        for i in item.schedule {
            scheduleField.text += ("\(i)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder
        view.endEditing(true)
        
        // "Save" changes to item
        item.record = recordLabel.text ?? ""
        item.established = foundedLabel.text ?? ""

        
        /*if let valueText = scheduleField.text,
            let value = numberFormatter.number(from: valueText) {
            item.established = value.intValue
        } else {
            item.established = 0
        }*/
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
