//
//  MopubAdCell.swift
//  MopubAdapterSample
//
//  Created by Jaehee Ko on 16/08/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import UIKit
import MoPub

class MopubAdCell: UITableViewCell, MPNativeAdRendering {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var mainTextLabel: UILabel!
  @IBOutlet weak var callToActionLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var mainImageView: UIImageView!

  static func nibForAd() -> UINib! {
    return UINib(nibName: "MopubAdCell", bundle: nil)
  }
  
  //MARK: MPNativeAdRendering
  func nativeTitleTextLabel() -> UILabel! {
    return titleLabel
  }

  func nativeMainTextLabel() -> UILabel! {
    return mainTextLabel
  }

  func nativeCallToActionTextLabel() -> UILabel! {
    return callToActionLabel!
  }

  func nativeIconImageView() -> UIImageView! {
    return iconImageView
  }

  func nativeMainImageView() -> UIImageView! {
    return mainImageView
  }

  func nativeVideoView() -> UIView! {
    return UIView()
  }
}
