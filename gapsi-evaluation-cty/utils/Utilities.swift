//
//  Utilities.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 5/08/23.
//

import Foundation
import UIKit

class Utilities {
    
    public static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    public static func downloadImage(from url: URL, imageView: UIImageView) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { () in
                imageView.image = UIImage(data: data)
            }
        }
    }
    
    public static func sendGetRequest<T>(protocolo: RequestProtocol, url: URL, type: T.Type, ibmKey: String) -> Void where T : Decodable
    {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if( ibmKey != "" ) {
            request.setValue("\(ibmKey)", forHTTPHeaderField: "X-IBM-Client-Id")
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                protocolo.error(msg: error?.localizedDescription ?? "No data")
                return
            }
            
            let stringResponse = String(decoding: data, as: UTF8.self)
            print(stringResponse)
            do {
                let jsonDecoder = JSONDecoder()
                let objeto = try jsonDecoder.decode(type, from: data)
                protocolo.sucess(data: objeto)
            } catch {
                print(String(describing: error))
                protocolo.error(msg: String(describing: error))
            }
            
        }
        task.resume()
        
    }

    static func getSuggested() -> SuggestedDTO? {
        let preferences = UserDefaults.standard
        let currentLevelKey = "getSuggested"
    
        do{
            if let json_user = preferences.string(forKey: currentLevelKey) {
                let jsonData = Data(json_user.utf8)
                
                let jsonDecoder = JSONDecoder()
                let sugg = try jsonDecoder.decode(SuggestedDTO.self, from: jsonData)
                
                return sugg
            } else {
                print("Unexpected error: Datos de sugerencias no encontrado")
                return nil
            }
        } catch {
            print("Unexpected error: \(error).")
            return nil
        }
    }
    
    static func setSuggested(suggesteds: SuggestedDTO) -> Void {
        let preferences = UserDefaults.standard
        let jsonEncoder = JSONEncoder()
        
        do{
            let jsonData = try jsonEncoder.encode(suggesteds)
            let json_user = String(data: jsonData, encoding: String.Encoding.utf8)
            preferences.set(json_user, forKey: "getSuggested")

            //  Save to disk
            let didSave = preferences.synchronize()

            if !didSave {
                print("Unexpected error: Datos de sugerencias no encontrado")
            }
        }
        catch {
            print("Unexpected error: \(error).")
        }
    }


}
