//
//  MopubAdView.swift
//  MopubAdapterSample
//
//  Created by Jaehee Ko on 28/11/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import UIKit
import MoPub

class MopubAdView: UIView, MPNativeAdRendering {

  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var bodyLabel: UILabel!
  @IBOutlet var callToActionLabel: UILabel!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var iconImageView: UIImageView!
  @IBOutlet var adchoiceImageView: UIImageView!

  static func nibForAd() -> UINib! {
    return UINib(nibName: "MopubAdView", bundle: nil)
  }
  
  func nativeTitleTextLabel() -> UILabel! {
    return titleLabel
  }

  func nativeMainTextLabel() -> UILabel! {
    return bodyLabel
  }

  func nativeCallToActionTextLabel() -> UILabel! {
    return callToActionLabel
  }

  func nativeMainImageView() -> UIImageView! {
    return imageView
  }

  func nativeIconImageView() -> UIImageView! {
    return iconImageView
  }

  func nativePrivacyInformationIconImageView() -> UIImageView! {
    return adchoiceImageView
  }
}
