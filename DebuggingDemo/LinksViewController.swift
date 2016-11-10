//
//  ViewController.swift
//  DebuggingDemo
//
//  Created by Hesham Abd-Elmegid on 7/17/16.
//  Copyright © 2016 CareerFoundry. All rights reserved.
//

import UIKit
import SafariServices

class LinksViewController: UITableViewController, SFSafariViewControllerDelegate {
    let userDefaultsKey = "LinksUserDefaultsKey.Debugging"
    
    var links: Array<String> {
        get {
            let linksFromUserDefaults = NSUserDefaults.standardUserDefaults().objectForKey(userDefaultsKey)
            return linksFromUserDefaults as! Array<String>
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: userDefaultsKey)
        }
    }
    
    @IBAction func tappedAddButton(sender: AnyObject) {
        let alertController = UIAlertController(title: "New Link", message: "Add link to save for later.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .Default) { (action) in
            if let link = alertController.textFields?.first?.text {
                self.links.append(link)
                self.tableView.reloadData()
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Link"
            textField.keyboardType = .URL
        }
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LinkCell", forIndexPath: indexPath)
        cell.textLabel?.text = links[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        openURL(links[indexPath.row])
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func openURL(urlString: String) {
        let url = NSURL(string: urlString)!
        let safariViewController = SFSafariViewController(URL: url)
        safariViewController.delegate = self
        self.presentViewController(safariViewController, animated: true, completion: nil)
    }
}
