# Automating Feature Toggles Integration

## The problem

Adding a new feature toggle is a manual process, it usually requires to complete some repetitive steps and adding some boilerplate code.

It also can be error prone, since the mechanism to add a new one, it may be just copying another feature toggle implementation without having a deep thinking.

## Solution

The idea is to define all feature toggles in one file, it can be a YAML, a JSON or PLIST. That list should contain information about the name, the data type, some fallback value and a description.

Then we can use Codegen to convert that input file to sourcecode by using a Stencil template.

## Implementation Example

As an example of this, we are going to use Firebase Remote Configuration (This can be applied to any feature toggles provider) to tweak some aspects of an app called Word of the Day. 

The app shows a randon word when you hit Start button.

<img src="https://user-images.githubusercontent.com/569085/210406116-0e3d4a1c-bd4f-4d47-a5f6-28796b81953d.png" alt="WOD" width="300"/>

The app is using these feature toggles:

* `mainColor` color used to set the background color.
* `accentColor` color used to set texts color.
* `title` main title, if it's not set, it's not presented.
* `words` list of possible words to show.

In a real world application, you will have much more feature toggles.

## Feature Toggles Abstraction

Before dive deep into the Firebase Remote Configuration example, we will describe briefly the abstraction that we are using on top of the Feature Toggles provider, so it's easier in the future to replace that one with a different one.

<img width="700" alt="Feature-toggles-abstraction" src="https://user-images.githubusercontent.com/569085/210406188-fe2f4cfb-3b95-4ccf-8b56-817614552963.png">

* `FeatureToggle<T>` It's a generic struct that contains the assoicated key name and a fallback value.
* `FeatureToggleProvider` It's a protocol that contains two methods, `fetch(_:)` that will fetch the Feature Toggles from the remote location, and `value<T>(_:) -> T` that will return a value assoicated to the Feature Toggle or fallback to the default value.
* `FirebaseRemoteConfigurationProvider` It's a concrete implementation of `FeatureToggleProvider`.

If we want to add a new Feature Toggle to this abstraction, we have to extend `FeatureToggle<T>` providing a static property like this:

```swift
public extension FeatureToggle where T == String {
    /// Text presented as main title.
    static let title: FeatureToggle = .init(key: "title", fallback: "Word of the day!")
}
```

And then fetch remote Feature Toggles and consume the value:

```swift
let provider: FeatureToggleProvider = FirebaseConfigurationProvider()

// This refreshes Feature Toggles for next session.
provider.fetch()

// Returns title Feature Toggle value of fallbacks to default value.
let value = provider.value(.title)
```

## Firebase Remote Configuration

From Firebase Remote Configuration console we can download a JSON file with the Feature Toggles and use that as an input for codegen. To do that you have to select the option __Download current config file__.

<img width="900" alt="Firebase-remote-configuration-console" src="https://user-images.githubusercontent.com/569085/210406245-e29e5df0-7d54-41c5-aa0e-5ee6bdf09fcb.png">

This is how the JSON looks like:

```json
{
  "parameters": {
    "words": {
      "defaultValue": {
        "value": "{\"words\": [\"Car\", \"Holiday\", \"Rain\", \"Elephant\"]}"
      },
      "description": "Possible words to be presented.",
      "valueType": "JSON"
    },
    "title": {
      "defaultValue": {
        "value": "Word of the day!"
      },
      "description": "Text presented as main title.",
      "valueType": "STRING"
    },
    "mainColor": {
      "defaultValue": {
        "value": "685634"
      },
      "description": "Current main color.",
      "valueType": "STRING"
    },
    "accentColor": {
      "defaultValue": {
        "value": "FFFFFF"
      },
      "description": "Current accent color.",
      "valueType": "STRING"
    }
  }
}
```

Then we have to build a Stencil template, that uses that JSON as input and generates some code thet represenst the Feature Toggles. You can find [here](WordOfTheDay/FeatureToggles/FirebaseConfiguration/firebaseConfiguration.stencil) that Stencil template.

Finally, run [generate.sh](WordOfTheDay/FeatureToggles/generate.sh), that file contains:

```shellscript
script_path=$(dirname "$0")
codegen -i ${script_path}/FirebaseConfiguration/remoteConfig.json -t ${script_path}/FirebaseConfiguration/firebaseConfiguration.stencil -o ${script_path}/FeatureToggles.generated.swift --override
```

For the Feature Toggles defined in the JSON, it will generate something like this:

```swift
import Foundation

public typealias JSON = [String: Any]

public extension FeatureToggle where T == String {
    /// Current accent color.
    static let accentColor: FeatureToggle = .init(key: "accentColor", fallback: "FFFFFF")

    /// Current main color.
    static let mainColor: FeatureToggle = .init(key: "mainColor", fallback: "685634")

    /// Text presented as main title.
    static let title: FeatureToggle = .init(key: "title", fallback: "Word of the day!")
}

public extension FeatureToggle where T == JSON {
    /// Possible words to be presented.
    static let words: FeatureToggle = .init(key: "words", fallback: ["words": ["Car", "Holiday", "Rain", "Elephant"]])
}
```

So everytime that a new Feature Toggle is added, you have to download a new version of the JSON file and run `generate.sh`.





