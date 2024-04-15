//
//  WeatherAlamofireService.swift
//  WeatherViewer
//
//  Created by Extremall on 14/04/2024.
//

import Foundation
import Alamofire

// I have implemented both Alamofire and Moya services

final class WeatherAlamofireService: WeatherServiceProtocol {
	func getPoints(latitude: Double, longitude: Double, completion: @escaping (Result<GetPointsResponse, NetworkError>) -> Void) {
		let urlStr = Constants.baseURL + "/points/\(latitude),\(longitude)"
		let url = URL(string: urlStr)!
		getRequest(url: url, completion: completion)
	}
	
	func getForecast(request: GetForecastRequest, completion: @escaping (Result<GetForecastResponse, NetworkError>) -> Void) {
		let urlStr = Constants.baseURL + "/gridpoints/\(request.gridId)/\(request.gridX),\(request.gridY)/forecast"
		let url = URL(string: urlStr)!
		getRequest(url: url, completion: completion)
	}
	
	func getRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
		AF.request(url, method: .get).responseDecodable(of: T.self) { result in
			switch result.result {
				case .success(let data):
					if let response = result.response, (200 ... 299).contains(response.statusCode) {
						completion(.success(data))
					} else {
						print("Network - Alamofire - badStatusError: \(result.response?.statusCode ?? -1)")
						completion(.failure(NetworkError.badStatusCode))
					}
				case .failure(let error):
					print("Network - Alamofire - failure: \(error)")
					completion(.failure(NetworkError.error(error: error)))
			}
		}
	}
}
