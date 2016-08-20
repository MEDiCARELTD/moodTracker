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
        
        let storageRef = storage.referenceForURL("gs://moodtracker-5c84a.appspot.com/")
        
        imageRef = storageRef.child("images/")
        
       // body.createAndSyncTipsForStressArray()
        
        let tipsForStressRef = rootRef.child("tipsForStress")
        
        var title =  String()
        var imageName = String()
        var info =  String()
        var link = String()
        var key = String()
        
        tableView.registerNib(UINib(nibName: "TipCell", bundle: nil), forCellReuseIdentifier: "tipCell")

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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tipCell", forIndexPath: indexPath) as! TipCellControlTableViewCell
        
        cell.title.text = element.title
        cell.info.text = element.info
        
        let path  = imageRef.child(element.image)
        //let localURL: NSURL! = NSURL(string: imageRef.child(<#T##path: String##String#>))

        let data = NSData(contentsOfURL: localURL) //make sure your image in this url does exist, otherwise unwrap in a if let check
        
        imageRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                // ... let islandImage: UIImage! = UIImage(data: data!)
                cell.cellImage.imageView?.image = UIImage(data:data!)
            }
        }

        return cell
        
    }
  
    func pressed(sender: UIButton!) {
   //    UIApplication.sharedApplication().openURL(NSURL(string: link)!)
    //}
    
}
class TipCell: UITableViewCell {
    
    
   // @IBOutlet weak var title: UILabel!
    
   // @IBOutlet weak var info: UITextView!
   // @IBOutlet weak var buttonIcon: UIButton!
    //@IBOutlet weak var link: UITextView!
    
}
}


