## BARO iOS MoPub Adapter 연동 가이드
본 문서에서는 iOS 앱에서 MoPub에 BARO를 mediation으로 추가하는 방법을 설명합니다.

### 1. Integrate BARO via Cocoapods
`Podfile`에 `pod 'BARO', '~> 2.2.0'`을 추가한 후 `pod install`을 실행합니다.
> `[!] Unable to find a specification for BARO (~> 2.2.0)` 에러가 발생하는 경우 `pod repo update`를 실행 후 다시 `pod install`을 실행합니다. 

### 2. Add Adapter Files to Your Project
`BARO/` 폴더를 다운로드 한 뒤 프로젝트에 추가합니다. `BARO/` 폴더 안에는 `BAROCustomEvent.swift`와 `BAROAdAdapter.swift` 두 개의 파일이 들어 있습니다.

### 3. Configure BARO Network in MoPub Dashboard
Adapter를 통해 BARO 광고를 받아오려면 BARO의 *Placement ID*가 필요합니다. *Placement ID*를 발급받지 못했다면 담당자에게 문의바랍니다.

1. MoPub Dashboard 상단의 *Networks* 탭으로 이동하여 BARO를 연동하려는 앱을 선택합니다.
2. *New network* 버튼을 클릭한 후 하단의 *Custom SDK network*를 선택합니다.
3. 필요한 정보를 입력하고 *App & ad unit setup* 단계로 이동합니다.
4. BARO 광고를 받아올 지면에 아래 값을 입력합니다.
- Custom Event Class: BAROCustomEvent
- Custom Event Class Data: {"unitID":"YOUR_PLACEMENT_ID"}

### 4. Register BAROCustomEvent to MoPub Ad Renderer
1. 다음과 같이 `supportedCustomEvents`에 `BAROCustomEvent`를 추가합니다.
```swift
let settings = MPStaticNativeAdRendererSettings()
settings.renderingViewClass = MopubAdCell.self
settings.viewSizeHandler = { maxWidth in return CGSize(width: maxWidth, height: 180) }

let config = MPStaticNativeAdRenderer.rendererConfiguration(with: settings)
config?.supportedCustomEvents = ["BAROCustomEvent"]

placer = MPTableViewAdPlacer(tableView: tableView, viewController: self, rendererConfigurations: [config!])
placer.delegate = self;

placer.loadAds(forAdUnitID: YOUR_MOPUB_UNIT_ID)
```

(Optional 2.) 다음과 같이 targeting parameter를 설정할 수 있습니다.
```swift
BAROCustomEvent.setTargeting(userProfile: BNUserProfile(birthday: birthday, gender: gender), location: BNLocation(latitude: latitude, longitude: longitude))
```


### 5. Run and Get Ads from BARO
실행하고 BARO의 광고가 정상적으로 불러와지는지 확인합니다. BARO의 로그를 확인하려면 `BAROCustomEvent.swift` 파일의 `BARO.configure(logging: false)`을 `BARO.configure(logging: true)`로 변경합니다.


