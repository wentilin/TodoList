//
//  ViewController.swift
//  TodoList
//
//  Created by wentilin on 15/7/3.
//  Copyright (c) 2015年 wentilin. All rights reserved.
//

import UIKit

var todos: [TodoModel] = []
var filteredTodos: [TodoModel] = []

func dateFromString(dateStr:String) -> NSDate? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.dateFromString(dateStr)
    
    return date
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var todoTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        todos = [TodoModel(id: "1", image: "selected-child", title: "1. 去游乐场", date: dateFromString("2014-10-20")!),
            TodoModel(id: "2", image: "selected-shopping-cart", title: "2. 购物", date: dateFromString("2014-10-28")!),
            TodoModel(id: "3", image: "selected-phone", title: "3. 打电话", date: dateFromString("2014-10-30")!),
            TodoModel(id: "4", image: "selected-plane", title: "4. Travel to Europe", date: dateFromString("2014-10-31")!)]
        
        todoTableView.dataSource = self
        todoTableView.delegate = self
        searchBar.delegate = self
        
        todoTableView.rowHeight = 60
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredTodos.count != 0 {
            return filteredTodos.count
        }
        return todos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ToDoCellIdentifier") as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ToDoCellIdentifier")
        }
        
        var todo:TodoModel
        if filteredTodos.count != 0 {
            todo = filteredTodos[indexPath.row]
        } else {
            todo = todos[indexPath.row]
        }
        
        let label1 = cell?.viewWithTag(102) as! UILabel
        label1.text = todo.title
        
        let locale = NSLocale.currentLocale()
        let dateformat = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = dateformat!
        
        let label2 = cell?.viewWithTag(103) as! UILabel
        label2.text = dateformatter.stringFromDate(todo.date)
        
        let imageView = cell?.viewWithTag(101) as! UIImageView
        imageView.image = UIImage(named: todo.image)
        
        return cell!
    }
    
    // MARK - UITableViewDelegate
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            todos.removeAtIndex(indexPath.row)
            self.todoTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.todoTableView.setEditing(editing, animated: animated)
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return editing
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let todo = todos.removeAtIndex(sourceIndexPath.row)
        todos.insert(todo, atIndex: destinationIndexPath.row)
    }
    
    //search
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTodos = todos.filter() {$0.title.rangeOfString(searchText) != nil}
        
        todoTableView.reloadData()
        
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        println("close")
        todoTableView.reloadData()
    }
}

