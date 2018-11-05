## BuzzNative iOS MoPub Adapter 연동 가이드
본 문서에서는 iOS 앱에서 MoPub에 BuzzNative를 mediation으로 추가하는 방법을 설명합니다.

### 1. Integrate BuzzNative via Cocoapods
`Podfile`에 `pod 'BuzzNative', '~> 2.0'`을 추가한 후 `pod install`을 실행합니다.

### 2. Download Adapter
`BuzzNative/` 폴더를 다운로드 합니다.

### 3. Add Adapter Files to Your Project
`BuzzNative/` 폴더를 프로젝트에 추가합니다. `BuzzNative/` 폴더 안에는 `BuzzNativeCustomEvent.swift`와 `BuzzNativeAdAdapter.swift` 두 개의 파일이 들어 있습니다.

### 4. Configure BuzzNative Network in MoPub Dashboard
Adapter를 통해 BuzzNative 광고를 받아오려면 BuzzNative의 *Placement ID*가 필요합니다. *Placement ID*를 발급받지 못했다면 담당자에게 문의바랍니다.

1. MoPub Dashboard 상단의 *Networks* 탭으로 이동하여 BuzzNative를 연동하려는 앱을 선택합니다.
2. *New network* 버튼을 클릭한 후 하단의 *Custom SDK network*를 선택합니다.
3. 필요한 정보를 입력하고 *App & ad unit setup* 단계로 이동합니다.
4. BuzzNative 광고를 받아올 지면에 아래 값을 입력합니다.
- Custom Event Class: BuzzNativeCustomEvent
- Custom Event Class Data: {"PLACEMENT":"YOUR_PLACEMENT_ID"}

### 5. Register BuzzNativeCustomEvent to MoPub Ad Renderer
1. 다음과 같이 `supportedCustomEvents`에 `BuzzNativeCustomEvent`를 추가합니다.
```
let settings = MPStaticNativeAdRendererSettings()
settings.renderingViewClass = MopubAdCell.self
settings.viewSizeHandler = { maxWidth in return CGSize(width: maxWidth, height: 180) }

let config = MPStaticNativeAdRenderer.rendererConfiguration(with: settings)
config?.supportedCustomEvents = ["BuzzNativeCustomEvent"]

placer = MPTableViewAdPlacer(tableView: tableView, viewController: self, rendererConfigurations: [config!])
placer.delegate = self;

placer.loadAds(forAdUnitID: YOUR_MOPUB_UNIT_ID)
```

(Optional 2.) 다음과 같이 targeting parameter를 설정할 수 있습니다.
```
BuzzNativeCustomEvent.setTargeting(userProfile: BNUserProfile(birthday: birthday, gender: gender), location: BNLocation(latitude: latitude, longitude: longitude))
```


### 6. Run and Get Ads from BuzzNative
실행하고 BuzzNative의 광고가 정상적으로 불러와지는지 확인합니다. BuzzNative의 로그를 확인하려면 `BuzzNativeCustomEvent.swift` 파일의 `BuzzNative.configure(logging: false)`을 `BuzzNative.configure(logging: true)`로 변경합니다.


