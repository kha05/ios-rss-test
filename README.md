# RssToilets

This an iOS technical test for RATP Smart System. The idea is to build a small app to fetch a list of public toilets to the [RATP API](https://data.ratp.fr/api/records/1.0/search/?dataset=sanisettesparis2011&start=0&rows=1000) 

# Architecture

Following the SOLID principles, I designed my application with an architecture which divides into separate layers as follow:

```
├── RssToilets
│   ├── RssToilets
│   │   ├── Application
│   │   ├── Common
│   │   ├── Data
│   │   │   ├── Network
│   │   │   ├── Repositories
│   │   │   └── Utilities
│   │   ├── Domain
│   │   │   ├── Entities
│   │   │   ├── Interfaces
│   │   │   └── UseCases
│   │   ├── Presentation
│   │   │   │   ├── Coordinators
│   │   │   │   ├── Presenter
│   │   │   │   ├── ViewModel
│   │   │   │   └── Views
│   │   │   └── Utilities
│   │   └── Ressources
```

This architecture allows the different layers to communicate by this way (View -> Presenter <-> Domain <-> Data) and facilitate the testing part. 

I have also used the Coordinator pattern to extract the navigation responsability to another layer.

> Improvement:
>
>- Implementing a map with `MapKit` to display the toilets on a map 

# UI

UIKit has been choosen to build the UI programatically over the storyboards because it is easier to handle git conflicts while working within a team. I could have also used SwiftUI to use the latest API from Apple

> Improvement:
>
>- UI is very minimalist for this test so it could be more UI friendly by creating a better design. 
>- An empty state could be added. 
>- A loader while fetching the data.
>- A better filter option in the table view to display the PRM toilets.

# Data

I didn't use any library for this test, Apple provides the `URLSession` to make the API call as a consequence I tried to build a scalable network layer but of course for real implementation we could use network library to save some time and not reinvent the wheel. 
The DTO objects has been generated with https://app.quicktype.io/ to save some time.


> Improvement:
>
>- Adding a local storage such as CoreData, Realm or even using the User default to have an offline mode but my architecture is sliced enough to plug a local source to handle this responsability.

# Tests

I only wrote a couple of tests with `XCTest` on the Presenter class to demonstrate some UI rules but we could add more tests on the Use cases and the Repositories. I created a couple of mocks for my tests.

> Improvement:
>
>- We can also add other kind of tests such as Snapshot Tests or UI tests.
