//
//  HealthKitManager.swift
//  HealthSample
//
//  Created by 임영선 on 5/28/25.
//

import Foundation
import HealthKit
import Combine

class HealthKitManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var todayStepCount: Int = 0
    @Published var todayDistance: Double = 0
    @Published var todayCalory: Double = 0
    @Published var morningStepCount: Int = 0
    @Published var afternoonStepCount: Int = 0
    @Published var fatBurned: Double = 0
    @Published var lastWeekStepCount: Int = 0
    @Published var lastWeekAverageSteps: Int = 0
    @Published var monthlyTotalSteps: Int = 0
    
    
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
                fetchAllHealthData()
            case .sharingDenied:
                print("권한이 거부되어 있습니다. 설정에서 변경해주세요.")
                fetchAllHealthData()
                
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
        
        let read = Set([HKQuantityType.quantityType(forIdentifier: .stepCount)!,
                        HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                        HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
                        HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal)!])
        

        // 권한 요청 (읽기만 요청)
        healthStore.requestAuthorization(toShare: nil, read: read) { success, error in
            let actualStatus = self.healthStore.authorizationStatus(for: stepsQuantityType)
            
            switch actualStatus {
            case .sharingAuthorized:
                print("HealthKit 권한 획득 성공")
                self.fetchAllHealthData()
                
            case .sharingDenied:
                print("HealthKit 권한이 거부되었습니다. 설정에서 변경해주세요.")
                self.fetchAllHealthData()
                
            case .notDetermined:
                print("HealthKit 권한이 아직 결정되지 않았습니다.")
                
            @unknown default:
                print("알 수 없는 권한 상태입니다.")
            }
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
    
    /// 최근 7일간의 걸음 수 데이터 가져오기 (테스트용)
    func fetchRecentStepsData(noPermissionCompletion: @escaping () -> (), permissionCompletion: @escaping () -> ()) {
        let now = Date()
        guard let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: now) else {
            return
        }
        
        self.fetchStepsCount(from: weekAgo, to: now) { steps, error in
            if let error = error {
                print("최근 7일간 걸음 수 데이터 가져오기 오류: \(error.localizedDescription)")
                noPermissionCompletion()
            } else {
                print("최근 7일간 총 걸음 수: \(Int(steps))")
                permissionCompletion()
            }
        }
    }
    
    // 특정 기간의 걸음 수 데이터 가져오기
    func fetchStepsCount(from startDate: Date, to endDate: Date, completion: @escaping (Double, Error?) -> Void) {
        // 걸음 수 데이터 타입
        guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(0, nil)
            return
        }
        
        // 기간 조건 설정
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate,
            options: .strictStartDate
        )
        
        // 통계 쿼리 설정
        let query = HKStatisticsQuery(
            quantityType: stepsQuantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0, error)
                return
            }
            
            // 결과 반환 (걸음 수)
            let steps = sum.doubleValue(for: HKUnit.count())
            completion(steps, nil)
        }
        
        // 쿼리 실행
        healthStore.execute(query)
    }
    
    func fetchAllHealthData() {
        let now = Date()
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: now)
        let noon = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: now)!
        let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: now)!
        let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: now)!
        
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let fatBurnType = HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal)!
        
        // 오늘 걸음 수
        fetchSteps(start: startOfDay, end: now) { value in
            DispatchQueue.main.async {
                self.todayStepCount = value
            }
        }
        
        // 오늘 이동거리
        fetchHealthDataUnit(type: distanceType, start: startOfDay, end: now, unit: .meter()) { value in
            DispatchQueue.main.async {
                self.todayDistance = value / 1000.0
            }
        }
        
        // 오늘 칼로리 소모량
        fetchHealthDataUnit(type: calorieType, start: startOfDay, end: now, unit: .largeCalorie()) { value in
            DispatchQueue.main.async {
                self.todayCalory = value
            }
        }
        
        // 오전 걸음 수
        fetchSteps(start: startOfDay, end: noon) { value in
            DispatchQueue.main.async {
                self.morningStepCount = value
            }
        }
        
        // 오후 걸음 수
        fetchSteps(start: noon, end: now) { value in
            DispatchQueue.main.async {
                self.afternoonStepCount = value
            }
        }
        
        // 지방 소모량 -> 안나옴
        fetchHealthDataUnit(type: fatBurnType, start: startOfDay, end: now, unit: .gram()) { value in
            DispatchQueue.main.async {
                self.fatBurned = value
            }
        }
        
        // 지난 주 걸음 수
        fetchSteps(start: oneWeekAgo, end: now) { value in
            DispatchQueue.main.async {
                self.lastWeekStepCount = value
                self.lastWeekAverageSteps = value / 7
            }
        }
        
        // 일평균 걸음 수
        fetchSteps(start: oneMonthAgo, end: now) { value in
            DispatchQueue.main.async {
                self.monthlyTotalSteps = value
            }
        }
        
    }
    
    /// 유닛별 헬스데이터 가져오기 (ex. 걸음 수, 이동거리 ...)
    func fetchHealthDataUnit(type: HKQuantityType, start: Date, end: Date, unit: HKUnit, assign: @escaping (Double) -> Void) {
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            let value = result?.sumQuantity()?.doubleValue(for: unit) ?? 0
            assign(value)
        }
        healthStore.execute(query)
    }
    
    /// 걸음 수 가져오기
    func fetchSteps(start: Date, end: Date, assign: @escaping (Int) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        fetchHealthDataUnit(type: stepType, start: start, end: end, unit: HKUnit.count()) { value in
            assign(Int(value))
        }
    }
    
    
}
