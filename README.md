
# Xcode 템플릿 README

프로젝트와 팀이 성장하면서 다양한 문제들을 겪으며, 체계적이고 일관된 개발 환경의 필요성을 절실히 느꼈습니다. 특히, 다음과 같은 문제가 템플릿을 만들게 된 계기가 되었습니다.

1. **코드 스타일과 구조 불일치**  
   팀원마다 다른 코딩 스타일과 패턴을 사용해 코드베이스가 복잡해졌습니다.  
   - 상태 관리 방식이 통일되지 않아 코드 리뷰와 이해에 많은 시간이 소요되었습니다.  
   - 신규 팀원이 적응하는 데 평균 1주 이상의 시간이 필요했습니다.

2. **반복 작업으로 인한 비효율**  
   새로운 화면을 구현할 때 MVI 패턴 구조를 매번 수작업으로 작성해야 했습니다.  
   - **Model**, **Intent**, **View** 파일 생성과 초기 설정 작업에만 2~3시간이 소요되었습니다.  
   - 일부 작업이 누락되거나 불일치로 인해 런타임 에러가 발생하기도 했습니다.

3. **유지보수성 저하**  
   통일되지 않은 코드 구조로 인해 간단한 UI 변경에도 많은 수정이 필요했습니다.  
   - View와 로직이 결합되어 있어 작은 변경 작업에도 Model과 Intent를 함께 수정해야 했습니다.  
   - 유지보수 작업이 예상보다 2~3배 더 많은 시간이 걸렸습니다.

## 🧩 사용 예시

### 1. Model
- **역할**: 애플리케이션의 상태와 사용자 액션을 정의.
- **구성 요소**:
  - `State`: 애플리케이션의 상태를 나타내는 구조체.
  - `ViewAction`: 사용자 인터랙션 이벤트를 정의하는 열거형.

```swift
import Foundation

enum Model {
    struct State: Equatable {
        // 상태 정의
    }
    
    enum ViewAction: Equatable {
        // 액션 정의
    }
}
```

### 2. Intent
- **역할**: 상태 관리 및 사용자 액션 처리.
- **구성 요소**:
  - `@Published var state`: 상태 변경 시 UI와 연동.
  - `mutate(action:viewEffect:)`: 액션에 따라 상태를 변경하거나 부수 효과를 처리.
  - Combine을 활용하여 비동기 작업 및 상태 구독 관리.

```swift
import Foundation
import Combine

protocol IntentType {
    var state: Model.State { get }
    
    func send(action: Model.ViewAction)
}

final class Intent: ObservableObject {
    @Published var state: Model.State
    var cancellable: Set<AnyCancellable> = []

    init(initialState: Model.State) {
        self.state = initialState
    }

    func mutate(action: Model.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            break
        }
    }
}
```

### 3. View
- **역할**: UI 계층 구현.
- **구성 요소**:
  - `body`: SwiftUI 레이아웃 정의.
  - `.task`: 초기화 시 액션 호출.
  - `.build(intent:)`: View를 초기화하고 `UIViewController`로 변환.

```swift
import Foundation
import SwiftUI

struct View: IntentBindingType {
    @StateObject var container: Container<IntentType, Model.State>
    var intent: IntentType { self.container.intent }
    var state: Model.State { self.intent.state }

    var body: some View {
        VStack {
            // UI 컴포넌트 배치
        }
    }

    static func build(intent: Intent) -> UIViewController {
        return View(
            container: .init(
                intent: intent as IntentType,
                state: intent.state,
                modelChangePublisher: intent.objectWillChange
            )
        )
        .viewController
    }
}
```
