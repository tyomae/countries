# Сountries search
Countries info App
## General info
Countries search is the application for the iPhone that displays information about all countries in the world from [RestCountries](https://restcountries.eu). If you want to see detailed information about the country you are interested in - just select it.
## Demo
![RPReplay_Final1605627227](https://user-images.githubusercontent.com/50327663/99410575-aed88c00-2903-11eb-89d3-d35b8cff8c1b.gif) __________________________ ![RPReplay_Final1605626953](https://user-images.githubusercontent.com/50327663/99410024-0b877700-2903-11eb-944f-4500fc82d0fe.gif)



## Technologies 
* Xcode 12.2
* Swift 5
* Realm 10.1.4
## Technical detail
The app uses MVVM architecture.  

  
Countries data is retrieved with standart URLRequest; response(REST) is parsed using Decodable protocol. View controllers work with retrieved data using Delegate protocol.  
  
Implemented error handling for no internet or server errors.

Information about country is loaded and saved in database using RealmSwift.
## Features and UI
* Countries searching with UISearchController
* Countries are sorted alphabetically and displayed in UITableView
* Favourites countries are sorted by adding date and displayed in UITableView
* Swipe country left to add/remove it to/from "Favourites"
* Tap on country to see detailed information about country in UITableView
* Tap on button "Star" to add/remove country to/from "Favourites
* Country location is shown using MapKit
* Navigation between screens realized with UITabBarController
* Supported dark theme

