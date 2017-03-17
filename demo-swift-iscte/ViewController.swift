//
//  ViewController.swift
//  demo-swift-iscte
//
//  Created by Filipe Patricio on 17/03/2017.
//  Copyright © 2017 Filipe Patricio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  var names: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func changeTitleAction(_ sender: Any) {
    //    self.titleLabel.text = self.textField.text
    guard let name = self.textField.text else{
      print("self.textField.text shouldn't be nil")
      return
    }
    
    self.names.append(name)
    self.tableView.reloadData()
  }
  
}

extension ViewController: UITableViewDataSource{
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return self.names.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    guard let cellTextLabel = cell.textLabel else{
      print("cell.textLabel shouldn't be nil")
      fatalError()
    }
    
    cellTextLabel.text = self.names[indexPath.row]
    
    return cell
  }
}


extension ViewController: UITableViewDelegate{
  
}

