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

class StatisticsController: UITableViewController, BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate{
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet var graph: BEMSimpleLineGraphView!
    
    //Stats
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // Stats Section
    @IBOutlet var totalNumberOfLogs: UILabel!
    
    // Notes Section
    @IBOutlet var moodScore: UILabel!
    @IBOutlet var dateToday: UILabel!
    @IBOutlet var averageMoodToday: UILabel!
    @IBOutlet var numberOfLogsToday: UILabel!
    @IBOutlet var notesToday: UITextView!

    // Date Range Section
    @IBOutlet var date1: UITextField!
    
    @IBOutlet var date2: UITextField!
    

   
    
    
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
    var totalScore = 0
    
    var moodLogsSameDay = [MoodLog]()
    
    override func viewWillAppear(animated: Bool) {
        
        print(retrievedData)
        
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
        print("Statistics Controller")
   
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
            
        }
        
//        var datePicker = UIDatePicker()
//        datePicker.date = NSDate()
//        datePicker.addTarget(self, action: #selector(self.updateTextField), forControlEvents: .ValueChanged)
//        
//        self.date1.inputView = datePicker!
//        self.date2.inputView = datePicker!
//        

  
    @IBAction func segmentedController(sender: AnyObject) {
        print("segmented touched")
        graph.reloadGraph()
    }
    

    func lineGraph(graph: BEMSimpleLineGraphView, didTouchGraphWithClosestIndex index: Int) {
        

        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            indexInFocus = listForToday[index]
            setNoteDetails(listForToday[index])
            
        case 1:
            indexInFocus = listForPastWeek[index]
                       setNoteDetails(listForToday[index])
        case 2:
            indexInFocus = listForPast3Months[index]
            setNoteDetails(listForToday[index])
        case 3:
            indexInFocus = listForAllTime[index]
            setNoteDetails(listForToday[index])
        default:
            indexInFocus = retrievedData[index]
            
        }
    }
    
    func setNoteDetails(moodLog: MoodLog){
        
        for element: MoodLog in retrievedData{
            
            
            if element.getDate() ==  moodLog.getDate(){
                moodLogsSameDay.append(element)
            }
        }
        var totalScore = 0
        for element in moodLogsSameDay{
            totalScore += element.moodScore
            print( totalScore)
            
        }
        
        moodScore.text = "Mood Score: \(moodLog.moodScore)"
        dateToday.text = moodLog.getFullDateAndTime()
        averageMoodToday.text = "Average mood that day: \(String(totalScore / moodLogsSameDay.count))"
        numberOfLogsToday.text =  "Mood logs that day: \(moodLogsSameDay.count)"
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
    

    
    
    
    
    
}





