//
//  Statistics.swift
//  MoodTracker
//
//  Created by App Camp on 22/07/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph
import FirebaseDatabase

class StatisticsController: UIViewController, BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate{
    
    @IBOutlet weak var graph: BEMSimpleLineGraphView!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var goToNotes: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet var noDataLabel: UILabel!
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var graphingTool = GraphingTool()
    var retrievedData = [MoodLog]()
    
    var listForToday = [MoodLog]()
    var listForPastWeek = [MoodLog]()
    var listForPast3Months = [MoodLog]()
    var listForAllTime = [MoodLog]()
    
    var dateText = String()
    var segmentedIndex = 2
    var indexInFocus = MoodLog()
   
    var aMoodLog: MoodLog = MoodLog()
    
    override func viewWillAppear(animated: Bool) {

        
        //        //test Months
        //        let test = TestGraph()
        //        test.logMoodOverMonths(rootRef,userID: userID)
        
        //        // test over three Months
        //        let test = TestGraph()
        //        test.logMoodOver3Months(rootRef, userID: userID)
        
        
        retrievedData = appDelegate.self.accountLogData
        listForToday = graphingTool.getListOfLogsForToday(retrievedData)
        listForPastWeek = graphingTool.getListOfLogsForPastWeek(retrievedData)
        listForPast3Months = graphingTool.getListOfLogsForPast3Months(retrievedData)
        listForAllTime = retrievedData
    }
    override func viewDidLoad() {
   
        
       
        
        print("Main Menu: Loading in notes")
        
        dateLabel.text = dateText
        self.segmentedControl.selectedSegmentIndex = 2
        
        ////////////////////////////////// Properties for graph //////////////////////////////////
        self.graph.enableYAxisLabel = true
        self.graph.enableBezierCurve = true;
        graph.dataSource = self
        graph.delegate = self
        graph.enableYAxisLabel = true
        self.view!.addSubview(graph)
      
        
        
        // Enable and disable various graph properties and axis displays
        self.graph.enableTouchReport = true
        self.graph.enablePopUpReport = true
        self.graph.enableYAxisLabel = true
        //self.graph.autoScaleYAxis = true
        self.graph.alwaysDisplayDots = false
        self.graph.enableReferenceXAxisLines = true
        self.graph.enableReferenceYAxisLines = true
        self.graph.enableReferenceAxisFrame = true
       
                
        // Dash the y reference lines
        self.graph.lineDashPatternForReferenceYAxisLines = [2, 2]
        
        // Show the y axis values with this format string
        self.graph.formatStringForValues = "%.1f"
        
        if dateText == "" {
        self.goToNotes.enabled = false;
        
            
        }
    
    }
    
    @IBAction func segmentedController(sender: AnyObject) {
        
        graph.reloadGraph()
    }
    
    
    func lineGraph(graph: BEMSimpleLineGraphView, didTouchGraphWithClosestIndex index: Int) {
        
        self.goToNotes.enabled = true;

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            indexInFocus = listForToday[index]
            dateLabel.text = listForToday[index].getDateAndTime()
        
        case 1:
            indexInFocus = listForPastWeek[index]
            dateLabel.text = listForPastWeek[index].getDateAndTime()
        case 2:
            indexInFocus = listForPast3Months[index]
            dateLabel.text = listForPast3Months[index].getDateAndTime()
        case 3:
            indexInFocus = listForAllTime[index]
            dateLabel.text = listForAllTime[index].getDateAndTime()
        default:
            indexInFocus = retrievedData[index]
            dateLabel.text = retrievedData[index].getDateAndTime()
            
        }
    }
    
    
    @IBAction func goToNotes(sender: AnyObject) {
        self.performSegueWithIdentifier("DetailView", sender: nil)
    }
    
    
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return listForToday.count
        case 1:
            return listForPastWeek.count
        case 2:
            return listForPast3Months.count
        default:
            return retrievedData.count
        }
    }
    
    
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String{
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            return listForToday[index].getTime()
        case 1:
            return listForPastWeek[index].getDay()
        case 2:
            return listForPast3Months[index].getMonth()
        case 3:
            return listForAllTime[index].getMonth()
            
        default:
            print("Crash")
            return retrievedData[index].getDay()
        }
        
        
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        
        
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            return CGFloat(listForToday[index].moodScore)
        
        case 1:
            return  CGFloat(listForPastWeek[index].moodScore)

        case 2:
            return CGFloat(listForPast3Months[index].moodScore)
            
        default:
            return CGFloat(retrievedData[index].moodScore)
            
        }
    }
    
    
    
    func numberOfGapsBetweenLabelsOnLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        
        
        return 0
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
        // Create a new variable to store the instance of PlayerTableViewController
        let destinationVieController = (segue.destinationViewController as! DetailController)
        destinationVieController.moodLog = indexInFocus
        
    }
   
    
    
    
}





