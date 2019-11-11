//
//  ViewController.swift
//  Notes
//
//  Created by Sidharth Nayyar on 11/10/19.
//  Copyright © 2019 Sidharth Nayyar. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {


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
    }


}

