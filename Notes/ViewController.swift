//
//  ViewController.swift
//  Notes
//
//  Created by Sidharth Nayyar on 11/10/19.
//  Copyright © 2019 Sidharth Nayyar. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate {


    @IBOutlet weak var noteInfoView: UIView!
    @IBOutlet weak var noteImageViewView	: UIView!
    
    
    @IBOutlet weak var noteNameLabel: UITextField!
    @IBOutlet weak var noteDescriptionLabel: UITextView!
    
    @IBOutlet weak var noteImageView: UIImageView!
    
    
    
    var manageObjectContext: NSManagedObjectContext?{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    var notesFecthViewController:NSFetchedResultsController<Note>!
    var notes = [Note]()
    var note:Note?
    var isExisting = false
    var indexPath : Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //this is to load data
        if let note = note{
            noteNameLabel.text = note.noteName
            noteDescriptionLabel.text = note.noteDescription
            noteImageView.image = UIImage(data: note.noteImage! as Data)
            
        }
        if noteNameLabel.text != "" {
            isEditing = true
        }
        
        //delegates
        noteNameLabel.delegate = self
        noteDescriptionLabel.delegate = self
        
        //style
        noteInfoView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        noteInfoView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        noteInfoView.layer.shadowRadius = 1.5
        noteInfoView.layer.shadowOpacity = 0.2
        noteInfoView.layer.cornerRadius = 2
        
        noteImageViewView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        noteImageViewView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        noteImageViewView.layer.shadowRadius = 1.5
        noteImageViewView.layer.shadowOpacity = 0.2
        noteImageViewView.layer.cornerRadius = 2
        
        noteImageView.layer.cornerRadius = 2
        noteNameLabel.setBottomborder()
        
    }
    
    //saving core data
    func saveCoreData(completion: @escaping () ->Void){
        manageObjectContext?.perform {
            do{
                try self.manageObjectContext?.save()
                completion()
                print("note save to core data")
                
            }
            catch let error {
                print("could not save note to coreData: \(error.localizedDescription)")
            }
        }
        
    }
    @IBAction func pickImageButton(_ sender: Any) {
        let pickerController = UIImagePickerController()
               pickerController.delegate = self
               pickerController.allowsEditing = true
               
               let alertController = UIAlertController(title: "Add an Image", message: "Choose From", preferredStyle: .actionSheet)
               
               let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                   pickerController.sourceType = .camera
                   self.present(pickerController, animated: true, completion: nil)
                   
               }
               
               let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
                   pickerController.sourceType = .photoLibrary
                   self.present(pickerController, animated: true, completion: nil)
                   
               }
               
               let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
                   pickerController.sourceType = .savedPhotosAlbum
                   self.present(pickerController, animated: true, completion: nil)
                   
               }
               
               let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
               
               alertController.addAction(cameraAction)
               alertController.addAction(photosLibraryAction)
               alertController.addAction(savedPhotosAction)
               alertController.addAction(cancelAction)
               
               present(alertController, animated: true, completion: nil)
    }
    //image Picker
//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        self.dismiss(animated: true, completion: nil)
//
//        if let image = info[UIImag] as? UIImage {
//            self.noteImageView.image = image
//        }
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           self.dismiss(animated: true, completion: nil)
           
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               self.noteImageView.image = image
               
           }
       }
    
    
  
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//           self.dismiss(animated: true, completion: nil)
//
//           if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//               self.noteImageView.image = image
//
//           }
//       }
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
           
       }

    @IBAction func saveButtonWasPressed(_ sender: UIBarButtonItem) {
        
        if noteNameLabel.text == "" || noteNameLabel.text == "NOTE NAME" || noteDescriptionLabel.text == "" || noteDescriptionLabel.text == "Note Description..." {
                   
            let alertController = UIAlertController(title: "Missing Information", message:"You left one or more fields empty. Please make sure that all fields are filled before attempting to save.", preferredStyle: UIAlertController.Style.alert)
            let OKAction = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil)
                   
                   alertController.addAction(OKAction)
                   
                   self.present(alertController, animated: true, completion: nil)
                   
               }
               
               else {
                   if (isExisting == false) {
                       let noteName = noteNameLabel.text
                       let noteDescription = noteDescriptionLabel.text
                       
                       if let moc = manageObjectContext {
                           let note = Note(context: moc)

                        if let data = self.noteImageView.image!.jpegData(compressionQuality: 1.0) {
                               note.noteImage = data as NSData as Data
                           }
                       
                           note.noteName = noteName
                           note.noteDescription = noteDescription
                       
                        saveCoreData(){
                               let isPresentingInAddFluidPatientMode = self.presentingViewController is UINavigationController
                               
                               if isPresentingInAddFluidPatientMode {
                                   self.dismiss(animated: true, completion: nil)
                                   
                               }
                               
                               else {
                                   self.navigationController!.popViewController(animated: true)
                                   
                               }

                           }

                       }
                   
                   }
                   
                   else if (isExisting == true) {
                       
                       let note = self.note
                       
                       let managedObject = note
                       managedObject!.setValue(noteNameLabel.text, forKey: "noteName")
                       managedObject!.setValue(noteDescriptionLabel.text, forKey: "noteDescription")
                       
                    if let data = self.noteImageView.image!.jpegData(compressionQuality: 1.0) {
                           managedObject!.setValue(data, forKey: "noteImage")
                       }
                       
                       do {
                           try context.save()
                           
                           let isPresentingInAddFluidPatientMode = self.presentingViewController is UINavigationController
                           
                           if isPresentingInAddFluidPatientMode {
                               self.dismiss(animated: true, completion: nil)
                               
                           }
                               
                           else {
                               self.navigationController!.popViewController(animated: true)
                               
                           }

                       }
                       
                       catch {
                           print("Failed to update existing note.")
                       }
                   }

               }

    }
    
    
    
    //cancel button
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
          let isPresentingInAddFluidPatientMode = presentingViewController is UINavigationController
                
                if isPresentingInAddFluidPatientMode {
                    dismiss(animated: true, completion: nil)
                    
                }
                
                else {
                    navigationController!.popViewController(animated: true)
                    
                }
                
            }
    
            
            // Text field
            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                textField.resignFirstResponder()
                return false
                
            }
            
            func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
                if(text == "\n") {
                    textView.resignFirstResponder()
                    return false
                    
                }
                
                return true
                
            }
            
            func textViewDidBeginEditing(_ textView: UITextView) {
                if (textView.text == "Note Description...") {
                    textView.text = ""
                    
                }
                
            }
            

}

