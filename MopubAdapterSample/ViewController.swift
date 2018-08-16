//
//  ViewController.swift
//  MopubAdapterSample
//
//  Created by Jaehee Ko on 16/08/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MPTableViewAdPlacerDelegate {

  @IBOutlet var tableView: UITableView!
  var placer: MPTableViewAdPlacer!

  override func viewDidLoad() {
    super.viewDidLoad()

    let settings = MPStaticNativeAdRendererSettings()
    settings.renderingViewClass = MopubAdCell.self
    settings.viewSizeHandler = { maxWidth in return CGSize(width: maxWidth, height: 180) }

    let config = MPStaticNativeAdRenderer.rendererConfiguration(with: settings)

    placer = MPTableViewAdPlacer(tableView: tableView, viewController: self, rendererConfigurations: [config!])
    placer.delegate = self;

    placer.loadAds(forAdUnitID: "76a3fefaced247959582d2d2df6f4757") // 5e9875f612744641ac2ed9faeaf134b2
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
