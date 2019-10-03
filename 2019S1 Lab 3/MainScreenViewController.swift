//
//  MainScreenViewController.swift
//  2019S1 Lab 3
//
//  Created by Mashaal on 2/10/19.
//  Copyright © 2019 Michael Wybrow. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, DatabaseListener {
    
    
    func onRecordListChange(change: DatabaseChange, records: [SensorData]) {
        
         tempLabel.text = String(PerpetualReadings.latestReadings.temp)
        var redFloat: Float = Float(PerpetualReadings.latestReadings.red)/255.0
        var blueFloat: Float = Float(PerpetualReadings.latestReadings.blue)/255.0
        var greenFloat: Float = Float(PerpetualReadings.latestReadings.green)/255.0

        
        colourImageView.backgroundColor = UIColor(red: CGFloat(redFloat), green: CGFloat(greenFloat), blue:CGFloat (blueFloat), alpha: 1.0)
    }
    


    weak var databaseController: DatabaseProtocol?
    @IBOutlet weak var colourImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    var listenerType = ListenerType.records
    
    var lastRecord: [SensorData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "allRecordSegue"
        {
            let destinationViewController = segue.destination as! AllHeroesTableViewController
        }
    }
    

  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
