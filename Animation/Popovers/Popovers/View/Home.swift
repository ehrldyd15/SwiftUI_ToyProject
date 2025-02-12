//
//  Home.swift
//  Popovers
//
//  Created by Do Kiyong on 2023/02/17.
//

import SwiftUI

struct Home: View {
    // View Properties
    @State private var showPopover: Bool = false
    @State private var updateText: Bool = false
    
    var body: some View {
        VStack {
            HStack() {
                Spacer()
                
                Button("ToolTip") {
                    showPopover.toggle()
                }
                // 그냥 popover를 하면 시트처럼 보여진다.
                // popover는 맥OS나 iPadOS에서만 가능하니까 커스텀으로 해결해보자
                //        .popover(isPresented: $showPopover) {
                //            Text("Hello, it;s me, Popover.")
                //        }
                .iOSPopover(isPresented: $showPopover, arrowDirection: .up) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("성인 1일 권장 칼로리를 기준으로\nAI영양 다이어리 리포트 작성이 진행돼요.")
                            .foregroundColor(Color.black)
                        Text("성인 1일 권장량 2,000Kal")
                            .foregroundColor(Color.black)
                        Text("원하는 칼로릴 변경도 가능해요!")
                            .foregroundColor(Color.black)
                    }
                    .foregroundColor(.white)
                    .padding(15)
                    // Popover 전체에 컬러를 줄 수 있다.
//                    .background {
//                        Rectangle()
//                            .fill(.blue.gradient)
//                            .padding(-20)
//                    }
            }
        }
        
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// IOS에서 팝오버가 가능하게 해주는 extension
extension View {
    @ViewBuilder
    func iOSPopover<content: View>(isPresented: Binding<Bool>,
                                   arrowDirection: UIPopoverArrowDirection,
                                   @ViewBuilder content: @escaping () -> content) -> some View {
//        self
//            .background {
//                PopOverController(isPresented: isPresented, arrowDirection: arrowDirection, content: content())
//            }
        
        VStack {
            self
            PopOverController(isPresented: isPresented, arrowDirection: arrowDirection, content: content())
                .frame(height: 0)
            
                //.fixedSize() // PopOverController가 컨텐츠 크기에 맞는 정확한 크기를 유지하고, 외부 레이아웃 제약에 영향을 받지 않도록 한다.
        }
        
    }
}

// Popover Helper
struct PopOverController<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    
    var arrowDirection: UIPopoverArrowDirection
    var content: Content
    
    // View Properties
    @State private var alreadyPresented: Bool = false
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if alreadyPresented {
            // alreadyPresented가 변경될때 SwiftUI View를 업데이트 한다.
            if let hostingController = uiViewController.presentedViewController as? CustomHostingView<Content> {
                hostingController.rootView = content
                // 업데이트 될때마다 뷰 사이즈를 업데이트 한다.
                // 또한, SwiftUI View에서 원하는 크기대로 사이즈를 정의할 수 있다.
                hostingController.preferredContentSize = hostingController.view.intrinsicContentSize
            }
            // Close View, if it's toggled Back
            if !isPresented {
                // Closing Popover
                uiViewController.dismiss(animated: false) {
                    // Resetting alreadyPresented State
                    alreadyPresented = false
                }
            }
        } else {
            if isPresented {
                // Presenting Popover
                let controller = CustomHostingView(rootView: content)
                
                controller.view.backgroundColor = .clear
                controller.modalPresentationStyle = .popover
                controller.popoverPresentationController?.permittedArrowDirections = arrowDirection
                // Delegate 연결
                controller.presentationController?.delegate = context.coordinator
                // sourveView를 붙이면 정확한 위치로 방향을 잡을 것임
                controller.popoverPresentationController?.sourceView = uiViewController.view
                // Presenting PopOver Controller
                uiViewController.present(controller, animated: true)
            }
        }
    }
    
    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        var parent: PopOverController
        
        init(parent: PopOverController) {
            self.parent = parent
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
        // Popover의 상태를 observing
        // Popover가 해제되면 isPresented의 상태를 갱신한다.
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.isPresented = false
        }
        
        // Popover가 presented되면 alreadyPresented를 업데이트 한다.
        func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
            DispatchQueue.main.async {
                self.parent.alreadyPresented = true
            }
        }
    }
}

// SwiftUI 뷰 사이즈로 래핑을 하기 위함
class CustomHostingView<content: View>: UIHostingController<content> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredContentSize = view.intrinsicContentSize
        
    }
}
