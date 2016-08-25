//
//  TipsForCopingWithStressController.swift
//  MoodTracker
//
//  Created by App Camp on 15/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class TipsForCopingWithStressController: UITableViewController{
   
    
   
    
    let storage = FIRStorage.storage()
    var imageRef = FIRStorageReference()
    
    
    let body = Body()
    lazy var rootRef = FIRDatabase.database().reference()
    var userID: String = (FIRAuth.auth()?.currentUser?.uid)!
    
    let searchController = UISearchController(searchResultsController: nil)
    var whatToDisplay: [DataObject] = []
    
    
    override func viewDidLoad() {
        print("tips for coping with sterss")
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.19, green:0.53, blue:0.96, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.19, green:0.53, blue:0.96, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        
        
        let tipsForStressRef = rootRef.child("tipsForStress")
        
        var title =  String()
        var imageName = String()
        var info =  String()
        var link = String()
        var key = String()
        
        
        tipsForStressRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let tipsForStressKey = snapshot.key
            
            let tipsForStressRef = self.rootRef.child("tipsForStress/\(tipsForStressKey)")
            
            tipsForStressRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                
                // print(snapshot.value!)
                title = snapshot.value?.objectForKey("title") as! String
                imageName = snapshot.value?.objectForKey("image") as! String
                info = snapshot.value?.objectForKey("info") as! String
                link = snapshot.value?.objectForKey("link") as! String
                key = snapshot.value?.objectForKey("key") as! String
                
                
                self.whatToDisplay.append(DataObject(title: title, image: imageName, info: info, link: link, key: key))
                self.tableView.reloadData()
                
                
            })
            
            
        })
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return whatToDisplay.count
    }
    
    var link = ""
    
    override func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let element = whatToDisplay[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tipCell", forIndexPath: indexPath) as! TipCell
        
        cell.title.text = element.title
        cell.info.text = element.info
        
        let storageRef = storage.referenceForURL("gs://moodtracker-5c84a.appspot.com/")
        imageRef = storageRef.child(String(format: "images/%@", element.image))
        
        
        imageRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                // ... let islandImage: UIImage! = UIImage(data: data!)
                let image = UIImage(data: data!)
                cell.cellImage.image = image
            }
        }
        
        return cell
        
    }
    
    
    func pressed(sender: UITableViewCell!) {
        
            UIApplication.sharedApplication().openURL(NSURL(string: link)!)
        }
    
    }

class TipCell: UITableViewCell{
    @IBOutlet var cellImage: UIImageView!
    
    @IBOutlet var title: UILabel!
    @IBOutlet var info: UILabel!
}



