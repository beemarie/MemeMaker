//
//  TopTextFieldDelegate.swift
//  MemeMaker
//
//  Created by Belinda Vennam on 4/13/16.
//  Copyright © 2016 Belinda Vennam. All rights reserved.
//

import Foundation
import UIKit


class textFieldDelegate: NSObject, UITextFieldDelegate {
    
    var hasBeenEdited:Bool?

    
    override init() {
        super.init()
        hasBeenEdited = false
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (hasBeenEdited == false) {
            textField.text = ""
            hasBeenEdited = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    

    
    
}