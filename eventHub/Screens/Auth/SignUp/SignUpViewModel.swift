//
//  SignUpViewModel.swift
//  eventHub
//
//  Created by MacBook on 12/23/25.
//


import SwiftUI
import Combine

final class SignUpViewModel: ObservableObject {
    
    private let authService: AuthService
    
    // mock
    
    init(authService: AuthService = MockAuthService()) {
        self.authService = authService
    }
    
    // MARK: - Inputs
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmedPassword = ""
    @Published var phoneNumber = ""
    @Published var departments = ["Engineering","Marketing","Sales","HR","Design"]
    @Published var selectedDepartment: String?
    @Published var departmentError: String?
    
    
    // OTP
    @Published var otpFields = Array(repeating: "", count: 6)
    
    // MARK: - ValidateDepartment
    func validateDepartment() {
        if selectedDepartment == nil {
            departmentError = "Please select a department"
        } else {
            departmentError = nil
        }
    }
    
    
    // MARK: - Errors
    @Published var emailError: String?
    @Published var phoneError: String?
    @Published var otpError: String?
    @Published var passwordError: String?
    @Published var confirmPasswordError: String?
    
    
    @Published var otpSent = false
    
    // MARK: - Password
    func validatePassword() {
        let passwordRegex =
        "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        if password.isEmpty {
            passwordError = "Password cannot be empty"
        } else if !predicate.evaluate(with: password) {
            passwordError = "Password must be at least 8 characters with uppercase, lowercase, and number"
        } else {
            passwordError = nil
        }
    }
    
    
    // MARK: - ConfirmPassword
    func validateConfirmPassword() {
        if confirmedPassword.isEmpty {
            confirmPasswordError = "Confirm your password"
        } else if confirmedPassword != password {
            confirmPasswordError = "Passwords do not match"
        } else {
            confirmPasswordError = nil
        }
    }
    
    
    // MARK: - Email
    func validateEmail() {
        let emailRegEx =
        "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if email.isEmpty {
            emailError = "Email cannot be empty"
        } else if !predicate.evaluate(with: email) {
            emailError = "Invalid email format"
        } else {
            emailError = nil
        }
    }
    
    // MARK: - Phone
    func updatePhone(_ value: String) {
        
        phoneNumber = value.filter { $0.isNumber }
        
        if phoneNumber.count < 10 {
            phoneError = "Phone number is too short"
        } else {
            phoneError = nil
        }
    }
    
    // MARK: - OTP
    func updateOTP(index: Int, value: String) {
        otpFields[index] = String(value.filter { $0.isNumber }.prefix(1))
        
        let otp = otpFields.joined()
        
        if otp.count < 6 {
            otpError = "OTP must be 6 digits"
        } else {
            otpError = nil
        }
    }
    
    func sendOTP() {
        guard phoneError == nil else {
            otpError = "Enter valid phone number first"
            return
        }
        
        otpSent = true
        print("OTP sent to \(phoneNumber)")
    }
    
    
    var isFormValid: Bool {
        return !firstName.isEmpty &&
        !lastName.isEmpty &&
        emailError == nil &&
        !email.isEmpty &&
        phoneError == nil &&
        otpError == nil &&
        otpFields.joined().count == 6 &&
        passwordError == nil &&
        confirmPasswordError == nil &&
        selectedDepartment != nil
    }
    
    
    // MARK: - Create Account
    func createAccount(completion: @escaping (Bool) -> Void) {
        
        validateEmail()
        validatePassword()
        validateConfirmPassword()
        validateDepartment()
        
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              emailError == nil,
              phoneError == nil,
              otpSent,
              otpFields.joined().count == 6,
              otpError == nil,
              passwordError == nil,
              confirmPasswordError == nil,
              selectedDepartment != nil else {
            completion(false)
            return
        }
        
        let request = RegisterRequest(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phoneNumber,
            otp: otpFields.joined(),
            password: password,
            department: selectedDepartment!
        )
        
        authService.register(request: request) { result in
            switch result {
            case .success:
                print("ACCOUNT CREATED")
                completion(true)
                
            case .failure(let error):
                print("ERROR:", error)
                completion(false)
            }
        }
    }
}
