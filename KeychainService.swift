//
//  KeychainService.swift
//  
//
//  Created by Abhay Shankar on 24/10/18.
//  Copyright © 2018 Self. All rights reserved.
//

import UIKit
import Security
// Arguments for the keychain queries
let kSecClassValue = NSString(format: kSecClass)
let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let kSecAttrServiceValue = NSString(format: kSecAttrService)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

class KeychainService: NSObject {

    /// Update previously saved Password
    ///
    /// - Parameters:
    ///   - service: Service name
    ///   - account: Account name
    ///   - data: Data to be saved in keychain
    class func updatePassword(service: String, account:String, data: String) {
        if let dataFromString: Data = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            let updatekeychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [ service, account, dataFromString], forKeys: [ kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
            let query: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue])
            // Instantiate a new default keychain query

            let status = SecItemUpdate(query as CFDictionary, updatekeychainQuery as CFDictionary)
            
            if (status != errSecSuccess) {
                if #available(iOS 11.3, *) {
                    if let err = SecCopyErrorMessageString(status, nil) {
                        print("Read failed: \(err)")
                    }
                } else {
                    // Fallback on earlier versions
                    print("Read failed")
                }
            }
        }
    }
    
    
    /// Delete saved password from Keychain
    ///
    /// - Parameters:
    ///   - service: Service name
    ///   - account: Account name
    class func removePassword(service: String, account:String) {

        // Instantiate a new default keychain query
        let query: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue])

        
        // Delete any existing items
        let status = SecItemDelete(query as CFDictionary)
        if (status != errSecSuccess) {
            if #available(iOS 11.3, *) {
                if let err = SecCopyErrorMessageString(status, nil) {
                    print("Remove failed: \(err)")
                }
            } else {
                // Fallback on earlier versions
                print("Remove failed")
            }
        }
        
    }
    
    
    /// Save a fresh password in Keychain
    ///
    /// - Parameters:
    ///   - service: Service name
    ///   - account: Account name
    ///   - data: Data to be saved in keychain
    class func savePassword(service: String, account:String, data: String) {
        if let dataFromString = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            // Instantiate a new default keychain query
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
            
            // Add the new keychain item
            let status = SecItemAdd(keychainQuery as CFDictionary, nil)
            
            if (status != errSecSuccess) {    // Always check the status
                if #available(iOS 11.3, *) {
                    if let err = SecCopyErrorMessageString(status, nil) {
                        print("Write failed: \(err)")
                    }
                } else {
                    // Fallback on earlier versions
                    print("Write failed")
                }
            }
        }
    }
    
    /// Retrive password from keychain
    ///
    /// - Parameters:
    ///   - service: service name
    ///   - account: account name
    /// - Returns: Optional String
    class func loadPassword(service: String, account:String) -> String? {
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String?
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
}
