//
//  BuzzNativeCustomEvent.swift
//  MopubAdapterSample
//
//  Created by Jaehee Ko on 27/08/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import BuzzNative

fileprivate var BuzzNativeInitialized = false

@objc(BuzzNativeCustomEvent)
class BuzzNativeCustomEvent: MPNativeCustomEvent {
  override func requestAd(withCustomEventInfo info: [AnyHashable : Any]!) {
    if !BuzzNativeInitialized {
      BuzzNative.configure(logging: true)
      BuzzNativeInitialized = true
    }

    if let placementId = info["unitID"] as? String {
      let adLoader = BNAdLoader(unitId: placementId)
      adLoader.loadAd(userProfile: nil, location: nil) { [weak self] (ad, error) in
        if let ad = ad {
          let adAdapter = BuzzNativeAdAdapter(ad: ad)
          let mpAd = MPNativeAd(adAdapter: adAdapter)
          self?.delegate.nativeCustomEvent(self, didLoad: mpAd)
        } else {
          self?.delegate.nativeCustomEvent(self, didFailToLoadAdWithError: error)
        }
      }
    } else {
      delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForNoInventory())
    }
  }
}
