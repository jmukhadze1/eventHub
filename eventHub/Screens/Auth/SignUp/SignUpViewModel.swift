//
//  SignUpViewModel.swift
//  eventHub
//
//  Created by MacBook on 12/23/25.
//


import SwiftUI
import Combine

@MainActor
final class SignUpViewModel: ObservableObject {

    // MARK: - Inputs
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmedPassword = ""
    @Published var phoneNumber = ""
    @Published var departments = ["HR","IT","Marketing","Sales","Finance", "Operations", "Other"]
    @Published var selectedDepartment: String?
    @Published var departmentError: String?

    // OTP
    @Published var otpFields = Array(repeating: "", count: 6)
    @Published var otpSent = false

    // MARK: - Errors
    @Published var emailError: String?
    @Published var phoneError: String?
    @Published var otpError: String?
    @Published var passwordError: String?
    @Published var confirmPasswordError: String?

    // MARK: - Validation helpers (იგივე რაც გქონდა)
    func validateDepartment() {
        if selectedDepartment == nil {
            departmentError = "Please select a department"
        } else {
            departmentError = nil
        }
    }

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

    func validateConfirmPassword() {
        if confirmedPassword.isEmpty {
            confirmPasswordError = "Confirm your password"
        } else if confirmedPassword != password {
            confirmPasswordError = "Passwords do not match"
        } else {
            confirmPasswordError = nil
        }
    }

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

    func updatePhone(_ value: String) {
        phoneNumber = value.filter { $0.isNumber }

        if phoneNumber.count != 9 {
            phoneError = "Phone number must be 9 digits (e.g. 222444111)"
        } else {
            phoneError = nil
        }
    }


    func updateOTP(index: Int, value: String) {
        otpFields[index] = String(value.filter { $0.isNumber }.prefix(1))

        let otp = otpFields.joined()

        if otp.count < 6 {
            otpError = "OTP must be 6 digits"
        } else {
            otpError = nil
        }
    }

    // MARK: - Send OTP (real API)

    func sendOTP() {
        guard phoneError == nil, !phoneNumber.isEmpty else {
            otpError = "Enter valid phone number first"
            return
        }

        otpError = nil

        Task {
            do {
                let body = SendOtpBody(phoneNumber: phoneNumber)
                try await NetworkClient.shared.postNoResponse(
                    "auth/send-otp",
                    body: body,
                    authorized: false
                )

                otpSent = true
                print("OTP sent to \(phoneNumber)")

            } catch {
                print("send-otp error:", error)
                otpError = "Failed to send OTP. Please try again."
            }
        }
    }

    // MARK: - Form valid

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

    // MARK: - Create Account (verify-otp -> register)

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
              let department = selectedDepartment else {
            completion(false)
            return
        }

        let otp = otpFields.joined()

        Task {
            do {
                let verifyBody = VerifyOtpBody(phoneNumber: phoneNumber, otp: otp)
                try await NetworkClient.shared.postNoResponse(
                    "auth/verify-otp",
                    body: verifyBody,
                    authorized: false
                )

                let registerBody = RegisterBody(
                    firstName: firstName,
                    lastName: lastName,
                    email: email,
                    phoneNumber: phoneNumber,
                    password: password,
                    passwordConfirmation: confirmedPassword,
                    department: department
                )

                try await NetworkClient.shared.postNoResponse(
                    "auth/register",
                    body: registerBody,
                    authorized: false
                )

                print(" ACCOUNT CREATED")
                completion(true)

            } catch {
                print(" createAccount error:", error)
                completion(false)
            }
        }
    }
}
