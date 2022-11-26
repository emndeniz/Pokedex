# Pokedex App

This repository contains the Pokedex app that uses [PokeApi](https://pokeapi.co). 

**Sample Video From App**

https://user-images.githubusercontent.com/7477031/200945207-e1d68d1b-33a1-469d-8c4e-fe1887e2a306.mov




## Scenes
This App contains 2 scenes

- Pokémon Species List Scene
- Pokémon Details Scene

### Pokémon Species List Scene
The user is able to see all available Pokémons in this scene.

**Sample Screen Shot**

![IMG_7003](https://user-images.githubusercontent.com/7477031/200943974-6338ea9e-cf44-4e4d-8b7e-b21da6325fe8.PNG)


### Pokémon Details Scene
The user is able to see a Pokémon’s specifications such as;

- Name
- Image
- Type 
- Pokédex no
- Habitat
- Weight
- Height
- Abilities 
- Evolution chain
- Moves

**Sample Screen Shot**

![IMG_7006](https://user-images.githubusercontent.com/7477031/200944873-bfd40079-9b81-43b7-ad52-1b11d1a7697b.PNG)


## Technology Stack

### UI Framework
This application was developed using UIKit. UIKit is the oldest UI development framework designated for iOS app development. It supports all the iOS versions starting with iOS 2.0 ([UIKit Documentation](https://developer.apple.com/documentation/uikit)).

The alternative that I can use to develop this app is SwiftUI. SwiftUI has a declarative UI development approach which is easier to design UI. But SwiftUI has support on devices that have iOS 13 or above. Even though more than [%89 of devices](https://developer.apple.com/support/app-store/) support iOS 13 and above I didn't choose it as the UI framework. Because it has version incompatibilities with the iOS version varieties. 

That is why I proceed with UIKit. 

### Application Architecture

There are a few popular architectural approaches in the mobile world nowadays. For the development of this app, I choose **VIPER**. Because, in my opinion, it is the best architecture for dividing application responsibilities. Each component has straightforward responsibilities.

**Interactor:** Responsible to manage business logic from different entities.

**Presenter:** Responsible to carry related data to the view and manage it.

**View:** Responsible to handle user interactions.

**Wireframe:** Regular VIPER architecture has **routers** but I prefer to have Wireframes to wrap up all scenes with designated parameters. Wireframes also manage routing logic. 

**Entity:** models which are handled by the Interactor. Contains only business logic, but primarily data, not rules.


Also, all of the VIPER components I am using have protocols as Protocol Oriented Programming suggests. Combining these protocols with VIPER allows us to write Unit Tests easily. 

### Networking Framework

Networking in this application is managed by the URLSession framework of Apple. There is no third-party framework I used to manage networking except image content download.

### Third-Party Libraries

There are 3 third-party libraries I used in this app.

**Kingfisher:** [Kingfisher](https://github.com/onevcat/Kingfisher) is a powerful, pure-Swift library for downloading and caching images from the web. It is pretty useful for image downloads.

**Lottie:** [Lottie](https://github.com/airbnb/lottie-ios) is a cross-platform library for iOS, macOS, tvOS, Android, and the Web that natively renders vector-based animations and art in real-time with minimal code. I used 2 Lottie files to beautify the app UI.

**SwiftyBeaver:** [SwiftyBeaver](https://github.com/SwiftyBeaver/SwiftyBeaver) allows us to have colorful, flexible, lightweight logging for Swift. It allows me to have easy-to-read logs. It also allows log storing but I didn't enable it for this app.


## Additionals


This app also has some additional implementations like


- Light & Dark mode support 
- Multiple language support (English & Turkish)
- Custom-designed App Icon
- Network managers to detect a lack of network and warn the user.
- Custom alerts to warn users about any errors.
- Unit tests
