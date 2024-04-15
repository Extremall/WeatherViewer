You don't need to do anything special to launch the app. Just open in XCode and launch. All dependencies are in Swift Packages.

I have implemented 2 different services for API, they do the same. The first is based on Moya (WeatherService), I like this framework. The second one is based on Alamofire (WeatherAlamofireService). They both implement the same interface (WeatherServiceProtocol), so it doesn't matter wich one will be used.

I tried to implement adding locations using GooglePlaces, but my old API Key is invalid, so I started, but didn't finish this functionality. But it would be very easy, just to get coordinated from a place.
