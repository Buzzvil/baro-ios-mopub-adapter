//
//  BuzzNativeAdAdapter.swift
//  MopubAdapterSample
//
//  Created by Jaehee Ko on 27/08/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import BuzzNative
import MoPub // Delete this line if you integrate MoPub with source codes

@objc(BuzzNativeAdAdapter)
class BuzzNativeAdAdapter: NSObject, MPNativeAdAdapter, MPAdImpressionTimerDelegate {
  var properties: [AnyHashable : Any]!
  var defaultActionURL: URL!
  var delegate: MPNativeAdAdapterDelegate!
  
  let impressionTimer: MPAdImpressionTimer
  
  var ad: BNAd!

  init(ad: BNAd) {
    self.ad = ad

    var properties: [AnyHashable: Any] = [:]
    properties[kAdTitleKey] = ad.creative.title
    properties[kAdTextKey] = ad.creative.description
    properties[kAdMainImageKey] = ad.creative.imageURL
    properties[kAdIconImageKey] = ad.creative.iconURL
    properties[kAdCTATextKey] = ad.creative.callToAction
    properties[kImpressionTrackerURLsKey] = ad.impressionTrackers
    properties[kClickTrackerURLKey] = ad.clickTrackers
    properties[kPrivacyIconTapDestinationURL] = ad.creative.adchoiceURL
    self.properties = properties

    if let url = ad.creative.clickURL {
      self.defaultActionURL = URL(string: url)
    }
    
    self.impressionTimer = MPAdImpressionTimer(requiredSecondsForImpression: 0.5, requiredViewVisibilityPercentage: 0.5)

    super.init()
    
    impressionTimer.delegate = self
  }
  
  func willAttach(to view: UIView!) {
    willAttach(to: view, withAdContentViews: [])
  }
  
  func willAttach(to view: UIView!, withAdContentViews adContentViews: [Any]!) {
    impressionTimer.startTrackingView(view)
  }
  
  func adViewWillLogImpression(_ adView: UIView!) {
    BNAdTracker().impressed(ad: ad)
    delegate.nativeAdWillLogImpression?(self)
  }

  func trackClick() {
    BNAdTracker().clicked(ad: ad)
  }
  
  func displayContent(for URL: URL!, rootViewController controller: UIViewController!) {
    if #available(iOS 10.0, *) {
      UIApplication.shared.open(URL, options: [:], completionHandler: nil)
    } else {
      UIApplication.shared.openURL(URL)
    }
  }
}
