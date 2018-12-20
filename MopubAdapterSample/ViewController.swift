//
//  ViewController.swift
//  MopubAdapterSample
//
//  Created by Jaehee Ko on 16/08/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import UIKit
import MoPub
import MoPub_AdMob_Adapters
import MoPub_FacebookAudienceNetwork_Adapters
import BARO

class ViewController: UIViewController, MPTableViewAdPlacerDelegate {

  @IBOutlet var tableView: UITableView!
  @IBOutlet var adContainer: UIView!

  var placer: MPTableViewAdPlacer!

  override func viewDidLoad() {
    super.viewDidLoad()

//    let settings = MPStaticNativeAdRendererSettings()
//    settings.renderingViewClass = MopubAdCell.self
//    settings.viewSizeHandler = { maxWidth in return CGSize(width: maxWidth, height: 180) }
//
//    let config = MPStaticNativeAdRenderer.rendererConfiguration(with: settings)
//    config?.supportedCustomEvents = ["BAROCustomEvent"]
//
//    BAROCustomEvent.setTargeting(userProfile: nil, location: nil)
//
//    placer = MPTableViewAdPlacer(tableView: tableView, viewController: self, rendererConfigurations: [config!])
//    placer.delegate = self;
//
//    placer.loadAds(forAdUnitID: "5e9875f612744641ac2ed9faeaf134b2") // 5e9875f612744641ac2ed9faeaf134b2, test: 76a3fefaced247959582d2d2df6f4757
  }

  @IBAction func loadButtonTapped() {

    BAROCustomEvent.setTargeting(userProfile: BAROUserProfile(birthday: nil, gender: BAROUserGenderMale), location: BAROLocation(latitude: 0, longitude: 0))
    let settings = MPStaticNativeAdRendererSettings()
    settings.renderingViewClass = MopubAdView.self
    settings.viewSizeHandler = { maxWidth in return CGSize(width: maxWidth, height: 180) }

    let config = MPStaticNativeAdRenderer.rendererConfiguration(with: settings)
    config?.supportedCustomEvents = ["BAROCustomEvent", "FacebookNativeCustomEvent", "DapNativeCustomEvent", "MPGoogleAdMobNativeCustomEvent"]

    BAROCustomEvent.setTargeting(userProfile: nil, location: nil)

    let request = MPNativeAdRequest(adUnitIdentifier: "279806f39aa84eda9efef8b94433373c", rendererConfigurations: [config])

    let targeting = MPNativeAdRequestTargeting()

//    targeting.desiredAssets = Set([kAdIconImageKey, kAdCTATextKey, kAdTextKey, kAdTitleKey])

    request?.targeting = targeting
    request?.start(completionHandler: { (req, ad, err) in
      DispatchQueue.main.async {
        do {
          if let v = try ad?.retrieveAdView() {
            v.frame = self.adContainer.bounds
            self.adContainer.subviews.first?.removeFromSuperview()
            self.adContainer.addSubview(v)
          }
        } catch {

        }
      }

    })
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
