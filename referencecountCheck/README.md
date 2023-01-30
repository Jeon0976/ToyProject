### 메모: 
#### weak self를 언제 사용하는가?
- escaping closures 안에서 지연할당의 가능성이 있는 경우 (API 비동기 데이터 처리, 타이머 등)
- 클로저가 객체에 대한 지연 deallocation 가능성이 있는 경우
    - *escaping closures가 아닌 일반 클로저에서는 Scope 안에서 즉시 실행되므로 Strong Reference Cycle을 유발하지 않으므로, weak self를 사용할 필요가 없다.* 
![400](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FMUIIz%2FbtrxWKjWwnb%2F8jhVDyEnkeN9iGhB5DP5NK%2Fimg.png)
- referencecountCheck을 활용한 지연할당 가능성 확인

#### Q
- weak self 적절한 사용 때는 언제인가? 
- AlertAction에는 escaping이 없어서 안 써도 되는건가?
- **count들어갈때 처음 1부터 시작하지 않던데 이유는 부모 클래스, scene클래스 등 때문인가??**

