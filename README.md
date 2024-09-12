# Mental Math - 암산 연습

경시 시험, 공무원 시험 혹은 두뇌 회전을 위한 간단한 암산 앱입니다 :)
공시생들의 20단까지의 단수 연습 앱이 없어 아쉽다는 의견에서 시작했습니다.

- 덧셈, 뺄셈, 나눗셈, 곱셈은 모두 자리수 선택 가능한 랜덤 문제를 제공
- 곱셈 메뉴에는 특정 단수 연습 가능 (2 ~ 20단 제공)

### 배포 링크
[앱스토어] Mental Math - 암산 연습

 <a href="https://apps.apple.com/us/app/mental-math-%EC%95%94%EC%82%B0-%EC%97%B0%EC%8A%B5/id6670271755?itscg=30200&itsct=apps_box_badge&mttnsubad=6670271755" style="display: inline-block;">
 <img src="https://toolbox.marketingtools.apple.com/api/v2/badges/download-on-the-app-store/black/en-us?releaseDate=1725494400" alt="Download on the App Store" style="width: 200px; height: 50px; vertical-align: middle; object-fit: contain;" />
 </a>
    

## 목차
1. [앱 화면 소개](#앱-화면-소개)   
2. [구현 소개](#구현-소개)   
3. [트러블 슈팅](#트러블-슈팅)   

# 앱 화면 소개

| 시작 화면 | 곱셈 메뉴 화면 |
| --- | --- |
| <img src="https://github.com/user-attachments/assets/aa59b399-ca23-4e87-afbb-55fe2d56d1ab" alt="MainView" width="200"/> | <img src="https://github.com/user-attachments/assets/4eee46cc-5e34-4ad4-8554-57e2f7315f8f" alt="MulMenuView" width="200"/> |

| 곱셈 단수 선택 화면 | 문제 푸는 화면 | 
| --- | --- |
| <img src="https://github.com/user-attachments/assets/4d6d88e7-a392-4d29-a415-33ba935ffbab" alt="MulTableView" width="200"/> | <img src="https://github.com/user-attachments/assets/bc7edfe6-6f0a-4f42-8661-b520d8d4a912" alt="tabelCalculate" width="200"/> |

| 곱셈 랜덤 설정 화면 1 | 곱셈 랜덤 설정 화면 2 |  곱셈 랜덤 설정 화면 3 | 
| --- | --- | --- |
| <img src="https://github.com/user-attachments/assets/9567845c-cdb3-425c-a284-22c615cca959" alt="MulTableView" width="200"/> | <img src="https://github.com/user-attachments/assets/32f8ee24-0b34-4dbe-ba86-4b7d129cc453" alt="mulSet2" width="200"/> | <img src="https://github.com/user-attachments/assets/f9729f88-73dc-457c-9345-f8691c95b8ee" alt="mulSet2" width="200"/> |

# 구현 소개
## 설정
* 프레임워크: SwiftUI - iOS 버전 17.0
* 디자인 패턴: 싱글톤 패턴 (CalculateViewModel)

## 로직 설명
* 문제 생성 & 답 입력 같은 상호작용하는 뷰가 1개이기 때문에 CalculateViewModel 1개에 다 기능을 넣었다.    
* 곱셈에서의 단수 문제의 경우, 2-9단까지는 원래의 구구단처럼 최대 범위를 9까지 잡고, 10-20단은 최대 범위를 해당 단수까지 설정했다. Ex. 15단 - 랜덤 범위 (1~15)    
* 랜덤 문제의 경우, 왼쪽, 오른쪽 숫자의 자리수를 입력받아 그 자리수에 대한 랜덤 문제를 생성한다.

# 트러블 슈팅
## ISSUE 1: 나눗셈 로직

### 문제점
* 소수점 입력을 안받고, 나누어 떨어지는 수만 정답으로 나오게 문제를 설정했다.    
* 왼쪽(A), 오른쪽(B) 수의 자리수를 입력 받고 -> 랜덤 숫자를 생성 -> 대신, 나누어 떨어지는 문제를 생성할 것    
 나눗셈은 100 / 20 처럼 왼쪽이 큰수가 와야한다.    
 최소 공배수, 약수 등등을 이용해서 수를 생성해야하나 고민했지만 시간 복잡도도 복잡해지고 오래 걸린다고 생각해, 다른 방법을 선택했다.

### 해결책
 * A / B = C 의 식에서 "B * C = A" 이므로 이를 이용했다.
 * 몫만 남는 / 연산을 통해 C = 2 를 구한다.
 * B * C 의 결과값이, A에 와야할 자리수와 같다면 A = B * C 로 바꾼다.

 Ex. A = 103, B = 50 이라고 가정
 1. 103 / 50 = 2
 2. 50 * 2 = 100 => A = 100 으로 변경
 3. 문제 생성: 100 / 50 = ?

 만약 2번에서의 B * C 결과가 원하는 A의 자리수만큼 나올 수 있기 때문에 이 과정을 A의 자리수가 충족하는 수가 나올 때까지 진행한다.

## ISSUE 2: NavigationLink로 화면 전환과 동시에 액션을 취해주어야할 때
### 문제점  
NavigationLink로 화면 전환과 동시에 다른 액션을 취해주어야 했는데, 아래와 같이 했을 때 막혀서 답답했다.
  1. Navigation & Button의 조합이 되지 않는다. 
  NavigationLink - label에 Button 넣어보기 ⇒ X
  ```swift
  NavigationLink {
    MulMenuView()
  } label: {
      Button(action: {
          viewModel.op = "*"
          print(viewModel.op)
      }, label: {
          Text("×")
              .mainButtonStyle(height: screenHeight / 6, backgroundColor: Color.lightSkyBlue)
      })
  }
  ```
  위와 같이, NavigationLink의 label로 Button을 넣어 진행했지만, 버튼의 action인 print만 동작하고 NavigationLink 동작인 화면 전환은 안된다. 

  2. gesture 도 소용 없음 → TapGesture 만 기능하고, 마찬가지로 navigationLink가 되지 않는다.
  ```swift
  VStack {
        NavigationLink(destination: DetailView()) {
            Text("Tap me to go to Detail View")
        }
        .gesture(
            TapGesture().onEnded {
                print("Label tapped")
            }
        )
    }
  ```
  이후에도 여러가지로 시도해봤지만, NavigationLink의 Label 자체에도 Tap gesture가 입혀져있기 때문에, Button, another gesture가 주어지면 둘 중에 1개만 수행되게 된다. 

### 해결책   
NavigationStack - path를 이용해, Router 클래스를 구현해서 router.pop(), router.push()를 와 같은 함수를 미리 구현해놓는다. 
* Router를 EnvironmentObject로 선언시켜 모든 뷰에서 사용 가능하도록 한다.
* 아래와 같이, router를 이용해 Button에서 navigate & 원하는 action 모두 사용 가능하다.
```swift
Button(action: {
    viewModel.op = Operator.add
    router.navigate(to: .mulrandom)
}, label: {
    Text("+")
        .mainButtonStyle(height: screenHeight / 6, backgroundColor: Color.hintBackground)
})
```





