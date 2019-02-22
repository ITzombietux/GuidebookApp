//
//  NotesViewController.swift
//  Guidebook
//
//  Created by Christopher Ching on 2018-06-22.
//  Copyright © 2018 Christopher Ching. All rights reserved.
//

import UIKit
import RealmSwift

class NotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var place: Place?
    var notes: Results<Note>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get notes for the place
        if place != nil {
            notes = NoteService.getNotes(place!.placeId!, updates: {
                
                // Notes result set has updated, so reload the tableview
                self.tableView.reloadData()
            })
        }
        
        // Configure the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set dynamic cell height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        
        // Dismiss the view controller
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func composeTapped(_ sender: UIBarButtonItem) {
        
        // Create a new compose view controller and present it
        let composeVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.composeViewController) as? ComposeViewController
        
        if let composeVC = composeVC {
            
            // Set the presentation mode
            composeVC.modalPresentationStyle = .overCurrentContext
            
            // Set the place property
            composeVC.place = place
            
            // Present it
            present(composeVC, animated: false, completion: nil)
        }
    }
    
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes != nil ? notes!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.noteCellId, for: indexPath) as? NoteCell
        
        // Get note
        let n = notes![indexPath.row]
        
        // Set the note
        cell?.showNote(n)
        
        return cell!
    }
}
