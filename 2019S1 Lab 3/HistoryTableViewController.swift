//
//  HistoryTableViewController.swift
//  2019S1 Lab 3
//
//  Created by Laveeshka Mahadea on 3/10/19.
//  Copyright © 2019 Michael Wybrow. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController, DatabaseListener {

    let SECTION_RECORDS = 0;
    let SECTION_COUNT = 1;
    let CELL_RECORD = "historyCell"
    let CELL_COUNT = "totalRecordsCell"
    
    var allRecords: [SensorData] = []
    var filteredRecords: [SensorData] = []
    weak var databaseController: DatabaseProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the database controller once from the App Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
    var listenerType = ListenerType.records

    func onRecordListChange(change: DatabaseChange, records: [SensorData]) {
        allRecords = records
        
        self.tableView.reloadData()
        
        
        //        updateSearchResults(for: navigationItem.searchController!)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SECTION_RECORDS {
            
            return allRecords.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // if indexPath.section == SECTION_RECORDS {
            let recordCell = tableView.dequeueReusableCell(withIdentifier: CELL_RECORD, for: indexPath) as! HistoryCellTableViewCell
            let record = allRecords[indexPath.row]
            
            var redFloat: Float = Float(record.red)/255.0
            var blueFloat: Float = Float(record.blue)/255.0
            var greenFloat: Float = Float(record.green)/255.0
            
            
            recordCell.historyImageView.backgroundColor = UIColor(red: CGFloat(redFloat), green: CGFloat(greenFloat), blue:CGFloat (blueFloat), alpha: 1.0)

            
            recordCell.temperatureLabel.text = String(record.temp)+" °C"
            recordCell.timeStampLabel.text = record.timeStamp
            recordCell.luminosityLabel.text = String(record.lux)+" lux"
            
            return recordCell
        //}
        
//        let countCell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
//        countCell.textLabel?.text = "\(allRecords.count) records in the database"
//        countCell.selectionStyle = .none
//        return countCell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
