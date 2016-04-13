//
//  ViewController.swift
//  MemeMaker
//
//  Created by Belinda Vennam on 4/11/16.
//  Copyright © 2016 Belinda Vennam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    var topIsEdited:Bool?
    var bottomIsEdited:Bool?
    
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
        self.topTextField.delegate = self
        topTextField.defaultTextAttributes = textAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        self.bottomTextField.delegate = self
        bottomTextField.defaultTextAttributes = textAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
        topIsEdited = false
        bottomIsEdited = false
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
        theImage.image = image
        topTextField.text = "TOP"
        topTextField.hidden = false
        bottomTextField.text = "BOTTOM"
        bottomTextField.hidden = false
        //after selecting image dismiss the view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == topTextField && topIsEdited == false) {
            textField.text = ""
            topIsEdited = true
        } else if (textField == bottomTextField && bottomIsEdited == false) {
            textField.text = ""
            bottomIsEdited = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

}

