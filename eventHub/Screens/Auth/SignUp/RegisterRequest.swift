//
//  RegisterRequest.swift
//  eventHub
//
//  Created by MacBook on 12/23/25.
//

import Foundation

struct RegisterRequest: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let password: String
    let passwordConfirmation: String
    let department: String
}

struct SendOtpRequest: Encodable {
    let phoneNumber: String
}

struct VerifyOtpRequest: Encodable {
    let phoneNumber: String
    let otp: String
}

struct BasicMessageResponse: Decodable {
    let message: String?
}


struct SendOtpBody: Encodable {
    let phoneNumber: String
}

struct VerifyOtpBody: Encodable {
    let phoneNumber: String
    let otp: String
}

struct RegisterBody: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let password: String
    let passwordConfirmation: String
    let department: String
}
