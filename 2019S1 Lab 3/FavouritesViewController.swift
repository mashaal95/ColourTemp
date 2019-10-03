//
//  FavouritesViewController.swift
//  2019S1 Lab 3
//
//  Created by Laveeshka Mahadea on 3/10/19.
//  Copyright © 2019 Michael Wybrow. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var proCollectionView: UICollectionView!
    
    var array = ["First", "Second", "Third", "Fourth", "Fifth", "Sixth"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        proCollectionView.dataSource = self
        proCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return The number of rows in section.
        return array.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //return A configured cell object.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "proCell", for: indexPath) as! FavouritesCellCollectionViewCell
        
        cell.prolbl.text = array[indexPath.row]
        cell.backgroundColor = UIColor.blue
        
        return cell

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
