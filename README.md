# FHAlert

`FHAlert` is a Swift package for displaying customizable alerts in iOS applications. It offers a simple and elegant way to show alerts with an icon, title, and subtitle. This package is suitable for projects that require a consistent and visually appealing way to present information to users.

## Features
- Customizable alert types including success, failure, and info.
- Supports iOS UIKit framework.
- Easy integration into any iOS project.

## Components
1. `TopAlertTypeProtocol`: A protocol that defines the properties for different types of alerts.
2. `TopAlertType`: An enum that implements `TopAlertTypeProtocol` with predefined alert types such as success, failure, and info.
3. `TopAlertView`: A custom UIView class for displaying alerts. It supports a blurred background effect, icon, title, and subtitle.

## Installation
To integrate `TopAlertView` into your Swift project using Swift Package Manager, add the following as a dependency in your `Package.swift`:

```swift
.package(url: "https://github.com/BassamHilloFoothill/FHAlert.git", from: "1.0.0")
```

## Usage
Here's a quick example to show how you can use `TopAlertView` in your project:

```swift
import UIKit
import TopAlertView

TopAlertView.show(
    title: "Success",
    subTitle: "Your operation was successful.",
    type: TopAlertType.success,
    hasTopPadding: false,
    completion: nil
)
```

## Customization
`TopAlertView` comes with a default set of alert types defined in the `TopAlertType` enum, which includes `.success`, `.failure`, and `.info`. If you need a custom alert type, you can implement the `TopAlertTypeProtocol` and define your custom types. The `show` method of `TopAlertView` accepts any type that conforms to `TopAlertTypeProtocol`, allowing for extensive customization.

## Contributing
Contributions are welcome. Please feel free to fork the repository and submit pull requests.

## License
`FHAlert` is released under the MIT license. See [LICENSE](https://github.com/BassamHilloFoothill/FHAlert/blob/master/LICENSE.txt) for details.
