//
//  PlayerViewController.swift
//  Raiting
//
//  Created by Liudmila Russu on 4/20/17.
//  Copyright © 2017 Liudmila Russu. All rights reserved.
//

import UIKit

class PlayerViewController: UITableViewController {
    var persons:[Person] = personsData
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)  as! PlayerCell
        
        let person = persons[indexPath.row] as Person
        cell.person = person
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func imageForRating(rating:Int) -> UIImage? {
        let imageName = "\(rating)Stars"
        return UIImage(named: imageName)
    }

    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func savePlayerDetail(segue:UIStoryboardSegue) {
        if let playerDetailsViewController = segue.source as? PlayerDetailsViewController {
            
            //add the new player to the players array
            if let person = playerDetailsViewController.person {
                persons.append(person)
                
                //update the tableView
                let indexPath = IndexPath(row: persons.count-1, section: 0)
                tableView.beginUpdates()
                tableView.insertRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                
            }
        }
    }
    
}
