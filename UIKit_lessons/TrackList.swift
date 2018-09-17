//
//  TrackList.swift
//  UIKit_lessons
//
//  Created by Konstantin on 17.09.2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class TrackList: UITableViewController {

    let imageNameArray = ["Alberto Ruiz - 7 Elements (Original Mix)",
    "Dave Wincent - Red Eye (Original Mix)",
    "E-Spectro - End Station (Original Mix)",
    "Edna Ann - Phasma (Konstantin Yoodza Remix)",
    "Ilija Djokovic - Delusion (Original Mix)",
    "John Baptiste - Mycelium (Original Mix)",
    "Lane 8 - Fingerprint (Original Mix)",
    "Mac Vaughn - Pink Is My Favorite Color (Alex Stein Remix)",
    "Metodi Hristov, Gallya - Badmash (Original Mix)",
    "Veerus, Maxie Devine - Nightmare (Original Mix)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imageNameArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath)

        cell.imageView?.image = UIImage(named: imageNameArray[indexPath.row])
        cell.textLabel?.text = imageNameArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }

    //ограничиваем высоту ячейки для cell.textLabel?.numberOfLines = 0
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! DetailVC
                detailVC.trackTitle = imageNameArray[indexPath.row]
            }
        }
    }

}
