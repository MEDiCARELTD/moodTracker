//
//  notes.swift
//  MoodTracker
//
//  Created by App Camp on 27/07/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class NotesController: UITableViewController {
    
    lazy var rootRef = FIRDatabase.database().reference()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var retrievedData: [MoodLog] = []
    var filteredData = [MoodLog] ()
    
    var moodLog = MoodLog()

    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrievedData = appDelegate.self.accountLogData
        navigationItem.rightBarButtonItem = editButtonItem()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
    }
    
    func filterContent(searchText: String){
        let words = searchText.componentsSeparatedByString(" ")
        
        for index in words{
            print(index)
            let indexWithoutSpaces = index.stringByReplacingOccurrencesOfString(" ", withString: "")
            filteredData = retrievedData.filter{ MoodLog in
                return MoodLog.getDate().lowercaseString.containsString(indexWithoutSpaces.lowercaseString)
        }
          tableView.reloadData()
        }
        
    }
   

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredData.count
        }else{
            return retrievedData.count
        }
    }
    
    override func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        if searchController.active && searchController.searchBar.text != "" {
            moodLog = filteredData[indexPath.row]
            print (moodLog.getDate())
        }else{
            moodLog = retrievedData[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        
        cell.date.text = moodLog.getDateAndTime()
        cell.score.text = ("Score: \(moodLog.moodScore)")
        cell.note.text = ("Note: \(moodLog.note)")
        
        let score = moodLog.moodScore
        
        
        // sets the face depending on mood score
        switch score
        {
        case 10:
            cell.moodIcon.image = UIImage(named:"mood-10.png")
        case  9:
            cell.moodIcon.image = UIImage(named:"mood-9.png")
        case  8:
            cell.moodIcon.image = UIImage(named:"mood-8.png")
        case  7:
            cell.moodIcon.image = UIImage(named:"mood-7.png")
        case  6:
            cell.moodIcon.image = UIImage(named:"mood-6.png")
        case 5:
            cell.moodIcon.image = UIImage(named:"mood-5.png")
        case  4:
            cell.moodIcon.image = UIImage(named:"mood-4.png")
        case 3:
            cell.moodIcon.image = UIImage(named:"mood-3.png")
        case  2:
            cell.moodIcon.image = UIImage(named:"mood-2.png")
        case  1:
            cell.moodIcon.image = UIImage(named:"mood-1.png")
        default:
            cell.moodIcon.image = UIImage(named:"mood-5.png")
            
            
            
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        if editingStyle == .Delete {
            
            
            let logKeyAtIndex = retrievedData[indexPath.row].logKey
            
            let moodRef = self.rootRef.child("moodLogs/\(logKeyAtIndex)")
            let userID: String = (FIRAuth.auth()?.currentUser?.uid)!
            let userRef = rootRef.child("users/\(userID)/logs/\(logKeyAtIndex)")
            
            // remove from app delegate as well to stop it crashing
            retrievedData.removeAtIndex(indexPath.row)
            appDelegate.self.accountLogData.removeAtIndex(indexPath.row)
            userRef.removeValue()
            moodRef.removeValue()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            
            
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        moodLog = retrievedData[indexPath.row]
//        self.performSegueWithIdentifier("NoteToGraph", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NoteToGraph"{
            
            let destinationVewController = segue.destinationViewController as! StatisticsController
            
            destinationVewController.indexInFocus = moodLog
            print(moodLog.getDateAndTime())
            destinationVewController.dateText = moodLog.getDateAndTime()
            
        }
    }
}

extension NotesController: UISearchResultsUpdating{
    func updateSearchResultsForSearchController(searchController: UISearchController){
        filterContent(searchController.searchBar.text!)
    }
}

class CustomCell: UITableViewCell {
    
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var moodIcon: UIImageView!
    @IBOutlet weak var score: UILabel!
    
    
    
}
