//
//	CryptoDetailModel.swift
//  MuSchool
//
//  Created by Evince Development on 20/09/21.
//

import Foundation 
import SwiftyJSON


class CryptoDetailModel : NSObject, NSCoding,ObservableObject{

	var iconUrl : String!
	var maxSupply : Int!
	var name : String!
	var nameFull : String!
	var symbol : String!
    var currentRate : Double!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		iconUrl = json["icon_url"].stringValue
		maxSupply = json["max_supply"].intValue
		name = json["name"].stringValue
		nameFull = json["name_full"].stringValue
		symbol = json["symbol"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if iconUrl != nil{
			dictionary["icon_url"] = iconUrl
		}
		if maxSupply != nil{
			dictionary["max_supply"] = maxSupply
		}
		if name != nil{
			dictionary["name"] = name
		}
		if nameFull != nil{
			dictionary["name_full"] = nameFull
		}
		if symbol != nil{
			dictionary["symbol"] = symbol
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         iconUrl = aDecoder.decodeObject(forKey: "icon_url") as? String
         maxSupply = aDecoder.decodeObject(forKey: "max_supply") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         nameFull = aDecoder.decodeObject(forKey: "name_full") as? String
         symbol = aDecoder.decodeObject(forKey: "symbol") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if iconUrl != nil{
			aCoder.encode(iconUrl, forKey: "icon_url")
		}
		if maxSupply != nil{
			aCoder.encode(maxSupply, forKey: "max_supply")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if nameFull != nil{
			aCoder.encode(nameFull, forKey: "name_full")
		}
		if symbol != nil{
			aCoder.encode(symbol, forKey: "symbol")
		}
	}

}
