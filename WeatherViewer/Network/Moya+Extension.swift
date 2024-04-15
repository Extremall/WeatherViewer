//
//  Moya+Extension.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation
import Moya

enum NetworkError: Error {
	case badStatusCode
	case mappingError
	case error(error: Error)
}

extension MoyaProviderType {
	@discardableResult
	func makeRequest<D: Decodable>(_ target: Target, callbackQueue: DispatchQueue? = .none, tryToLogin: Bool = true, progress: Moya.ProgressBlock? = .none, completion: @escaping (Result<D, NetworkError>) -> Void) -> Cancellable {
		
		request(target, callbackQueue: callbackQueue, progress: progress) { result in
			switch result {
				case .success(let response):
					if (200 ... 299).contains(response.statusCode) {
						do {
							let res = try response.map(D.self)
							completion(.success(res))
						} catch {
							print("Network - Moya - Mapping error: \(error)")
							completion(.failure(NetworkError.mappingError))
						}
					} else {
						print("Network - Moya - badStatusError: \(response.statusCode)")
						completion(.failure(NetworkError.badStatusCode))
					}
				case .failure(let error):
					print("Network - Moya - failure: \(error)")
					completion(.failure(NetworkError.error(error: error)))
			}
		}
	}
}
