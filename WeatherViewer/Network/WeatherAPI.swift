//
//  WeatherAPI.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation
import Moya

enum WeatherAPI {
	case getPoints(latitude: Double, longitude: Double)
	case getForecast(request: GetForecastRequest)
}

extension WeatherAPI: TargetType {
	var baseURL: URL {
		URL(string: Constants.baseURL)!
	}
	
	var path: String {
		switch self {
			case .getPoints(let latitude, let longitude):
				return "/points/\(latitude),\(longitude)"
			case .getForecast(let request):
				return "/gridpoints/\(request.gridId)/\(request.gridX),\(request.gridY)/forecast"
		}
	}
	
	var method: Moya.Method {
		switch self {
			case .getPoints, .getForecast:
				return .get
		}
	}
	
	var task: Moya.Task {
		switch self {
			case .getPoints, .getForecast:
				return .requestPlain
		}
	}
	
	var headers: [String : String]? {
		let headers: [String : String] = [:]
		return headers
	}
}
