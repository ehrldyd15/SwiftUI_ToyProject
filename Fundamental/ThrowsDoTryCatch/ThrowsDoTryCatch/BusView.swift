//
//  BusView.swift
//  ThrowsDoTryCatch
//
//  Created by Do Kiyong on 12/11/23.
//

import SwiftUI

class BusManager {
    
    let isActive: Bool = false
    
    /*
    func changeDisplay() -> (title: String?, error: Error?) {
        if isActive {
            return ("버스가 출발합니다", nil)
        } else {
            return (nil, URLError(.unknown))
        }
    }
     
    
    func changeDisplay() -> Result<String, Error> {
        if isActive {
            return .success("버스가 출발합니다")
        } else {
            return .failure(URLError(.unknown))
        }
    }
    
    func changeDisplay() throws -> String {
        if isActive {
            return "버스가 출발합니다"
        } else {
            throw URLError(.unknown)
        }
    }
    
    func changeDisplay2() throws -> String {
        if isActive {
            return "버스가 출발합니다"
        } else {
            throw URLError(.unknown)
        }
    }
     */
    
    func changeDisplayWithError() throws -> String {
        if isActive {
            return "버스가 출발합니다"
        } else {
            throw DisplayError.notDriveTime
        }
    }
}

class BusViewModel: ObservableObject {
    
    @Published var display: String = "버스가 출발하기 전"
    let manager = BusManager()
    
    func driving() {
        /*
        let returnedValue = manager.changeDisplay()
        
        if let newDisplay = returnedValue.title {
            self.display = newDisplay
        } else if let error = returnedValue.error {
            self.display = error.localizedDescription
        }
         
        let result = manager.changeDisplay()
        
        switch result {
        case .success(let newDisplay):
            display = newDisplay
        case .failure(let error):
            self.display = error.localizedDescription
        }
        
        // 사용자에게 에러메시지를 노출할 필요가 없을때 do catch를 안쓰고 그냥 옵셔널 처리로 쓴다.
        let newDisplay = try? manager.changeDisplay()
        
        do {
            let newDisplay = try? manager.changeDisplay()
            // try가 실패하더라도 옵셔널이기 때문에 아래코드(newDisplay2) 실행
            if let newDisplay = newDisplay {
                self.display = newDisplay
            }
            
            let newDisplay2 = try manager.changeDisplay()
            // try가 실패하면 아래코드 실행 안됨
            self.display = newDisplay2
        } catch {
            self.display = error.localizedDescription
        }
         */
    }
    
    func drivingReally() throws {
        self.display = try manager.changeDisplayWithError()
    }
    
}

struct BusView: View {
    
    @StateObject private var viewModel = BusViewModel()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some View {
        Text(viewModel.display)
            .font(.largeTitle)
            .bold()
            .onTapGesture {
                do {
                    try viewModel.drivingReally()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "버스 운행시간이 아닙니다")
                }
            }
        // item에 변동사항이 있을때 .sheet가 작동한다.
            .sheet(item: $errorWrapper) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
    }
    
}

#Preview {
    BusView()
}
