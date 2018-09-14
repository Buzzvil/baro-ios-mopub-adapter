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
    config?.supportedCustomEvents = ["BuzzNativeCustomEvent"]

    placer = MPTableViewAdPlacer(tableView: tableView, viewController: self, rendererConfigurations: [config!])
    placer.delegate = self;

    placer.loadAds(forAdUnitID: "5e9875f612744641ac2ed9faeaf134b2") // 5e9875f612744641ac2ed9faeaf134b2, test: 76a3fefaced247959582d2d2df6f4757
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell")!
    cell.textLabel?.text = "\(indexPath.row)"
    return cell
  }
}
