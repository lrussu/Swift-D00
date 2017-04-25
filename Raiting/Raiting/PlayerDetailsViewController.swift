//
//  PlayerDetailsViewControllerTableViewController.swift
//  Raiting
//
//  Created by Liudmila Russu on 4/20/17.
//  Copyright © 2017 Liudmila Russu. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBAction func tappedDateTextField(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        sender.inputView = datePickerView
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
    }
    
    func datePickerValueChanged(_ sender:UIDatePicker) {
        dateTextField?.text = sender.date.toString()
    }
    
    
    @IBOutlet weak var reasonTextView: UITextView!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }

    
    var person:Person?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SavePersonDetail" {
            person = Person(name: nameTextField.text, reason: reasonTextView.text, date: dateTextField.text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 }

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy hh:mm"
        return dateFormatter.string(from: self)
    }
}


