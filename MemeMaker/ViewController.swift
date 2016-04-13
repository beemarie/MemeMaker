//
//  ViewController.swift
//  MemeMaker
//
//  Created by Belinda Vennam on 4/11/16.
//  Copyright © 2016 Belinda Vennam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    var topIsEdited:Bool?
    var bottomIsEdited:Bool?
    let topTextFieldDelegate = textFieldDelegate()
    let bottomTextFieldDelegate = textFieldDelegate()
    
    //dictionary of text attributes
    let textAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSFontAttributeName:  UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeWidthAttributeName: -1.0,
    ]
    

    var imagePicker: UIImagePickerController?
    @IBOutlet weak var theImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topTextField.delegate = topTextFieldDelegate
        self.topTextField.defaultTextAttributes = textAttributes
        self.topTextField.textAlignment = NSTextAlignment.Center
        self.bottomTextField.delegate = bottomTextFieldDelegate
        self.bottomTextField.defaultTextAttributes = textAttributes
        self.bottomTextField.textAlignment = NSTextAlignment.Center

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectImage(sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker!.delegate = self
        presentViewController(imagePicker!, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        //after selecting the image, set the image & show the textfields
        theImage.image = image
        topTextField.text = "TOP"
        topTextField.hidden = false
        bottomTextField.text = "BOTTOM"
        bottomTextField.hidden = false
        
        //after selecting image dismiss the view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func bottomTextFieldEditing(sender: AnyObject) {
        self.subscribeToKeyboardNotifications()
        
    }
    
    @IBAction func bottomTextFieldEditingEnd(sender: AnyObject) {
        self.unsubscribeToKeyboardNotifications()
    }

    func keyboardWillShow(notification:NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }

    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)

//        NSNotificationCenter.defaultCenter().remove(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }

}

