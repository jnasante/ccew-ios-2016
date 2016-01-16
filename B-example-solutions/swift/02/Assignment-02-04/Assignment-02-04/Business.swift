//
//  Business.swift
//  
//
//  Created by Philip Dow on 9/1/15.
//
//

import Foundation

// Note that a class prefix such as CC is not necessary
// Swift classes are namespaced to the module which contains them, 
// in this case our application

// The use of question marks after the type indicates that it is an option
// An option is another type which is the original type or nil. We use it
// to indicate that the variables may have no value set

class Business: NSObject {
    
    var name: String?
    var type: String?
    var phone: String?
    
    var street: String?
    var city: String?
    var state: String?
    var zipcode: String?
    
    // This is how we create a read-only, computed property
    
    var address: String {
        
        // The if let statement safely "unwraps" the optionals and the only executes
        // the following code if they all had values
        
        if let mStreet = street, mCity = city, mState = state, mZipcode = zipcode {
            return String(format: "%@\n%@, %@ %@", mStreet, mCity, mState, mZipcode)
        } else {
            return ""
        }
    }

}
