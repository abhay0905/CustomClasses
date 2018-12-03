//
//  PickerClass.swift
//  Abhay Shankar
//
//  Created by Abhay Shankar on 11/06/18.
//  Copyright © 2018 Abhay Shankar. All rights reserved.
//

import UIKit

/// cutom class to creat custom pickers
class PickerClass: NSObject,UIPickerViewDelegate, UIPickerViewDataSource {

    /// Block executed when Done buttom is selected
    var doneBlock: ((Int) -> Void) = {_ in }
    
    /// Block called when cancel button is selected
    var cancelBlock: (() -> Void) = {  }

    
    /// List of String to be used as Datasource for Picker
    var arrData : [String] = []
    
    
    /// Picker class object
    /// - Important: initialised after setUpPicker is called
    var customPicker: UIPickerView!
    
    
    /// Setup Picker view
    ///
    /// - Parameter customList: List of String to be used as Datasource for Picker
    /// - Returns: Picker class object
    func setUpPicker(customList:[String]) -> UIPickerView
    {
        arrData = customList;
        
        customPicker = UIPickerView.init()
        
        customPicker.backgroundColor = UIColor.white
        
        customPicker.delegate = self
        customPicker.dataSource = self
        
        customPicker.reloadAllComponents()
        
        return customPicker
    }
    
    /// Setup Toolbar object
    ///
    /// - Returns: Toolbar object 
    func setUpToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height:40))
        
        toolbar.isTranslucent = false
        
        toolbar.barTintColor = UIColor.white
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(actionDone))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(actionCancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        doneButton.tintColor = UIColor.black
        
        cancelButton.tintColor = UIColor.black
        
        toolbar.setItems([cancelButton,flexibleSpace,doneButton], animated: true)
        
        return toolbar
    }
    
    
    //MARK:- Picker Actions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return arrData.count
       
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return arrData[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
        
    }
    
    // MARK: - Obj C Methods
    
    @objc func actionDone(){
        doneBlock(customPicker.selectedRow(inComponent: 0))
        
    }
    
    @objc func actionCancel(){
        cancelBlock()
    }
}
