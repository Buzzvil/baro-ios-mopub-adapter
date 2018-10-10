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
      BuzzNative.configure(logging: false)
      BuzzNativeInitialized = true
    }

    if let placementId = info["unitID"] as? String {
      let adLoader = BNAdLoader(unitId: placementId)
      adLoader.loadAd(userProfile: nil, location: nil) { [weak self] (ad, error) in
        if let ad = ad {
          let adAdapter = BuzzNativeAdAdapter(ad: ad)
          let mpAd = MPNativeAd(adAdapter: adAdapter)
          
          if let urlString = ad.creative.imageURL, let url = URL(string: urlString) {
            self?.precacheImages(withURLs: [url], completionBlock: { (errors) in
              if errors == nil {
                self?.delegate.nativeCustomEvent(self, didLoad: mpAd)
              } else {
                self?.delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForImageDownloadFailure())
              }
            })
          } else {
            self?.delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForInvalidImageURL())
          }
        } else {
          self?.delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForInvalidAdServerResponse(error?.localizedDescription))
        }
      }
    } else {
      delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForNoInventory())
    }
  }
}
