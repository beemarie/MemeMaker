//
//  MemeCollectionViewController.swift
//  MemeMaker
//
//  Created by Belinda Vennam on 4/14/16.
//  Copyright © 2016 Belinda Vennam. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {

    var memes:[AppDelegate.Meme]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = appDelegate.memes
        self.collectionView?.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes!.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let theCell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollCell", forIndexPath: indexPath) as! MemeCell
        theCell.imageView.image = memes![indexPath.row].image
        return theCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController = segue.destinationViewController as! ViewController
        destViewController.hidesBottomBarWhenPushed = true
    }
    
}