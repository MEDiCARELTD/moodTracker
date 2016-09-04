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
    // Graph Section
    @IBOutlet var graph: BEMSimpleLineGraphView!
    @IBOutlet var noDataGraphLabel: UILabel!
    //Stats
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // Stats Section
    @IBOutlet var totalNumberOfLogs: UILabel!
    
    // Notes Section
    @IBOutlet var moodScore: UILabel!
    
    @IBOutlet var averageMoodToday: UILabel!
    @IBOutlet var numberOfLogsToday: UILabel!
    @IBOutlet var notesToday: UILabel!
    @IBOutlet var logsAllTime: UILabel!
    
    
    // Date Range Section
    
    @IBOutlet var date1: UIDatePicker!
    @IBOutlet var date2: UIDatePicker!
    
    @IBOutlet var dateToday: [UILabel]!
    
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var graphingTool = GraphingTool()
    var retrievedData = [MoodLog]()
    
    var listForToday = [MoodLog]()
    var listForPastWeek = [MoodLog]()
    var listForPast3Months = [MoodLog]()
    var listForAllTime = [MoodLog]()
    var listForCustomRange = [MoodLog]()
    
    var dateText = String()
    var segmentedIndex = 2
    var indexInFocus = MoodLog()
    
    var aMoodLog: MoodLog = MoodLog()
    var totalScore = 0
    
    var moodLogsSameDay = [MoodLog]()
    
    var timIntervalDate1 = Double()
    var timIntervalDate2 = Double()
    
    
    @IBAction func datePicker1(sender: AnyObject) {
        
        listForCustomRange = graphingTool.getlistOfLogsBetweenTwoDates(retrievedData, date1: date1.date, date2: date2.date)
        graph.reloadGraph()
    }
    
    @IBAction func datePicker2(sender: AnyObject) {
        listForCustomRange = graphingTool.getlistOfLogsBetweenTwoDates(retrievedData, date1: date1.date, date2: date2.date)
        graph.reloadGraph()
    }
    @IBAction func backToTop(sender: AnyObject) {
        tableView!.scrollToRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0), atScrollPosition: .Top, animated: true)
    }
    
    
    override func viewDidLoad() {
        print("Statistics Controller")
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.19, green:0.53, blue:0.96, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.19, green:0.53, blue:0.96, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        
        
        
        goToNoteDetail.enabled = false
        goToNoteDetail.hidden = true
        
        
        retrievedData = appDelegate.self.accountLogData
        listForToday = graphingTool.getListOfLogsForToday(retrievedData)
        listForPastWeek = graphingTool.getListOfLogsForPastWeek(retrievedData)
        listForPast3Months = graphingTool.getListOfLogsForPast3Months(retrievedData)
        
        
        
        print("\n\nCustom Range \(listForCustomRange)")
        
        listForAllTime = retrievedData
        
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
        
        logsAllTime.text = "Mood Logs Of All Time: \(retrievedData.count)"
        
    }
    
    
    @IBAction func segmentedController(sender: AnyObject) {
        print("segmented touched")
        print("list for past week: \(listForPastWeek.count)")
        print("list for past 3 months: \(listForPast3Months.count)")
        print("list for all time: \(retrievedData.count)")
        print("list for today: \(listForToday.count)")
        
        
        graph.reloadGraph()
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
        
        for element in dateToday{
            element.text = moodLog.getFullDateAndTime()
        }
        
        
        
        averageMoodToday.text = "Average mood that day: \(String(totalScore / moodLogsSameDay.count))"
        numberOfLogsToday.text =  "Mood logs that day: \(moodLogsSameDay.count)"
        
        print(" note touched" + moodLog.note)
        notesToday.text = moodLog.note
        
    }
    
    @IBOutlet var goToNoteDetail: UIButton!
    
    func lineGraph(graph: BEMSimpleLineGraphView, didReleaseTouchFromGraphWithClosestIndex index: CGFloat) {
        
        goToNoteDetail.enabled = true
        goToNoteDetail.hidden = false
        
    }
    func lineGraph(graph: BEMSimpleLineGraphView, didTouchGraphWithClosestIndex index: Int) {
        
        let indexRound = index
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            indexInFocus = listForToday[indexRound]
            setNoteDetails(listForToday[indexRound])
            
        case 1:
            indexInFocus = listForPastWeek[indexRound]
            setNoteDetails(listForPastWeek[indexRound])
        case 2:
            indexInFocus = listForPast3Months[indexRound]
            setNoteDetails(listForPast3Months[indexRound])
        case 3:
            indexInFocus = listForAllTime[indexRound]
            setNoteDetails(listForAllTime[indexRound])
        case 4:
            indexInFocus = listForCustomRange[indexRound]
            setNoteDetails(listForCustomRange[indexRound])
            
        default:
            indexInFocus = retrievedData[indexRound]
            
        }
        
    }
    
    
    
    
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            totalNumberOfLogs.text = "Total Number OF Logs: \(listForToday.count)"
            return listForToday.count
        case 1:
            totalNumberOfLogs.text = "Total Number OF Logs: \(listForPastWeek.count)"
            return listForPastWeek.count
            
        case 2:
            totalNumberOfLogs.text = "Total Number OF Logs:\(listForPast3Months.count)"
            return listForPast3Months.count
            
        case 3:
            totalNumberOfLogs.text = "Total Number OF Logs: \(retrievedData.count)"
            return retrievedData.count
            
        case 4:
            totalNumberOfLogs.text = "Total Number OF Logs: \(listForCustomRange.count)"
            return listForCustomRange.count
        default:
            totalNumberOfLogs.text = "Total Number OF Logs: \(retrievedData.count)"
            return retrievedData.count
            
        }
        
        
        
    }
    
    
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String{
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            return "  " + listForToday[index].getTime()
        case 1:
            return "  " + listForPastWeek[index].getDay()
        case 2:
            return "  " + listForPast3Months[index].getMonth()
        case 3:
            return "  " + listForAllTime[index].getMonth()
        case 4:
            return listForCustomRange[index].getMonth()
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
        case 4:
            return CGFloat(listForCustomRange[index].moodScore)
        default:
            return CGFloat(retrievedData[index].moodScore)
            
        }
    }
    
    
    
    func numberOfGapsBetweenLabelsOnLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        
        
        return 0
        
    }
    
    @IBAction func goToNoteDetail(sender: AnyObject) {
        print("pressed go to note")
        tableView!.scrollToRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 3), atScrollPosition: .Top, animated: true)
        
        
    }
    
    @IBAction func segmentedAction(sender: AnyObject) {
        
        for element in dateToday {
            element.text = "Date: none selected"
            averageMoodToday.text = "Average mood: none selected"
            numberOfLogsToday.text = " number of logs that day: none selected"
            notesToday.text = "none Selected"
            
        }
        if segmentedControl.selectedSegmentIndex == 4 {
            tableView!.scrollToRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1), atScrollPosition: .Top, animated: true)
        }
    }
    
}









