
//
//  SignUpView.swift
//  eventHub
//
//  Created by MacBook on 12/23/25.
//


import SwiftUI

struct SignUpView: View {
    let onBackToSignIn: () -> Void

    @StateObject private var viewModel = SignUpViewModel()
    
    @State private var isAgreed = false
    
    
    var body: some View {
        ScrollView {
            VStack(spacing:10){
                Text("Create Account")
                    .font(.system(size: 32, weight: .semibold))
                
                Text("Enter your details to get started.")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray))
                    .multilineTextAlignment(.center)
                
                HStack(spacing:87){
                    Text("First Name")
                    Text("Last Name")
                    
                } .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                HStack(spacing:16){
                    
                    TextField("John", text: $viewModel.firstName)
                        .textInputAutocapitalization(.words)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                        )
                    
                    TextField("Doe", text: $viewModel.lastName)
                        .textInputAutocapitalization(.words)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                        )
                    
                }.padding()
                
                Text("Email")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                TextField("john.doe@company.com", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                    ) .onChange(of: viewModel.email) { _, _ in
                        viewModel.validateEmail()
                    }
                    .padding(.horizontal)
                
                
                if let emailError = viewModel.emailError {
                    Text(emailError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                                
                Text("Phone Number")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                HStack(spacing:8){
                    TextField("555 777 777", text: $viewModel.phoneNumber)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                        ) .onChange(of: viewModel.phoneNumber) { _, newValue in
                            viewModel.updatePhone(newValue)
                        }
                    
                    
                    Button(action: viewModel.sendOTP) {
                        Text("Send OTP")
                            .font(.system(size: 14, weight: .regular))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                                    .background(Color.gray.opacity(0.1))
                            )
                    }
                    .buttonStyle(.plain)
                    
                }.padding(.horizontal)
                
                if let phoneError = viewModel.phoneError {
                    Text(phoneError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
                
                HStack(spacing: 4){
                    Image(systemName: "ellipsis.rectangle")
                        .frame(width: 13.125024795532227,height: 13.125024795532227)
                    
                    Text("Enter OTP Code")
                    
                    
                } .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    HStack(spacing: 8) {
                        ForEach(0..<6) { index in
                            TextField("", text: $viewModel.otpFields[index])
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .frame(width: 48, height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray.opacity(0.35))
                                )
                                .onChange(of: viewModel.otpFields[index]) { oldValue, newValue in
                                    viewModel.updateOTP(index: index, value: newValue)
                                }
                        }
                        
                    }
                    
                    if let otpError = viewModel.otpError {
                        Text(otpError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .padding(.horizontal)
                
       
                
                
                Text("Department")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                Menu {
                    ForEach(viewModel.departments, id: \.self) { department in
                        Button(department) {
                            viewModel.selectedDepartment = department
                            viewModel.validateDepartment()
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedDepartment ?? "Select department")
                            .foregroundColor(viewModel.selectedDepartment == nil ? .gray : .black)
                        
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray.opacity(0.35))
                    )
                }
                .padding(.horizontal)
                
                if let error = viewModel.departmentError {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
                
                HStack{
                    
                    Text("Password")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    Image(systemName: "questionmark.circle")
                        .padding(.trailing)
                }
                
                TextField("Create password", text: $viewModel.password)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                    )
                    .onChange(of: viewModel.password) { _, _ in
                            viewModel.validatePassword()
                            viewModel.validateConfirmPassword()
                        }
                    .padding(.horizontal)
                
                if let passwordError = viewModel.passwordError {
                    Text(passwordError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
                
                
                Text("Password must be at least 8 characters with uppercase, lowercase, and number")
                    .foregroundColor(Color(.systemGray))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                HStack{
                    
                    Text("Confirm Password")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    Image(systemName: "questionmark.circle")
                        .padding(.trailing)
                }
                
                TextField("Confirm password", text: $viewModel.confirmedPassword)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                    )
                    .onChange(of: viewModel.confirmedPassword) { _, _ in
                            viewModel.validateConfirmPassword()
                        }
                    .padding(.horizontal)
                
                if let confirmError = viewModel.confirmPasswordError {
                    Text(confirmError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
                
            }
            HStack {
                Button(action: { isAgreed.toggle() }) {
                    Image(systemName: isAgreed ? "checkmark.square.fill" : "square")
                        .foregroundColor(isAgreed ? .black : .gray)
                    Text("I agree to Terms of Service and Privacy Policy")
                        .foregroundColor(.black)
                }
                .buttonStyle(.plain)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            
            Button(action: {
                viewModel.createAccount { success in
                    if success {
                        print("Account CREATED")
                        onBackToSignIn()  
                    }
                }
            }) {
                Text("Create Account")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(
                        (viewModel.isFormValid && isAgreed)
                        ? Color.black
                        : Color.gray
                    )
                    .cornerRadius(6)
            }
            .disabled(!viewModel.isFormValid || !isAgreed)
            .padding(.horizontal)
            
            
            HStack {
                Text("Already have an account?")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)

                Button(action: {
                    onBackToSignIn()
                }) {
                    Text("Sign In")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                }
                .padding(.trailing)
            }

            
        } 
    }
}

#Preview {
    SignUpView(onBackToSignIn: { })
}
