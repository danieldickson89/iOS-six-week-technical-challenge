//
//  EntitiesListTableViewController.swift
//  PairRandomizer
//
//  Created by Daniel Dickson on 3/11/16.
//  Copyright © 2016 Daniel Dickson. All rights reserved.
//

import UIKit

class EntitiesListTableViewController: UITableViewController {
    
    var entity: Entity?

    @IBOutlet weak var randomizeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomizeButton.layer.cornerRadius = 4
        
        EntityController.sharedController.randomizeList(EntityController.sharedController.randomEntities)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntityController.sharedController.randomEntities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entityCell", forIndexPath: indexPath)

        let entity = EntityController.sharedController.randomEntities[indexPath.row]
        
        cell.textLabel?.text = entity.name
        
        let rowNumber = indexPath.row
        
        let bluePartners: [Int] = createPartnerColors(0, num2: 1)
        let brownPartners: [Int] = createPartnerColors(2, num2: 3)
        let redPartners: [Int] = createPartnerColors(4, num2: 5)
        
        if bluePartners.contains(rowNumber) {
            cell.textLabel?.textColor = UIColor.blueColor()
        } else if brownPartners.contains(rowNumber) {
            cell.textLabel?.textColor = UIColor.brownColor()
        } else if redPartners.contains(rowNumber) {
            cell.textLabel?.textColor = UIColor.redColor()
        } else {
            cell.textLabel?.textColor = UIColor.blackColor()
        }

        return cell
    }
    
    func createPartnerColors(num1: Int, num2: Int) -> [Int] {
        var array: [Int] = []
        
        for var i = num1; i <= 100; i += 6 {
            array.append(i)
        }
        
        for var j = num2; j <= 100; j += 6 {
            array.append(j)
        }
        return array
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let entity = EntityController.sharedController.randomEntities[indexPath.row]
            EntityController.sharedController.removeEntity(entity)
            EntityController.sharedController.randomizeList(EntityController.sharedController.randomEntities)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.reloadData()
        }
    }
    
    // MARK: -Actions
    
    @IBAction func randomizeButtonClicked(sender: AnyObject) {
        
        EntityController.sharedController.randomizeList(EntityController.sharedController.randomEntities)

        self.tableView.reloadData()
        
    }
    
    var tField: UITextField!
    
    func configurationTextField(textField: UITextField!)
    {
        textField.placeholder = "Enter Entity Name"
        tField = textField
    }

    @IBAction func addEntityButtonClicked(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Add Entity", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
            
            // Add Entity here
            if let name = self.tField.text {
                let newEntity = Entity(name: name)
                EntityController.sharedController.addEntity(newEntity)
                EntityController.sharedController.randomizeList(EntityController.sharedController.randomEntities)
                self.tableView.reloadData()
            }
            
        }))
        self.presentViewController(alert, animated: true, completion: {
        })
        
    }

}
