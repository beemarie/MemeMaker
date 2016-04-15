//
//  MemeTableViewController.swift
//  MemeMaker
//
//  Created by Belinda Vennam on 4/14/16.
//  Copyright © 2016 Belinda Vennam. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes:[AppDelegate.Meme]?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = appDelegate.memes
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let theCell = tableView.dequeueReusableCellWithIdentifier("MemeCell")
        theCell?.textLabel!.text = memes![indexPath.row].topText + memes![indexPath.row].bottomText
        theCell?.imageView?.image = memes![indexPath.row].image
        return theCell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController = segue.destinationViewController as! ViewController
        destViewController.hidesBottomBarWhenPushed = true
    }
    
}