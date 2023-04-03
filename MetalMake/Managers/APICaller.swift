//
//  ApiCaller.swift
//  MetalMake
//
//  Created by 謝佳勳 on 2023/4/4.
//

import Foundation


struct Constants {
    static let API_KEY = "1c4d27acca1065ebd79cb2126bf16f5c"
    static let baseURl="https://api.themoviedb.org"
    
}

class APICaller {
    static let shared = APICaller()
    
        
    func getTrendingMovie(completion: @escaping(String) -> Void){
    
        guard let url = URL(string: "\(Constants.baseURl)/3/trending/all/day?api_key=\(Constants.API_KEY)")else {return}
        
//        let task = URLSession.shared.dataTask(with:URLRequest(url: url)){
//            data,_
//        }
        
    }
}
