//
//  ContentView.swift
//  HealthSample
//
//  Created by Do Kiyong on 4/4/25.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    @StateObject private var healthKitManager = HealthKitManager()
        
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("오늘 걸음 수: \(healthKitManager.myHealthModel.todayStepCount)")
                .font(.title3)
            
            Text(String(format: "오늘 이동 거리: %.2f km", healthKitManager.myHealthModel.todayDistance))
                .font(.title3)
            
            Text(String(format: "오늘 칼로리 소모량: %.1f kcal", healthKitManager.myHealthModel.todayCalory))
                .font(.title3)
            
            Text("오전 걸음 수: \(healthKitManager.myHealthModel.morningStepCount)")
                .font(.title3)
            
            Text("오후 걸음 수: \(healthKitManager.myHealthModel.afternoonStepCount)")
                .font(.title3)
            
            Text(String(format: "지방 소모량: %.1f g", healthKitManager.myHealthModel.fatBurned))
                .font(.title3)
            
            Text("지난주 총 걸음 수: \(healthKitManager.myHealthModel.lastWeekStepCount)")
                .font(.title3)
            
            Text("지난주 일평균 걸음 수: \(healthKitManager.myHealthModel.lastWeekAverageSteps)")
                .font(.title3)
            
            Text("1달 누적 걸음 수: \(healthKitManager.myHealthModel.monthlyTotalSteps)")
        }
        .padding()
        .onAppear {
            healthKitManager.checkAndRequestPermission()
        }
        
    }
}
    

//struct ContentView2: View {
//    @State private var showPermissionPrimer = false
//    
//    let healthStore = HKHealthStore()
//    
//    @Environment(\.openURL) var openURL // 설정 앱 열기를 위해 필요
//
//    // 설정 앱 안내 Alert를 표시할지 결정하는 상태 변수
//    @State private var showingAlert = false
//    @State private var stepCount = 0
//    
//    @State private var title = ""
//    @State private var subtitle = ""
//    @State private var confirm = ""
//    @State private var cancel = ""
//
//    var body: some View {
//        VStack(spacing: 30) {
//            Text("\(stepCount)")
//                  
//            Button("건강 데이터 접근 시작하기") {
//                checkAndRequestPermission()
////                self.triggerSystemPermissionPrompt()
//            }
//            // iOS 15 미만 호환 Alert 사용
//            .alert(isPresented: $showingAlert) { // isPresented 바인딩 사용
//                // Alert 구조체를 직접 생성하여 반환
//                Alert(
//                    title: Text(title),
//                    message: Text(subtitle),
//                    primaryButton: .default(Text(cancel)) {
//                        openAppSettings() // 설정 열기 액션
//                    },
//                    secondaryButton: .cancel(Text(confirm))
//                )
//            }
////            .alert(isPresented: $showingNoDataAlert) {
////                Alert(
////                    title: Text("데이터 없음"),
////                    message: Text("오늘 걸음수 데이터가 없습니다"),
////                    primaryButton: .default(Text("확인")) {
////                        
////                    },
////                    secondaryButton: .cancel(Text("취소"))
////                )
////            }
//        }
//    }
//    
//    // 설정 앱의 앱별 설정 화면 열기
//    func openAppSettings() {
//        // 1. UIApplication.openSettingsURLString 상수를 사용하여 URL 문자열을 가져옵니다.
//        //    이 문자열은 "app-settings:"와 같은 형태이며, iOS 시스템에
//        //    현재 앱의 설정 화면을 열도록 지시합니다.
//        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
//            print("Could not create URL for app settings.")
//            return
//        }
//
//        // 2. UIApplication.shared.canOpenURL로 해당 URL을 열 수 있는지 확인합니다.
//        //    (보통 이 경우는 항상 true이지만, 확인하는 것이 안전합니다.)
//        if UIApplication.shared.canOpenURL(settingsURL) {
//            // 3. UIApplication.shared.open을 사용하여 설정 앱의 앱별 설정 화면을 엽니다.
//            UIApplication.shared.open(settingsURL) { success in
//                // 4. (선택 사항) 열기 시도가 성공했는지 로그를 남깁니다.
//                print(success ? "Successfully requested to open app settings." : "Failed to request opening app settings.")
//            }
//        } else {
//             print("Cannot open app settings URL (This should not happen normally).")
//        }
//    }
//
//    func checkAndRequestPermission() {
//        if isHealthKitAvailable() {
//            guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
//                return
//            }
//
//            
//            // 현재 권한 상태 확인
//            let authStatus = checkAuthorizationStatus(for: stepsQuantityType)
//            
//            switch authStatus {
//            case .sharingAuthorized:
//                print("권한이 이미 허용되어 있습니다.")
//                // 바로 걸음수 데이터 가져오기
//                fetchStepsData()
//            case .sharingDenied:
//                print("권한이 거부되어 있습니다. 설정에서 변경해주세요.")
////                HealthDataManager.shared.requestHealthKitPermission()
//                fetchStepsData()
//                // 사용자에게 설정으로 이동하도록 안내하는 알림 표시
//                
//            case .notDetermined:
//                print("권한이 아직 결정되지 않았습니다. 권한을 요청합니다.")
                // 권한 요청
//                requestHealthKitPermission()
//            @unknown default:
//                print("알 수 없는 상태입니다.")
//            }
//        } else {
//            print("HealthKit을 사용할 수 없는 기기입니다.")
//        }
//    }
//
//    // HealthKit 사용 가능 여부 확인
//    func isHealthKitAvailable() -> Bool {
//        return HKHealthStore.isHealthDataAvailable()
//    }
//    
//    // 디버깅용 권한 상태 출력 함수
//    func debugHealthKitPermission() {
//        guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
//            print("걸음 수 데이터 타입을 가져올 수 없습니다.")
//            return
//        }
//        
//        let status = healthStore.authorizationStatus(for: stepsQuantityType)
//        
//        print("===== HealthKit 권한 디버깅 =====")
//        switch status {
//        case .sharingAuthorized:
//            print("현재 걸음 수 권한 상태: 허용됨")
//        case .sharingDenied:
//            print("현재 걸음 수 권한 상태: 거부됨")
//        case .notDetermined:
//            print("현재 걸음 수 권한 상태: 결정되지 않음")
//        @unknown default:
//            print("현재 걸음 수 권한 상태: 알 수 없음")
//        }
//        print("===============================")
//    }
//    
//    func requestHealthKitPermission() {
//        guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
//            return
//        }
//        
//        let read = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!, HKObjectType.quantityType(forIdentifier: .stepCount)!, HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!, HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!])
//        let share = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!, HKObjectType.quantityType(forIdentifier: .stepCount)!, HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!, HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!])
//        
//        let read = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
//        let share = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
//        let read: Set<HKObjectType> = [stepsQuantityType]
//        let share: Set<HKSampleType>? = Set<HKSampleType>()
//        
//        // 권한 요청 전 상태 확인
//        print("권한 요청 전 상태:")
//        debugHealthKitPermission()
//        
//        // 권한 요청 (읽기만 요청)
////        healthStore.requestAuthorization(toShare: [], read: [stepsQuantityType]) { [weak self] success, error in
//        healthStore.requestAuthorization(toShare: share, read: read) { success, error in
//            // 권한 요청 직후 상태 확인
//            DispatchQueue.main.async {
//                print("권한 요청 직후 상태 (success=\(success)):")
//                self.debugHealthKitPermission()
//                
//                // 약간의 지연을 주어 권한 상태가 시스템에 완전히 반영될 시간 확보
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                    let actualStatus = self.healthStore.authorizationStatus(for: stepsQuantityType)
//
//                    print("1초 후 권한 상태:")
//                    self.debugHealthKitPermission()
//
//                    switch actualStatus {
//                    case .sharingAuthorized:
//                        print("HealthKit 권한 획득 성공")
//                        self.fetchStepsData()
//                    case .sharingDenied:
//                        print("HealthKit 권한이 거부되었습니다. 설정에서 변경해주세요.")
//                    case .notDetermined:
//                        print("HealthKit 권한이 아직 결정되지 않았습니다.")
//                    @unknown default:
//                        print("알 수 없는 권한 상태입니다.")
//                    }
//                }
//            }
//        }
//    }
//
//    // 권한 상태 확인 함수
//    func checkAuthorizationStatus(for type: HKQuantityType) -> HKAuthorizationStatus {
//        return healthStore.authorizationStatus(for: type)
//    }
//    
//    // 특정 기간의 걸음 수 데이터 가져오기
//     func fetchStepsCount(from startDate: Date, to endDate: Date, completion: @escaping (Double, Error?) -> Void) {
//         // 걸음 수 데이터 타입
//         guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
//             completion(0, nil)
//             return
//         }
//         
//         // 기간 조건 설정
//         let predicate = HKQuery.predicateForSamples(
//             withStart: startDate,
//             end: endDate,
//             options: .strictStartDate
//         )
//         
//         // 통계 쿼리 설정
//         let query = HKStatisticsQuery(
//             quantityType: stepsQuantityType,
//             quantitySamplePredicate: predicate,
//             options: .cumulativeSum
//         ) { _, result, error in
//             guard let result = result, let sum = result.sumQuantity() else {
//                 completion(0, error)
//                 return
//             }
//             
//             // 결과 반환 (걸음 수)
//             let steps = sum.doubleValue(for: HKUnit.count())
//             completion(steps, nil)
//         }
//         
//         // 쿼리 실행
//         healthStore.execute(query)
//     }
//    
//    // 오늘의 걸음 수 데이터 가져오기
//    func fetchTodayStepCount(completion: @escaping (Double, Error?) -> Void) {
//        // 걸음 수 데이터 타입
//        guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
//            completion(0, nil)
//            return
//        }
//        
//        // 오늘 날짜 기준으로 설정
//        let now = Date()
//        let startOfDay = Calendar.current.startOfDay(for: now)
//        
//        // 오늘 하루 간격의 조건 설정
//        let predicate = HKQuery.predicateForSamples(
//            withStart: startOfDay,
//            end: now,
//            options: .strictStartDate
//        )
//        
//        let metadataKeyWasUserEntered = HKMetadataKeyWasUserEntered // 메타데이터 키 정의
//        let predicateExcludingUserEnteredData = NSCompoundPredicate(
//            andPredicateWithSubpredicates: [
//                HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate), // 시간 범위 조건
//                NSPredicate(format: "metadata[%@] != YES", metadataKeyWasUserEntered) // 사용자 입력 제외 조건
//            ]
//        )
//        
//        // 통계 쿼리 설정
//        let query = HKStatisticsQuery(
//            quantityType: stepsQuantityType,
//            quantitySamplePredicate: predicateExcludingUserEnteredData,
//            options: .cumulativeSum
//        ) { _, result, error in
//            guard let result = result, let sum = result.sumQuantity() else {
//                completion(0, error)
//                return
//            }
//            
//            // 결과 반환 (걸음 수)
//            let steps = sum.doubleValue(for: HKUnit.count())
//            completion(steps, nil)
//        }
//        
//        let metadataKeyWasUserEntered = HKMetadataKeyWasUserEntered
//        let predicateExcludingUserEnteredData = NSCompoundPredicate(
//            andPredicateWithSubpredicates: [
//                HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate),
//                NSPredicate(format: "metadata.%K != YES", metadataKeyWasUserEntered)
//            ]
//        )
//
//        let query = HKStatisticsQuery(
//            quantityType: stepsQuantityType,
//            quantitySamplePredicate: predicateExcludingUserEnteredData,
//            options: .cumulativeSum
//        ) { _, result, error in
//            guard let result = result, let sum = result.sumQuantity() else {
//                completion(0, error)
//                return
//            }
//            
//            // 결과 반환 (걸음 수)
//            let steps = sum.doubleValue(for: HKUnit.count())
//            completion(steps, nil)
//        }
//        
//        let query = HKSampleQuery(sampleType: stepsQuantityType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { result, samples, error in
//            guard error == nil else {
//                print("Error fetching step count: \(error!)")
//                return
//            }
//            
//            let stepSamples = samples as? [HKQuantitySample] ?? []
//            
//            let actualSteps = stepSamples.filter { sample in
//                let metadata = sample.metadata?[HKMetadataKeyWasUserEntered] as? Bool
//                return metadata != true
//            }
//
//            let totalSteps = actualSteps.reduce(0.0) { sum, sample in
//                return sum + sample.quantity.doubleValue(for: HKUnit.count())
//            }
//            
//            completion(totalSteps, nil)
//        }
//        
//        // 쿼리 실행
//        healthStore.execute(query)
//    }
//
//
//    
//    // 걸음 수 데이터 가져오기 및 처리
//    func fetchStepsData() {
//        self.fetchTodayStepCount { steps, error in
//            if let error = error {
//                print("걸음 수 데이터 가져오기 오류: \(error.localizedDescription)")
//                
//                // 오류 메시지가 "No data available"인 경우 특별 처리
//                if error.localizedDescription.contains("No data available") {
//                    print("오늘 기록된 걸음 수 데이터가 없습니다.")
//                    // 최근 7일간의 데이터 확인 (테스트용)
//                    
//                    self.fetchRecentStepsData(noPermissionCompletion: {
//                        title = "권한 필요"
//                        subtitle = "앱의 일부 기능을 사용하려면 건강 데이터 접근 권한이 필요합니다. '설정' 앱에서 권한을 허용해주세요"
//                        confirm = "확인"
//                        cancel = "설정이동"
//                        showingAlert = true
//                    }, permissionCompletion: {
//                        title = "데이터 없음"
//                        subtitle = "데이터없음"
//                        confirm = "확인"
//                        cancel = "취소"
//                        showingAlert = true
//                    })
//                    
//                    
//                }
//            } else {
//                print("오늘의 걸음 수: \(Int(steps))")
//                stepCount = Int(steps)
//            }
//        }
//    }
//    
//    // 최근 7일간의 걸음 수 데이터 가져오기 (테스트용)
//    func fetchRecentStepsData(noPermissionCompletion: @escaping () -> (), permissionCompletion: @escaping () -> ()) {
//        let now = Date()
//        guard let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: now) else {
//            return
//        }
//        
//        self.fetchStepsCount(from: weekAgo, to: now) { steps, error in
//            if let error = error {
//                print("최근 7일간 걸음 수 데이터 가져오기 오류: \(error.localizedDescription)")
//                noPermissionCompletion()
//            } else {
//                print("최근 7일간 총 걸음 수: \(Int(steps))")
//                permissionCompletion()
//            }
//        }
//    }
//
//    // 설정으로 유도하는 알림 (예시)
//    func showSettingsAlert() {
//        // 실제 앱에서는 AlertController나 SwiftUI Alert 사용
//        showingSettingsAlert = true
//        print("Showing alert to guide user to Settings app.")
//    }
//}
//
//
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
//
//
//#Preview {
//    ContentView()
//}

//import SwiftUI
//import HealthKit
//
//struct ContentView: View {
//    @State private var showPermissionPrimer = false
//    
//    let healthStore = HKHealthStore()
//    
//    @Environment(\.openURL) var openURL // 설정 앱 열기를 위해 필요
//
//    // 설정 앱 안내 Alert를 표시할지 결정하는 상태 변수
//    @State private var showingSettingsAlert = false
//
//    var body: some View {
//        VStack {
//            Button("건강 데이터 접근 시작하기") {
//                checkAndRequestPermission()
////                self.triggerSystemPermissionPrompt()
//            }
//            // iOS 15 미만 호환 Alert 사용
//            .alert(isPresented: $showingSettingsAlert) { // isPresented 바인딩 사용
//                // Alert 구조체를 직접 생성하여 반환
//                Alert(
//                    title: Text("권한 필요"),
//                    message: Text("앱의 일부 기능을 사용하려면 건강 데이터 접근 권한이 필요합니다. '설정' 앱에서 권한을 허용해주세요."),
//                    primaryButton: .default(Text("설정 열기")) { // 기본 버튼
//                        openAppSettings() // 설정 열기 액션
//                    },
//                    secondaryButton: .cancel(Text("취소")) // 취소 버튼 (기본 텍스트 사용 시 .cancel()만 써도 됨)
//                )
//            }
//        }
//        .sheet(isPresented: $showPermissionPrimer) {
//            HealthPermissionPrimerView { // 사용자 정의 바텀시트 뷰
//                // Primer View에서 "동의하고 계속하기" 버튼 눌렀을 때
//                self.showPermissionPrimer = false // 시트 닫기
//                self.triggerSystemPermissionPrompt() // 실제 시스템 권한 요청
//            }
//        }
//    }
//    
//    // 설정 앱의 앱별 설정 화면 열기
//    func openAppSettings() {
//        // 1. UIApplication.openSettingsURLString 상수를 사용하여 URL 문자열을 가져옵니다.
//        //    이 문자열은 "app-settings:"와 같은 형태이며, iOS 시스템에
//        //    현재 앱의 설정 화면을 열도록 지시합니다.
//        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
//            print("Could not create URL for app settings.")
//            return
//        }
//
//        // 2. UIApplication.shared.canOpenURL로 해당 URL을 열 수 있는지 확인합니다.
//        //    (보통 이 경우는 항상 true이지만, 확인하는 것이 안전합니다.)
//        if UIApplication.shared.canOpenURL(settingsURL) {
//            // 3. UIApplication.shared.open을 사용하여 설정 앱의 앱별 설정 화면을 엽니다.
//            UIApplication.shared.open(settingsURL) { success in
//                // 4. (선택 사항) 열기 시도가 성공했는지 로그를 남깁니다.
//                print(success ? "Successfully requested to open app settings." : "Failed to request opening app settings.")
//            }
//        } else {
//             print("Cannot open app settings URL (This should not happen normally).")
//        }
//    }
//
//    func checkAndRequestPermission() {
//        guard HKHealthStore.isHealthDataAvailable() else {
//            print("HealthKit not available")
//            // 사용자에게 알림 등 처리
//            return
//        }
//
//        // 예시: 걸음 수 타입에 대한 현재 상태 확인
//        guard let stepType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
//        let status = healthStore.authorizationStatus(for: stepType)
//
//        switch status {
//        case .notDetermined:
//            // 아직 결정되지 않음 -> 사전 안내 UI(바텀시트) 표시
//            print("Authorization not determined. Showing primer sheet.")
//            showPermissionPrimer = true
//        case .sharingDenied:
//            print("Authorization denied.")
//            // 사용자가 거부한 상태 -> 설정 앱으로 유도하는 안내 표시 (다른 UI)
//            // 예: "건강 데이터 접근이 거부되었습니다. 앱 기능을 사용하려면 '설정 > 개인 정보 보호 > 건강 > [내 앱 이름]'에서 권한을 허용해주세요."
////            showSettingsAlert()
//            showingSettingsAlert = true
////            self.triggerSystemPermissionPrompt()
//        case .sharingAuthorized:
//            print("Authorization already authorized.")
//            // 이미 허용됨 -> 데이터 접근 로직 바로 실행
//            fetchHealthData()
//        @unknown default:
//            fatalError("Unknown HealthKit authorization status")
//        }
//    }
//
//    // 시스템 권한 요청 트리거
//    func triggerSystemPermissionPrompt() {
//        print("Triggering system permission prompt...")
//        guard let dataTypes = prepareHealthDataTypes() else { return }
//        
////        let read: Set = [HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!,
////                                     HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
////                                     HKSampleType.quantityType(forIdentifier: .appleExerciseTime)!]
////        let share: Set = [HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!,
////                                      HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!]
//        
//        guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
//            return
//        }
//        
//        let read: Set = [HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!,
//                                     HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
//                                     HKSampleType.quantityType(forIdentifier: .appleExerciseTime)!]
//        let share: Set<HKSampleType>? = Set<HKSampleType>()
//
//        healthStore.requestAuthorization(toShare: share, read: read) { success, error in
//            DispatchQueue.main.async { // UI 업데이트는 메인 스레드에서
//                if success {
//                    print("System prompt shown (user might have allowed or denied specific types).")
//                    // 사용자가 창에서 선택한 후, 실제 권한 상태 다시 확인 필요
//                    checkAuthorizationStatusAfterPrompt(for: dataTypes.read.first!) // 예시로 첫번째 읽기 타입 확인
//                } else {
//                    print("Authorization request failed: \(error?.localizedDescription ?? "Unknown error")")
//                    // 오류 처리
//                }
//            }
//        }
//    }
//
//    // 시스템 프롬프트 이후 상태 확인 (예시)
//    func checkAuthorizationStatusAfterPrompt(for type: HKObjectType) {
//        let status = healthStore.authorizationStatus(for: type)
//        print("Status after prompt for \(type.identifier): \(status.rawValue)")
//        if status == .sharingAuthorized {
//            fetchHealthData()
//        } else {
//            // 권한이 거부되었거나 부분적으로만 허용된 경우 처리
//            print("Permission not granted for \(type.identifier) after prompt.")
//        }
//    }
//
//    // 필요한 데이터 타입 준비 (이전 답변 참고)
//    func prepareHealthDataTypes() -> (read: Set<HKObjectType>, write: Set<HKSampleType>)? {
//        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return nil }
//        let readTypes: Set<HKObjectType> = [stepCountType]
//        let writeTypes: Set<HKSampleType> = [] // 쓰기 권한이 필요 없다면 비워둠
//        return (read: readTypes, write: writeTypes)
//    }
//
//    // 데이터 가져오기 (예시)
//    func fetchHealthData() {
//        print("Fetching health data...")
//        // 실제 데이터 접근 로직 구현
//    }
//
////    // 설정으로 유도하는 알림 (예시)
////    func showSettingsAlert() {
////        // 실제 앱에서는 AlertController나 SwiftUI Alert 사용
////        showingSettingsAlert = true
////        print("Showing alert to guide user to Settings app.")
////    }
//}
//
//// 사용자 정의 바텀시트 뷰 (간단한 예시)
//struct HealthPermissionPrimerView: View {
//    var onAgree: () -> Void // 동의 버튼 콜백
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            Text("건강 데이터 접근 안내")
//                .font(.title2).bold()
//
//            Text("더 나은 서비스 제공을 위해 건강 앱의 데이터 접근 권한이 필요합니다.\n\n요청 항목:\n• 걸음 수 (읽기)")
//
//            Text("수집된 정보는 앱 내에서 활동량을 분석하고 목표 달성을 돕는 데 사용됩니다.")
//                .font(.footnote)
//                .foregroundColor(.gray)
//
//            Spacer()
//
//            Button("동의하고 계속하기") {
//                onAgree() // 콜백 실행 -> 시스템 프롬프트 트리거
//            }
//            .padding(.bottom)
//        }
//        .padding()
//    }
//}
//
//
////struct ContentView: View {
////    var body: some View {
////        VStack {
////            Image(systemName: "globe")
////                .imageScale(.large)
////
////            Text("Hello, world!")
////        }
////        .padding()
////    }
////}
//
//#Preview {
//    ContentView()
//}
