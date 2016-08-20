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

class TipsForCopingWithStressController: UITableViewController{
    
    let body = Body()
    lazy var rootRef = FIRDatabase.database().reference()
    var userID: String = (FIRAuth.auth()?.currentUser?.uid)!
    
    let searchController = UISearchController(searchResultsController: nil)
    var whatToDisplay: [DataObject] = []
    
    
    override func viewDidLoad() {
        
        
        body.createAndSyncTipsForStressArray()
        
        let tipsForStressRef = rootRef.child("tipsForStress")
        
        var title =  String()
        var image = String()
        var info =  String()
        var link = String()
        var key = String()
        
        tipsForStressRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            
            let tipsForStressKey = snapshot.key
            
            let tipsForStressRef = self.rootRef.child("tipsForStress/\(tipsForStressKey)")
            
            tipsForStressRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                
               // print(snapshot.value!)
                title = snapshot.value?.objectForKey("title") as! String
                image = snapshot.value?.objectForKey("image") as! String
                info = snapshot.value?.objectForKey("info") as! String
                link = snapshot.value?.objectForKey("link") as! String
                key = snapshot.value?.objectForKey("key") as! String
                
                
                self.whatToDisplay.append(DataObject(title: title, image: image, info: info, link: link, key: key))
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
        cell.buttonIcon.setImage(UIImage(named: element.image), forState:UIControlState.Normal)
        cell.link.text = ("Link: \(element.link)")
        
        link = element.link
        cell.buttonIcon.addTarget(self, action: #selector(TipsForCopingWithStressController.pressed(_:)), forControlEvents: .TouchUpInside)
        return cell
    }
  
    func pressed(sender: UIButton!) {
       UIApplication.sharedApplication().openURL(NSURL(string: link)!)
    }
    
}
class TipCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var buttonIcon: UIButton!
    @IBOutlet weak var link: UITextView!
    
}


