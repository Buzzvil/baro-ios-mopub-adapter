//
//  BuzzNativeAdAdapter.swift
//  MopubAdapterSample
//
//  Created by Jaehee Ko on 27/08/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import BuzzNative

@objc(BuzzNativeAdAdapter)
class BuzzNativeAdAdapter: NSObject, MPNativeAdAdapter {
  public var properties: [AnyHashable : Any]!
  var defaultActionURL: URL!
  var delegate: MPNativeAdAdapterDelegate!

  var ad: BNAd!

  init(ad: BNAd) {
    super.init()
    self.ad = ad

    var properties: [AnyHashable: Any] = [:]
    properties[kAdTitleKey] = ad.creative.title
    properties[kAdTextKey] = ad.creative.description
    properties[kAdMainImageKey] = ad.creative.imageURL
    properties[kAdIconImageKey] = ad.creative.iconURL
    properties[kAdCTATextKey] = ad.creative.callToAction
    self.properties = properties

    if let url = ad.creative.clickURL {
      self.defaultActionURL = URL(string: url)
    }
  }

  func enableThirdPartyClickTracking() -> Bool {
    return false
  }

  func willAttach(to view: UIView!) {

    
//    if let nativeAdRendering = delegate.viewControllerForPresentingModalView() as? MPNativeAdRendering {
////      [self.fbNativeAd registerViewForInteraction:view mediaView:self.mediaView iconView:self.iconView viewController:[self.delegate viewControllerForPresentingModalView]];
// delegate.viewControllerForPresentingModalView().view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(trackClick)))
//    }
  }

  func displayContent(for URL: URL!, rootViewController controller: UIViewController!) {

  }

  func trackClick() {
//    nativeAd.handleClick()
  }


}
