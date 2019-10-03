//
//  AllHeroesTableViewController.swift
//  2019S1 Lab 3
//
//  Created by Michael Wybrow on 15/3/19.
//  Copyright © 2019 Michael Wybrow. All rights reserved.
//

import UIKit

class AllHeroesTableViewController: UITableViewController, DatabaseListener  {

    let SECTION_RECORDS = 0;
    let SECTION_COUNT = 1;
    let CELL_RECORD = "recordCell"
    let CELL_COUNT = "totalRecordsCell"
    
    var allRecords: [SensorData] = []
    var filteredRecords: [SensorData] = []
    weak var databaseController: DatabaseProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the database controller once from the App Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        
//        let searchController = UISearchController(searchResultsController: nil);
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search Records"
//        navigationItem.searchController = searchController
//
//        // This view controller decides how the search controller is presented.
//        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//        if let searchText = searchController.searchBar.text?.lowercased(), searchText.count > 0 {
//            filteredRecords = allRecords.filter({(record: SensorData) -> Bool in
//                return record.name.lowercased().contains(searchText)
//            })
//        }
//        else {
//            filteredRecords = allRecords;
//        }
    
//        tableView.reloadData();
//    }

    // MARK: - Database Listener
    
    var listenerType = ListenerType.records

//    func onTeamChange(change: DatabaseChange, teamHeroes: [SuperHero]) {
//        // Won't be called.
//    }
//
    func onRecordListChange(change: DatabaseChange, records: [SensorData]) {
        allRecords = records

            self.tableView.reloadData()
        

//        updateSearchResults(for: navigationItem.searchController!)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SECTION_RECORDS {
            
            return allRecords.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_RECORDS {
            let recordCell = tableView.dequeueReusableCell(withIdentifier: CELL_RECORD, for: indexPath) as! SensorDataTableViewCell
            let record = allRecords[indexPath.row]
            recordCell.redLabel.text = String(record.red)
            recordCell.blueLabel.text = String(record.blue)
            recordCell.greenLabel.text = String(record.green)
            recordCell.tempLabel.text = String(record.temp)
            recordCell.timeLabel.text = record.timeStamp
            recordCell.luxLabel.text = String(record.lux)
            
            return recordCell
        }
        
        let countCell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
        countCell.textLabel?.text = "\(allRecords.count) records in the database"
        countCell.selectionStyle = .none
        return countCell
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == SECTION_COUNT {
//            tableView.deselectRow(at: indexPath, animated: false)
//            return
//        }
//
////        if superHeroDelegate!.addSuperHero(newHero: filteredHeroes[indexPath.row]) {
////            navigationController?.popViewController(animated: true)
////            return
////        }
//
//        tableView.deselectRow(at: indexPath, animated: true)
//        displayMessage(title: "Cannot add Records", message: "Party is full or superhero is already in the party.")
//    }
    
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

    // MARK: - Navigation

        
    func displayMessage(title: String, message: String) {
        // Setup an alert to show user details about the Person
        // UIAlertController manages an alert instance
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }


}
