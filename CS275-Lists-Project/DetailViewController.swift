//
//  DetailViewController.swift
//  CS275-Lists-Project
//
//  Created by Sam Pitonyak on 10/27/21.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var recordLabel: UITextField!
    @IBOutlet var foundedLabel: UITextField!
    @IBOutlet var scheduleField: UITextView!
    @IBOutlet var imageView: UIImageView!
    var itemStore: TeamStore!
    var teamStore: ItemsViewController!
    
    var imageStore: ImageStore!
    
    var indexPath: IndexPath = []
    
    var item: Team! {
        didSet {
                navigationItem.title = item.teamName
            }
    }
    
    @IBAction func deletePhoto(_ sender: UIBarButtonItem) {
        // Create an alert controller to prompt user and ask if they are sure
        // they want to delete the item
        let alertController = UIAlertController(title: nil,
                                                message: "Are you sure you want to delete \(item.teamName)",
                                                preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let item = itemStore.allItems[indexPath.row]
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive) {_ in
            // Remove the item and return to previous view
            self.itemStore.removeItem(item)
            
            // Remove the item's image from the image store
            self.imageStore.deleteImage(forKey: item.teamKey)
            
            self.navigationController!.popViewController(animated: true)
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)

        present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        
        let photoLibraryAction
                = UIAlertAction(title: "Photo Library", style: .default) { _ in
                    let imagePicker = self.imagePicker(for: .photoLibrary)
                    imagePicker.modalPresentationStyle = .popover
                    imagePicker.popoverPresentationController?.barButtonItem = sender
                    self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // Get picked image from info dictionary
        let image = info[.originalImage] as! UIImage
        
        // Store the image in the ImageStore for the team's key
        imageStore.setImage(image, forKey: item.teamKey)
        
        // Put that image on the screen in the image view
        imageView.image = image
        
        // Take image picker off the screen - you must call this dismiss method
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        recordLabel.text = item.record
        foundedLabel.text = String(item.established)
        nameLabel.text = item.teamName
        for i in item.schedule {
            scheduleField.text += ("\(i)")
        }
        
        // Get the item key
        let key = item.teamKey
        // If there is an associated image with the item, display it on the image view
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder
        view.endEditing(true)
        
        // "Save" changes to item
        item.record = recordLabel.text ?? ""
        item.established = foundedLabel.text ?? ""
        item.schedule = scheduleField.text
        item.teamName = nameLabel.text ?? ""

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
    
}
