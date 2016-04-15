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
    let topTextFieldDelegate = textFieldDelegate()
    let bottomTextFieldDelegate = textFieldDelegate()
    var theMeme:AppDelegate.Meme?
    @IBOutlet weak var theToolbar: UIToolbar!
    
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
        self.topTextFieldDelegate.hasBeenEdited = false
        self.bottomTextFieldDelegate.hasBeenEdited = false
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
    
    //subscribe to keyboard notifications whent he bottom text field is editing
    @IBAction func bottomTextFieldEditing(sender: AnyObject) {
        self.subscribeToKeyboardNotifications()
        
    }
    
    @IBAction func dismissPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    //before keyboard shows move the view frame up by height of keyboard
    func keyboardWillShow(notification:NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }

    //before keyboard hides move the view frame down by height of keyboard
    func keyboardWillHide(notification:NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
        unsubscribeFromKeyboardNotifications()

    }
    
    //returns keyboard height
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }

    //subscribe to the show & hide keyboard notifications
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }
    
    //unsubscribe from show & hide keyboard notifications
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)

    }
    
    @IBAction func saveMeme(sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
        theMeme = AppDelegate.Meme(image: theImage.image!, topText: topTextField.text!, bottomText: bottomTextField.text!, memedImage: memedImage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.memes.append(theMeme!)
    }

    func generateMemedImage() -> UIImage
    {
        self.theToolbar.hidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.theToolbar.hidden = false
        return memedImage
    }
    
}

