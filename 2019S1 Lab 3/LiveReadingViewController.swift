//
//  LiveReadingViewController.swift
//  2019S1 Lab 3
//
//  Created by Laveeshka Mahadea on 3/10/19.
//  Copyright © 2019 Michael Wybrow. All rights reserved.
//

import UIKit



class LiveReadingViewController: UIViewController, DatabaseListener {
    var listenerType = ListenerType.records
    weak var databaseController: DatabaseProtocol?
    @IBOutlet weak var homeImageView: UIImageView!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var luxLabel: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        databaseController?.removeListener(listener: self)
    }
    
    func onRecordListChange(change: DatabaseChange, records: [SensorData]) {
        tempLabel.text = String(PerpetualReadings.latestReadings.temp)+" °C"
        luxLabel.text = String(PerpetualReadings.latestReadings.lux)+" lux"
        
        var redFloat: Float = Float(PerpetualReadings.latestReadings.red)/255.0
        var blueFloat: Float = Float(PerpetualReadings.latestReadings.blue)/255.0
        var greenFloat: Float = Float(PerpetualReadings.latestReadings.green)/255.0
        
    
        homeImageView.tintColor = UIColor(red: CGFloat(redFloat), green: CGFloat(greenFloat), blue:CGFloat (blueFloat), alpha: 1.0)
        //homeImageView.image = newImage
       // homeImageView.tintColor = UIColor(red: CGFloat(redFloat), green: CGFloat(greenFloat), blue:CGFloat (blueFloat), alpha: 1.0)
        //homeImageView.backgroundColor = UIColor(red: CGFloat(redFloat), green: CGFloat(greenFloat), blue:CGFloat (blueFloat), alpha: 1.0)
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
