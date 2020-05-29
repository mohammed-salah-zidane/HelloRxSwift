import UIKit
import RxSwift
import RxCocoa

var str = "Hello, playground"
let obs = Observable.just(3)

let obs1 = Observable.of([1,5,6,7])
let obs2 = Observable.from([4,5,52,1])

obs1.subscribe{ event in
    if let element = event.element {
        print(element)
    }
}.dispose()


let disposBag = DisposeBag()
obs2.subscribe(onNext: { element  in
    print(element)
    }).disposed(by: disposBag)

Observable<String>.create({ observer in
    
    observer.onNext("Next")
    observer.onCompleted()
    observer.onNext("?")
    return Disposables.create()
}).subscribe(onNext: {print($0)}, onError: {print($0)}, onCompleted: {print("completed")}, onDisposed: {print("disposed")}).disposed(by: disposBag)



let subject = PublishSubject<String>()

subject.onNext("issue 1")

subject.subscribe({event in
    print(event.element)
})
subject.onNext("issue 2")
subject.onNext("issue 3")
subject.onNext("issue 4")
subject.onCompleted()
subject.onNext("issue 5")
let behaviorSubject = BehaviorSubject(value: "init value")

behaviorSubject.onNext("yes")
behaviorSubject.subscribe({ event in
    print(event)
})
behaviorSubject.onNext("no")
behaviorSubject.dispose()

let replaySubject = ReplaySubject<String>.create(bufferSize: 3)
replaySubject.onNext("issue 10")
replaySubject.onNext("issue 20")
replaySubject.onNext("issue 30")
replaySubject.onNext("issue 40")
replaySubject.onNext("issue 50")

replaySubject.subscribe({ event in
    print(event)
})
print("==========================")
replaySubject.onNext("issue 60")
replaySubject.onNext("issue 70")
replaySubject.onNext("issue 80")
replaySubject.onNext("issue 90")
replaySubject.dispose()

print("==========================\n")

let variable = Variable([String]())
variable.value.append("hello")
variable.asObservable().subscribe({
    print($0)
})
variable.value.append("variable subject")

let relay = BehaviorRelay(value: "behavior relay")
relay.asObservable().subscribe({
    print($0)
})
relay.accept("new value")
let r = BehaviorRelay<[String]>(value: [])
