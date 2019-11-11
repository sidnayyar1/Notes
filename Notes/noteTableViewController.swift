//
//  noteTableViewController.swift
//  Notes
//
//  Created by Sidharth Nayyar on 11/10/19.
//  Copyright © 2019 Sidharth Nayyar. All rights reserved.
//

import UIKit
import CoreData

class noteTableViewController: UITableViewController {

    var notes = [Note]()
    
    var manageObjectContext:NSManagedObjectContext?{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: 245.0/255.0, green: 79.0/255.0, blue: 80.0/255.0, alpha: 1.0)
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveNotes; // this wil retrive notes from our data model
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return notes.count// this is will notes count of notes.
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteTableViewCell", for: indexPath)
//identifier will change to tableviewcell of main story board cell.
        let note: Note = notes[indexPath.row]//make a variable if index path will be 5 it will take you to 5th row
        cell.configureCell(note: note)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        return true
    }
    
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()// this will reload data whenever we change the data
    }
    
    func retrieveNotes() {
        manageObjectContext?.perform {
            
            self.fetchNotesFromCoreData { (notes) in
                if let notes = notes {
                    self.notes = notes
                    self.tableView.reloadData()
                    
                }
                
            }
            
        }
        
    }
    
    
//    func retrieveNotes() {//this function is caled to retrieve notes from the core data
//        manageObjectContext?.perform {
//            self.fetchNotesfromCoreData { ([notes]) in
//
//                if let notes = notes {
//                self.notes = notes
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }
    
    func fetchNotesFromCoreData(completion: @escaping ([Note]?)->Void){
        manageObjectContext?.perform {
            var notes = [Note]()
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            
            do {
                notes = try  self.manageObjectContext!.fetch(request)
                completion(notes)
                
            }
            
            catch {
                print("Could not fetch notes from CoreData:\(error.localizedDescription)")
                
            }
            
        }
        
    }
    
    
//    func fetchNotesfromCoreData(completion: @escaping ([Note])?) -> Void) {
//
//    managedObjectConext?.perform {
//
//    var notes = [Note]()
//    let request = NSFetchRequest<Note> = Note.fetchRequest()
//    }
//
//    }
  
}
