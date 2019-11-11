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
    
    
    func saveCoreData(completion: @escaping () ->Void){
        manageObjectContext?.perform {
            do{
                try self.manageObjectContext?.save()
                completion()
                print("note save to core data")
                
            }
            catch let error {
                print("could not save note to core data")
            }
        }
        
    }


}

