//
//  BAROCustomEvent.swift
//  MopubAdapterSample
//
//  Created by Jaehee Ko on 27/08/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import BARO
import MoPub // Delete this line if you integrate MoPub with source codes

private var BAROInitialized = false
private var TargetUserProfile: BAROUserProfile?
private var TargetLocation: BAROLocation?

@objc(BAROCustomEvent)
class BAROCustomEvent: MPNativeCustomEvent {
  public static func setTargeting(userProfile: BAROUserProfile?, location: BAROLocation?) {
    TargetUserProfile = userProfile
    TargetLocation = location
  }

  override func requestAd(withCustomEventInfo info: [AnyHashable : Any]!) {
    if !BAROInitialized {
      BARO.configure(BAROEnvProduction, mediationAdapterClasses: nil, logging: true)
      BAROInitialized = true
    }

    if let placementId = info["unitID"] as? String {
      let adLoader = BAROAdLoader(unitId: placementId, preloadEnabled: false)
      adLoader?.loadAd(with: TargetUserProfile, location: TargetLocation) { [weak self] (ad, error) in
        if let ad = ad {
          let adAdapter = BAROAdAdapter(ad: ad)
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
