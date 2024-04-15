//
//  WeatherService.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation
import Moya

// I have implemented both Alamofire and Moya services

protocol WeatherServiceProtocol: AnyObject {
	func getPoints(latitude: Double, 
				   longitude: Double,
				   completion: @escaping (Result<GetPointsResponse, NetworkError>) -> Void)
	func getForecast(request: GetForecastRequest,
					 completion: @escaping (Result<GetForecastResponse, NetworkError>) -> Void)
}

final class WeatherService: WeatherServiceProtocol {
	private lazy var provider: MoyaProvider = {
		let provider = MoyaProvider<WeatherAPI>()
		return provider
	}()
	
	func getPoints(latitude: Double,
				   longitude: Double,
				   completion: @escaping (Result<GetPointsResponse, NetworkError>) -> Void) {
		provider.makeRequest(.getPoints(latitude: latitude, longitude: longitude),
							 completion: completion)
	}
	
	func getForecast(request: GetForecastRequest,
					 completion: @escaping (Result<GetForecastResponse, NetworkError>) -> Void) {
		provider.makeRequest(.getForecast(request: request), completion: completion)
	}
}
