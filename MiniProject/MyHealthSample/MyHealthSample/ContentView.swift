//
//  ContentView.swift
//  MyHealthSample
//
//  Created by Do Kiyong on 5/8/25.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var stepCount = 0
    @State private var distance = 0
    
    @State private var morningSteps = 0
    @State private var morningDistance = 0
    @State private var afternoonSteps = 0
    @State private var afternoonDistance = 0
    
    @State private var timeData: [String: (steps: Int, distance: Int)] = [:]
    
    @State private var initialRealTimeStepCount = 0
    @State private var initialRealTimeDistance = 0
    @State private var realTimeStepCount = 0
    @State private var realTimeDistance = 0
    
    @State private var isMeasuring = false
    
    let pedometer = CMPedometer()
    
    var body: some View {
        VStack {
            // 화면 중앙 텍스트
            Text(displayText(for: selectedTab))
                .font(.largeTitle)
                .padding()
            
            Spacer()

            // 탭 뷰
            TabView(selection: $selectedTab) {
                VStack {
                    Text("걸음 수: \(stepCount)")
                        .font(.largeTitle)
                        .bold()
                    Text("이동 거리: \(distance)m")
                        .font(.largeTitle)
                        .bold()
                    Button(action: {
                        requestPermission()
                    }) {
                        Text("가져오기")
                            .font(.title3)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("총 데이터")
                }.tag(0)

                VStack {
                    Text("오전 걸음 수: \(morningSteps)")
                        .font(.largeTitle)
                        .bold()
                    Text("오전 이동 거리: \(morningDistance)m")
                        .font(.largeTitle)
                        .bold()
                    Text("오후 걸음 수: \(afternoonSteps)")
                        .font(.largeTitle)
                        .bold()
                    Text("오후 이동 거리: \(afternoonDistance)m")
                        .font(.largeTitle)
                        .bold()
                    Button(action: {
                        requestPermission()
                    }) {
                        Text("가져오기")
                            .font(.title3)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("오전과 오후")
                }.tag(1)
                
                VStack {
                    TimeView(timeData: timeData)
                    
                    Button(action: {
                        requestPermission()
                    }) {
                        Text("가져오기")
                            .font(.title3)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .tabItem {
                    Image(systemName: "hourglass")
                    Text("시간별")
                }.tag(2)

                VStack {
                    Text("실시간 걸음 수: \(realTimeStepCount)")
                        .font(.largeTitle)
                        .bold()
                    Text("실시간 이동 거리: \(realTimeDistance)m")
                        .font(.largeTitle)
                        .bold()
                    
                    Button(action: {
                        isMeasuring.toggle()
                        
                        if isMeasuring {
                            requestPermission()
                        } else {
                            stopRealTimeStepUpdates()
                        }
                    }) {
                        Text(isMeasuring ? "측정중..." : "시작하기")
                            .font(.title3)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .onAppear {
                    getInitialRealTimeStepCount() // 앱 시작 시 오늘 총 걸음 수 가져오기
                }
                .tabItem {
                    Image(systemName: "figure.walk")
                    Text("실시간")
                }.tag(3)

            }
        }
    }
    
    func displayText(for tab: Int) -> String {
        switch tab {
        case 0: return "오늘 총 데이터"
        case 1: return "오늘 오전과 오후 데이터"
        case 2: return "오늘 시간별 데이터"
        case 3: return "실시간 카운트"
        default: return "알 수 없는 탭"
        }
    }
    
    func requestPermission() {
        switch CMPedometer.authorizationStatus() {
        case .notDetermined:
            pedometer.queryPedometerData(from: Date(), to: Date()) { data, error in
                // 권한 요청: 사용자가 접근을 허용하면 이후 데이터 요청 가능
                self.getStepCount()
                self.getHalfDaySteps()
                getPeriodTimeSteps { data in
                    timeData = data // 데이터 업데이트
                }
                self.startRealTimeStepUpdates()
            }
        case .authorized:
            self.getStepCount()
            self.getHalfDaySteps()
            getPeriodTimeSteps { data in
                timeData = data // 데이터 업데이트
            }
            self.startRealTimeStepUpdates()
        case .denied:
            print("@@@거부됨")
        default:
            print("@@@디폴트")
        }
    }
    
    func getInitialRealTimeStepCount() {
        guard CMPedometer.authorizationStatus() == .authorized else {
            print("걸음 수 데이터를 가져오려면 권한이 필요합니다.")
            return
        }
        
        pedometer.queryPedometerData(from: Calendar.current.startOfDay(for: Date()), to: Date()) { data, error in
            if let stepData = data, error == nil {
                DispatchQueue.main.async {
                    initialRealTimeStepCount = stepData.numberOfSteps.intValue
                    initialRealTimeDistance = Int(stepData.distance?.doubleValue ?? 0)
                    realTimeStepCount = initialRealTimeStepCount // 실시간 카운트 초기값 설정
                    realTimeDistance = initialRealTimeDistance
                }
            } else {
                print("총 걸음 수 데이터를 가져오는 데 실패했습니다: \(error?.localizedDescription ?? "알 수 없는 오류")")
            }
        }
    }
    
    func startRealTimeStepUpdates() {
        guard CMPedometer.isStepCountingAvailable() else {
            print("걸음 수 추적을 사용할 수 없습니다.")
            return
        }

        pedometer.startUpdates(from: Date()) { data, error in
            if let stepData = data, error == nil {
                DispatchQueue.main.async {
                    realTimeStepCount = initialRealTimeStepCount + stepData.numberOfSteps.intValue // 초기 걸음 수 + 실시간 걸음 수
                    realTimeDistance = initialRealTimeDistance + Int(stepData.distance?.doubleValue ?? 0)
                }
            } else {
                print("실시간 걸음 수 데이터를 가져오는 데 실패했습니다: \(error?.localizedDescription ?? "알 수 없는 오류")")
            }
        }
    }
    
    func stopRealTimeStepUpdates() {
        pedometer.stopUpdates() // 실시간 걸음 수 업데이트 중지
        print("실시간 걸음 수 업데이트 중지됨")
    }
    
    func getPeriodTimeSteps(completion: @escaping ([String: (steps: Int, distance: Int)]) -> Void) {
        let calendar = Calendar.current
        let today = Date()

        let timeRanges = [
            ("새벽(0, 5)", 0, 5),
            ("아침(6, 11)", 6, 11),
            ("점심(12, 17)", 12, 17),
            ("저녁(18, 21)", 18, 21),
            ("밤(22, 23)", 22, 23)
        ]

        var results: [String: (steps: Int, distance: Int)] = [:]
        let dispatchGroup = DispatchGroup()

        for (label, startHour, endHour) in timeRanges {
            dispatchGroup.enter()

            let startTime = calendar.date(bySettingHour: startHour, minute: 0, second: 0, of: today)!
            let endTime = calendar.date(bySettingHour: endHour, minute: 59, second: 59, of: today)!

            getSteps(for: startTime, endTime: endTime) { steps, distance in
                results[label] = (steps ?? 0, distance ?? 0)
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(results)
        }
    }
    
    
    func getHalfDaySteps() {
        let calendar = Calendar.current
        let today = Date()

        // 오전 (00:00 ~ 12:00)
        let morningStart = calendar.startOfDay(for: today)
        let morningEnd = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: today)!

        getSteps(for: morningStart, endTime: morningEnd) { morningSteps, morningDistance in
            print("오전 걸음 수: \(morningSteps ?? 0)")
            print("오전 거리: \(morningDistance ?? 0)")
            self.morningSteps = morningSteps ?? 0
            self.morningDistance = morningDistance ?? 0
        }

        // 오후 (12:00 ~ 23:59)
        let afternoonStart = morningEnd
        let afternoonEnd = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: today)!

        getSteps(for: afternoonStart, endTime: afternoonEnd) { afternoonSteps, afternoonDistance in
            print("오후 걸음 수: \(afternoonSteps ?? 0)")
            print("오후 거리: \(afternoonDistance ?? 0)")
            self.afternoonSteps = afternoonSteps ?? 0
            self.afternoonDistance = afternoonDistance ?? 0
        }
    }
    
    func getStepCount() {
        guard CMPedometer.authorizationStatus() == .authorized else {
            print("걸음 수 데이터를 가져오려면 권한이 필요합니다.")
            
            return
        }
        
        pedometer.queryPedometerData(from: Calendar.current.startOfDay(for: Date()), to: Date()) { data, error in
            if let stepData = data, error == nil {
                print("@@@이동거리(미터): ", stepData.distance?.doubleValue ?? 0)
                print("@@@걸음수(걸음): ", stepData.numberOfSteps.intValue)
                
                stepCount = stepData.numberOfSteps.intValue
                distance = Int(stepData.distance?.doubleValue ?? 0)
            } else {
                print("걸음 수 데이터를 가져오는 데 실패했습니다: \(error?.localizedDescription ?? "알 수 없는 오류")")
            }
        }
    }
    
    func getSteps(for startTime: Date, endTime: Date, completion: @escaping (Int?, Int?) -> Void) {
        guard CMPedometer.isStepCountingAvailable() else {
            print("디바이스가 걸음 수 추적을 지원하지 않습니다.")
            completion(nil, nil)
            return
        }

        pedometer.queryPedometerData(from: startTime, to: endTime) { data, error in
            if let stepData = data, error == nil {
                completion(stepData.numberOfSteps.intValue, Int(stepData.distance?.doubleValue ?? 0))
            } else {
                print("걸음 수 데이터를 가져오는 데 실패했습니다: \(error?.localizedDescription ?? "알 수 없는 오류")")
                completion(nil, nil)
            }
        }
    }
    
}

#Preview {
    ContentView()
}

struct TimeView: View {
    let timeData: [String: (steps: Int, distance: Int)]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())] // 2열 설정
    let sortedPeriods = ["새벽(0, 5)", "아침(6, 11)", "점심(12, 17)", "저녁(18, 21)", "밤(22, 23)"] // 원하는 순서 정의

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(sortedPeriods, id: \.self) { period in
                if let data = timeData[period] {
                    VStack {
                        Text(period)
                            .font(.title2)
                            .bold()
                        Text("걸음 수: \(data.steps)")
                        Text("이동 거리: \(data.distance)m")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}

