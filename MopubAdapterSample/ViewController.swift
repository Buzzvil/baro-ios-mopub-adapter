//
//  ViewController.swift
//  MopubAdapterSample
//
//  Created by Jaehee Ko on 16/08/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath)
    cell.textLabel?.text = "\(indexPath.row)"
    return cell
  }
}

