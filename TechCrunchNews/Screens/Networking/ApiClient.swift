//
//  ApiClient.swift
//  TechCrunchNews
//
//  Created by pankaj bandewar on 02/08/22.
//


import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class APIClient: NSObject {
    static func apiRequest
    (url: String, method: HTTPMethod, headers: HTTPHeaders? = nil, parameter: Parameters?, completion: @escaping (_ status: Bool, _ response: JSON, _ message: String, _ data: Data) -> Void) {
        isNetworkAvailable { status, message in
            if status {
                guard let url = URL(string: url) else { return }
                let manager = Alamofire.Session.default
                manager.request(url, method: method, parameters: method == .get ? nil : parameter, encoding: JSONEncoding.default, headers: headers).responseData { response in
                    let data = response.data
                    responseData(response: response, completion: { status, response, message in
                        print("RESPONSE: \(response)")
                        completion(status, response, message, data ?? Data())
                    })
                }
            } else {
                completion(false, "", message, Data())
            }
        }
    }
}

// MARK: - CHECK NETOWRK AVAILABLITITY

func isNetworkAvailable(completionHandler: @escaping (_ success: Bool, _ message: String) -> Void) {
    let reachability = NetworkReachabilityManager()
    reachability?.startListening { status in
        switch status {
        case .notReachable:
            completionHandler(false, "The network is not reachable")
        case .unknown:
            completionHandler(false, "It is unknown whether the network is reachable")
        case .reachable(.cellular):
            completionHandler(true, "The network is reachable over the WWAN connection")
        case .reachable(.ethernetOrWiFi):
            completionHandler(true, "wifi")
            print("The network is reachable over the WiFi connection")
        }
    }
}

func responseData(response: AFDataResponse<Data>, completion: @escaping (_ status: Bool, _ response: JSON, _ message: String) -> Void) {
    let statusCode = response.response?.statusCode
    if statusCode == 200 {
        switch response.result {
        case .success:
            guard let data = response.data else { return }
            let json = try? JSON(data: data)
            completion(true, json!, "")
        case .failure:
            switch response.error!._code {
            case NSURLErrorTimedOut:
                completion(false, "Failure", "Network error")
            case NSURLErrorNotConnectedToInternet:
                completion(false, "Failure", "Check your internet connection")
            default:
                completion(false, "Faild", "error")
            }
        }
    } else {
        completion(false, "Failure", (response.error?.localizedDescription) ?? "")
    }
}
