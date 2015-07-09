//
//  DetailViewController.swift
//  TodoList
//
//  Created by wentilin on 15/7/4.
//  Copyright (c) 2015年 wentilin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var todoTextField: UITextField!
    
    @IBOutlet weak var todoDate: UIDatePicker!
    
    var images: [String] = ["selected-child", "selected-phone", "selected-shopping-cart", "selected-plane"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        todoTextField.delegate = self
    }

    func resetItem() {
        for (var i = 0; i < 4; i++) {
            let item = self.view.viewWithTag(i+1) as! UIButton
            item.selected = false
        }
    }
    
    @IBAction func itemTapped(sender: UIButton) {
        self.resetItem()
        sender.selected = true
    }
    
   
    @IBAction func todoDone(sender: AnyObject) {
        println("todo")
        var image: String = ""
        for (var i = 0; i < 4; i++) {
            let item = self.view.viewWithTag(i+1) as! UIButton
            if item.selected {
                image = images[i]
            }
        }
        
        var title = todoTextField.text
        var date = todoDate.date
        var id = NSUUID().UUIDString
        
        var todoModel = TodoModel(id: id, image: image, title: title, date: date)
        
        todos.append(todoModel)
        
        //添加本地通知
        let localNofication = UILocalNotification()
        localNofication.fireDate = todoDate.date
        localNofication.alertBody = title
        localNofication.alertAction = "Show me the item"
        localNofication.timeZone = NSTimeZone.defaultTimeZone()
        localNofication.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNofication)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        todoTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        todoTextField.resignFirstResponder()
        return true
    }
}
