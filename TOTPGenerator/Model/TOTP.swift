//
//  TOTP.swift
//  totp_generator
//
//  Created by Dong Liang on 2/26/21.
//

import Foundation
import SwiftBase32
import CryptoSwift

class TOTP: NSObject {
    
    var secret: String // base32 encoded
    
    init(secret: String) {
        self.secret = secret
        
        super.init()
    }
    
    // 6 digits output code
    func now() -> String {
        let code = self.now(digits: 6)
        
        if code == -1 {
            return "N/A"
        }
        
        var numberOfDigits = 0
        
        var tmp = code;
        while tmp != 0 {
            tmp = tmp / 10
            numberOfDigits += 1
        }
        
        var retString = String(code)
        if numberOfDigits != 6 {
            for _ in 1...(6-numberOfDigits) {
                retString = "0" + retString
            }
        }
        
        return retString
    }
    
    func now(digits: UInt) -> Int {
        
        let timeInterval = Int64(Date().timeIntervalSince1970)
        let counter = timeInterval/30
        
        let counter_8_bytes = withUnsafeBytes(of: counter.bigEndian, Array.init)
        
        var secret_uppercased = secret.uppercased()
        
        let padding = secret_uppercased.count % 8
        if (padding != 0) {
            for _ in 1...padding {
                secret_uppercased.append("=")
            }
        }
        
        let decoded_secret = base32Decode(secret_uppercased)
        
        if decoded_secret == nil { // invalid base32 encoded string found
            return -1
        }
        
        let hmac = HMAC(key: decoded_secret!, variant: HMAC.Variant.sha1)
        let digest = try! hmac.authenticate(counter_8_bytes)
        
        let bit_truncated = dynamicTruncate(hmacDigest: digest)
        
        return bit_truncated % (Int(pow(10.0, Double(digits))))
    }
    
    func dynamicTruncate(hmacDigest: Array<UInt8>) -> Int {
        
        let hmacDigestInt: Array<Int> = hmacDigest.map({ (int8) -> Int in
            return Int(int8)
        })
        
        let offset = hmacDigestInt[19] & 0x0f
        
        return (hmacDigestInt[offset] & 0x7f) << 24 | ((hmacDigestInt[offset+1] & 0xff) << 16)  | ((hmacDigestInt[offset+2] & 0xff) << 8) | ((hmacDigestInt[offset+3] & 0xff))
    }
}
