# appetiser-demo

This demo app called 'Apptuens' shows list of tracks from iTunes API which are categorized as 'Song' and 'Movie'. Upon clicking a track from a list, a detailed view of that track is shown.

# Architecture

This app implements Model-View-Controller ( MVC) as design architecture to support modularity, code reusability, maintainablity, and avoid code redundancy (DRY).

MVC pattern is common in iOS development. Most developers understand and utilizes MVC. Implementing the standard MVC is one way to make sure transition and collaboration between developers is smooth and worry-free. Aside from this, MVC is also good for developing applications in a time-restricted development.

MVC promotes separation of concern for Models, Views, and Controllers which is often mixed up in large projects. With this separation, maintaining and scaling projects is easier. Hence, development is much more efficient.

# Pods

1. https://github.com/SwiftGen/SwiftGen
2. https://github.com/Moya/Moya
3. https://github.com/mxcl/PromiseKit
4. https://github.com/vhesener/Closures
5. https://github.com/AliSoftware/Reusable
6. https://github.com/onevcat/Kingfisher
7. https://github.com/SnapKit/SnapKit
8. https://github.com/SwiftyJSON/SwiftyJSON

# Storage

The app utilizes CoreData to create a simple local storage for saving favorite tracks. 

