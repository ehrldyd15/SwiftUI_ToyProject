//
//  HealthKitManager.swift
//  HealthSample
//
//  Created by 임영선 on 5/28/25.
//

import Foundation
import HealthKit

/// 건강 데이터를 담는 모델
struct MyHealthModel {
    /// 오늘의 총 걸음 수
    var todayStepCount: Int = 0
    
    /// 오늘 이동 거리
    var todayDistance: Double = 0.0
    
    /// 오늘 소모한 칼로리
    var todayCalory: Double = 0.0

    /// 오전 동안의 걸음 수
    var morningStepCount: Int = 0
    
    /// 오후 동안의 걸음 수
    var afternoonStepCount: Int = 0
    
    /// 오늘 총 지방 소모량
    var fatBurned: Double = 0.0

    /// 지난주 총 걸음 수
    var lastWeekStepCount: Int = 0
    
    /// 지난주 일평균 걸음 수
    var lastWeekAverageSteps: Int = 0

    /// 최근 한 달 간 누적 걸음 수
    var monthlyTotalSteps: Int = 0
}

class HealthKitManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    @Published var myHealthModel: MyHealthModel = MyHealthModel()
    
    /// HealthKit 사용 가능 여부 확인
    func isHealthKitAvailable() -> Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
    
    /// 권한 체크
    func checkAndRequestPermission() {
        if isHealthKitAvailable() {
            guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }

            // 현재 권한 상태 확인
            let authStatus = checkAuthorizationStatus(for: stepsQuantityType)
            
            switch authStatus {
            case .sharingAuthorized:
                print("권한이 이미 허용되어 있습니다.")
//                fetchMyHealthData() { model in
//                    self.myHealthModel = model
//                }
                
            case .sharingDenied:
                print("권한이 거부되어 있습니다. 설정에서 변경해주세요.")

            case .notDetermined:
                print("권한이 아직 결정되지 않았습니다. 권한을 요청합니다.")
                // 권한 요청
                requestHealthKitPermission()
            @unknown default:
                print("알 수 없는 상태입니다.")
            }
        } else {
            print("HealthKit을 사용할 수 없는 기기입니다.")
        }
    }
    
    /// 권한 상태 확인 함수
    func checkAuthorizationStatus(for type: HKQuantityType) -> HKAuthorizationStatus {
        return healthStore.authorizationStatus(for: type)
    }
    
    func requestHealthKitPermission() {
        guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return
        }
        
        let read = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
        
        // 권한 요청 전 상태 확인
        print("권한 요청 전 상태:")
       // debugHealthKitPermission()
        
        // 권한 요청 (읽기만 요청)
        healthStore.requestAuthorization(toShare: nil, read: read) { success, error in
            // 권한 요청 직후 상태 확인
//            DispatchQueue.main.async {
               // print("권한 요청 직후 상태 (success=\(success)):")
               // self.debugHealthKitPermission()
                
                // 약간의 지연을 주어 권한 상태가 시스템에 완전히 반영될 시간 확보
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    let actualStatus = self.healthStore.authorizationStatus(for: stepsQuantityType)

//                    print("1초 후 권한 상태:")
//                    self.debugHealthKitPermission()

                    switch actualStatus {
                    case .sharingAuthorized:
                        print("HealthKit 권한 획득 성공")
                        //self.fetchStepsData()
                    case .sharingDenied:
                        print("HealthKit 권한이 거부되었습니다. 설정에서 변경해주세요.")
                    case .notDetermined:
                        print("HealthKit 권한이 아직 결정되지 않았습니다.")
                    @unknown default:
                        print("알 수 없는 권한 상태입니다.")
                    }
//                }
//            }
        }
    }
    
    // 디버깅용 권한 상태 출력 함수
    func debugHealthKitPermission() {
        guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            print("걸음 수 데이터 타입을 가져올 수 없습니다.")
            return
        }
        
        let status = healthStore.authorizationStatus(for: stepsQuantityType)
        
        print("===== HealthKit 권한 디버깅 =====")
        switch status {
        case .sharingAuthorized:
            print("현재 걸음 수 권한 상태: 허용됨")
        case .sharingDenied:
            print("현재 걸음 수 권한 상태: 거부됨")
        case .notDetermined:
            print("현재 걸음 수 권한 상태: 결정되지 않음")
        @unknown default:
            print("현재 걸음 수 권한 상태: 알 수 없음")
        }
        print("===============================")
    }
    
    /// HealthKit에서 데이터를 가져와 MyHealthModel 리턴
        func fetchMyHealthData(completion: @escaping (MyHealthModel) -> Void) {
            let now = Date()
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: now)
            let noon = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: now)!
            let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: now)!
            let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: now)!
            
            let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
            let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
            let fatBurnType = HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal)! // 지방?

            var model = MyHealthModel()

            fetchSteps(start: startOfDay, end: now) { model.todayStepCount = $0 } // 오늘 걸음 수
            fetchSum(type: distanceType, start: startOfDay, end: now, unit: .meter()) { model.todayDistance = $0 / 1000.0 } // 오늘 이동 거리
            fetchSum(type: calorieType, start: startOfDay, end: now, unit: .kilocalorie()) { model.todayCalory = $0 } // 오늘 칼로리 소모량
            
            fetchSteps(start: startOfDay, end: noon) { model.morningStepCount = $0 } // 오늘 오전 걸음 수 - 0시~12시
            fetchSteps(start: noon, end: now) { model.afternoonStepCount = $0 } // 오늘 오후 걸음 수 - 12시~현재시간

            fetchSum(type: fatBurnType, start: startOfDay, end: now, unit: .gram()) { model.fatBurned = $0 } // 지방 소모량

            fetchSteps(start: oneWeekAgo, end: now) { model.lastWeekStepCount = $0 } // 지난 주 총 걸음 수

            fetchSteps(start: oneWeekAgo, end: now) { total in // 지난 주 평균 걸음 수
                model.lastWeekAverageSteps = total / 7
            }

            fetchSteps(start: oneMonthAgo, end: now) { model.monthlyTotalSteps = $0 } // 지난 주 일평균 걸음 수

            completion(model)
            
        }
    
    // 총합 가져오기 (ex. 걸음 수, 이동거리 ...)
    func fetchSum(type: HKQuantityType, start: Date, end: Date, unit: HKUnit, assign: @escaping (Double) -> Void) {
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            let value = result?.sumQuantity()?.doubleValue(for: unit) ?? 0
            assign(value)
        }
        healthStore.execute(query)
    }
    
    // 걸음 수 가져오기
    func fetchSteps(start: Date, end: Date, assign: @escaping (Int) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        fetchSum(type: stepType, start: start, end: end, unit: HKUnit.count()) { value in
            assign(Int(value))
        }
    }
    
   
}
