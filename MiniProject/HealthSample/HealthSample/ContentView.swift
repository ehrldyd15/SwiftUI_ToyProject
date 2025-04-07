//
//  ContentView.swift
//  HealthSample
//
//  Created by Do Kiyong on 4/4/25.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var showPermissionPrimer = false
    
    let healthStore = HKHealthStore()
    
    @Environment(\.openURL) var openURL // 설정 앱 열기를 위해 필요

    // 설정 앱 안내 Alert를 표시할지 결정하는 상태 변수
    @State private var showingSettingsAlert = false

    var body: some View {
        VStack {
            Button("건강 데이터 접근 시작하기") {
                checkAndRequestPermission()
//                self.triggerSystemPermissionPrompt()
            }
            // iOS 15 미만 호환 Alert 사용
            .alert(isPresented: $showingSettingsAlert) { // isPresented 바인딩 사용
                // Alert 구조체를 직접 생성하여 반환
                Alert(
                    title: Text("권한 필요"),
                    message: Text("앱의 일부 기능을 사용하려면 건강 데이터 접근 권한이 필요합니다. '설정' 앱에서 권한을 허용해주세요."),
                    primaryButton: .default(Text("설정 열기")) { // 기본 버튼
                        openAppSettings() // 설정 열기 액션
                    },
                    secondaryButton: .cancel(Text("취소")) // 취소 버튼 (기본 텍스트 사용 시 .cancel()만 써도 됨)
                )
            }
        }
        .sheet(isPresented: $showPermissionPrimer) {
            HealthPermissionPrimerView { // 사용자 정의 바텀시트 뷰
                // Primer View에서 "동의하고 계속하기" 버튼 눌렀을 때
                self.showPermissionPrimer = false // 시트 닫기
                self.triggerSystemPermissionPrompt() // 실제 시스템 권한 요청
            }
        }
    }
    
    // 설정 앱의 앱별 설정 화면 열기
    func openAppSettings() {
        // 1. UIApplication.openSettingsURLString 상수를 사용하여 URL 문자열을 가져옵니다.
        //    이 문자열은 "app-settings:"와 같은 형태이며, iOS 시스템에
        //    현재 앱의 설정 화면을 열도록 지시합니다.
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            print("Could not create URL for app settings.")
            return
        }

        // 2. UIApplication.shared.canOpenURL로 해당 URL을 열 수 있는지 확인합니다.
        //    (보통 이 경우는 항상 true이지만, 확인하는 것이 안전합니다.)
        if UIApplication.shared.canOpenURL(settingsURL) {
            // 3. UIApplication.shared.open을 사용하여 설정 앱의 앱별 설정 화면을 엽니다.
            UIApplication.shared.open(settingsURL) { success in
                // 4. (선택 사항) 열기 시도가 성공했는지 로그를 남깁니다.
                print(success ? "Successfully requested to open app settings." : "Failed to request opening app settings.")
            }
        } else {
             print("Cannot open app settings URL (This should not happen normally).")
        }
    }

    func checkAndRequestPermission() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit not available")
            // 사용자에게 알림 등 처리
            return
        }

        // 예시: 걸음 수 타입에 대한 현재 상태 확인
        guard let stepType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
        let status = healthStore.authorizationStatus(for: stepType)

        switch status {
        case .notDetermined:
            // 아직 결정되지 않음 -> 사전 안내 UI(바텀시트) 표시
            print("Authorization not determined. Showing primer sheet.")
            showPermissionPrimer = true
        case .sharingDenied:
            print("Authorization denied.")
            // 사용자가 거부한 상태 -> 설정 앱으로 유도하는 안내 표시 (다른 UI)
            // 예: "건강 데이터 접근이 거부되었습니다. 앱 기능을 사용하려면 '설정 > 개인 정보 보호 > 건강 > [내 앱 이름]'에서 권한을 허용해주세요."
//            showSettingsAlert()
            showingSettingsAlert = true
//            self.triggerSystemPermissionPrompt()
        case .sharingAuthorized:
            print("Authorization already authorized.")
            // 이미 허용됨 -> 데이터 접근 로직 바로 실행
            fetchHealthData()
        @unknown default:
            fatalError("Unknown HealthKit authorization status")
        }
    }

    // 시스템 권한 요청 트리거
    func triggerSystemPermissionPrompt() {
        print("Triggering system permission prompt...")
        guard let dataTypes = prepareHealthDataTypes() else { return }
        
//        let read: Set = [HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!,
//                                     HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
//                                     HKSampleType.quantityType(forIdentifier: .appleExerciseTime)!]
//        let share: Set = [HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!,
//                                      HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!]
        
        guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return
        }
        
        let read: Set = [HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                                     HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
                                     HKSampleType.quantityType(forIdentifier: .appleExerciseTime)!]
        let share: Set<HKSampleType>? = Set<HKSampleType>()

        healthStore.requestAuthorization(toShare: share, read: read) { success, error in
            DispatchQueue.main.async { // UI 업데이트는 메인 스레드에서
                if success {
                    print("System prompt shown (user might have allowed or denied specific types).")
                    // 사용자가 창에서 선택한 후, 실제 권한 상태 다시 확인 필요
                    checkAuthorizationStatusAfterPrompt(for: dataTypes.read.first!) // 예시로 첫번째 읽기 타입 확인
                } else {
                    print("Authorization request failed: \(error?.localizedDescription ?? "Unknown error")")
                    // 오류 처리
                }
            }
        }
    }

    // 시스템 프롬프트 이후 상태 확인 (예시)
    func checkAuthorizationStatusAfterPrompt(for type: HKObjectType) {
        let status = healthStore.authorizationStatus(for: type)
        print("Status after prompt for \(type.identifier): \(status.rawValue)")
        if status == .sharingAuthorized {
            fetchHealthData()
        } else {
            // 권한이 거부되었거나 부분적으로만 허용된 경우 처리
            print("Permission not granted for \(type.identifier) after prompt.")
        }
    }

    // 필요한 데이터 타입 준비 (이전 답변 참고)
    func prepareHealthDataTypes() -> (read: Set<HKObjectType>, write: Set<HKSampleType>)? {
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return nil }
        let readTypes: Set<HKObjectType> = [stepCountType]
        let writeTypes: Set<HKSampleType> = [] // 쓰기 권한이 필요 없다면 비워둠
        return (read: readTypes, write: writeTypes)
    }

    // 데이터 가져오기 (예시)
    func fetchHealthData() {
        print("Fetching health data...")
        // 실제 데이터 접근 로직 구현
    }

//    // 설정으로 유도하는 알림 (예시)
//    func showSettingsAlert() {
//        // 실제 앱에서는 AlertController나 SwiftUI Alert 사용
//        showingSettingsAlert = true
//        print("Showing alert to guide user to Settings app.")
//    }
}

// 사용자 정의 바텀시트 뷰 (간단한 예시)
struct HealthPermissionPrimerView: View {
    var onAgree: () -> Void // 동의 버튼 콜백

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("건강 데이터 접근 안내")
                .font(.title2).bold()

            Text("더 나은 서비스 제공을 위해 건강 앱의 데이터 접근 권한이 필요합니다.\n\n요청 항목:\n• 걸음 수 (읽기)")

            Text("수집된 정보는 앱 내에서 활동량을 분석하고 목표 달성을 돕는 데 사용됩니다.")
                .font(.footnote)
                .foregroundColor(.gray)

            Spacer()

            Button("동의하고 계속하기") {
                onAgree() // 콜백 실행 -> 시스템 프롬프트 트리거
            }
            .padding(.bottom)
        }
        .padding()
    }
}


//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}

#Preview {
    ContentView()
}
