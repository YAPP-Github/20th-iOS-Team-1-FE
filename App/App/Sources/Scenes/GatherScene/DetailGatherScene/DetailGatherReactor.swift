//
//  DetailGatherReactor.swift
//  App
//
//  Created by Hani on 2022/07/04.
//

import Foundation

import ReactorKit
import RxSwift

final class DetailGatherReactor: Reactor {
    enum Action {
        case viewWillAppear
        case clubReportDidOccur
        case clubQuitDidOccur
        case clubDeleteDidOccur
        case commentReportDidOccur(Int)
        case commentDidOccur(String)
        case participantDidTap(Int)
        case textFieldDidEndEditing(String)
        case addCommentButtonDidTap
        case gatherButtonDidTap
    }
    
    enum Mutation {
        case updateDetailGather(ClubFindDetail)
        case updateCommentReportSuccess(Bool)
        case updateClubReportSuccess(Bool)
        case updateTextFieldComment(String)
        case empty
    }
    
    struct State {
        let clubID: Int
        var textFieldComment = ""
        var isClubReportSuccess = 0
        var isCommentReportSuccess = false
        
        var gatherButtonText = ""
        var gatherButtonState = GatherButtonState.disabled
        
        var clubFindDetail: ClubFindDetail?
    }
    
    let initialState: State
    private let disposeBag = DisposeBag()
    private let detailGatherRepository: DetailGatherRepositoryInterface
    private let profileMainRepository: ProfileMainRepositoryInterface
    private let keychainUseCase: KeychainUseCaseInterface
    internal var readyToProfile = PublishSubject<String>()
    internal var readyToDismiss = PublishSubject<Void>()
    init(clubID: Int, detailGatherRepository: DetailGatherRepositoryInterface, profileMainRepository: ProfileMainRepositoryInterface, keychainUseCase: KeychainUseCaseInterface) {
        initialState = State(clubID: clubID)
        self.detailGatherRepository = detailGatherRepository
        self.profileMainRepository = profileMainRepository
        self.keychainUseCase = keychainUseCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return getGatherDetail(clubID: currentState.clubID)
        case .clubReportDidOccur:
            return reportClub(clubID: currentState.clubID)
        case .commentReportDidOccur(_):
            return reportComment(commentID: -1)
        case .commentDidOccur(_):
            return Observable.empty()
        case .participantDidTap(let id):
            guard let index = currentState.clubFindDetail?.accountInfos.firstIndex(where: { $0.id == id }),
                  let nickname = currentState.clubFindDetail?.accountInfos[safe: index]?.nickname else {
                return Observable.empty()
            }
            readyToProfile.onNext(nickname)
            return Observable.empty()
        case .addCommentButtonDidTap:
            let commentRequest = CommentRequest(clubID: currentState.clubID, content: currentState.textFieldComment)
            return addComment(comment: commentRequest)
        case .gatherButtonDidTap:
            return participateGather(clubID: currentState.clubID)
        case .textFieldDidEndEditing(let comment):
            return Observable.just(.updateTextFieldComment(comment))
        case .clubQuitDidOccur:
            return leaveClub(clubID: currentState.clubID)
        case .clubDeleteDidOccur:
            return deleteClub(clubID: currentState.clubID)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateDetailGather(let clubFindDetail):
            if let endDate = clubFindDetail.clubDetailInfo.endDate.toDate(),
               Date().isFuture(than: endDate) {
                newState.gatherButtonState = .disabled
                newState.gatherButtonText = "종료된 모임이에요."
            } else if clubFindDetail.leader {
                newState.gatherButtonState = .warning
                newState.gatherButtonText = "모임을 삭제할래요."
            } else if clubFindDetail.participating {
                newState.gatherButtonState = .warning
                newState.gatherButtonText = "모임을 나갈래요."
            } else if clubFindDetail.clubDetailInfo.maximumPeople <= clubFindDetail.clubDetailInfo.participants {
                newState.gatherButtonState = .disabled
                newState.gatherButtonText = "꽉찬 방이에요."
            } else if clubFindDetail.clubDetailInfo.eligibleSex == "ALL" ||
                   clubFindDetail.accountSex == clubFindDetail.clubDetailInfo.eligibleSex {
                newState.gatherButtonState = .enabled
                newState.gatherButtonText = "참여할래요."
            } else if clubFindDetail.clubDetailInfo.eligibleSex == "WOMAN" {
                newState.gatherButtonState = .disabled
                newState.gatherButtonText = "여성 견주만 참여할 수 있어요."
            } else {
                newState.gatherButtonState = .disabled
                newState.gatherButtonText = "남성 견주만 참여할 수 있어요."
            }
            
            newState.clubFindDetail = clubFindDetail
        case .updateCommentReportSuccess(let isSuccess):
            newState.isCommentReportSuccess = isSuccess
        case .updateClubReportSuccess(_):
            newState.isClubReportSuccess += 1
        case .updateTextFieldComment(let comment):
            newState.textFieldComment = comment
        case .empty:
            print("dismiss")
        }
        return newState
    }
    
    private func getGatherDetail(clubID: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.detailGatherRepository.requestDetailGather(accessToken: token, clubID: clubID)
                        .subscribe { result in
                        switch result {
                        case .success(let clubFindDetail):
                            observer.onNext(Mutation.updateDetailGather(clubFindDetail))
                        case .failure(let error):
                            print("RESULT FAILURE: ", error.localizedDescription)
                        }
                    }.disposed(by: self.disposeBag)
                },
                onFailure: { _,_ in
                     return
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func participateGather(clubID: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.detailGatherRepository.participateGather(accessToken: token, clubID: clubID)
                        .subscribe { result in
                        switch result {
                        case .success(_):
                            this.detailGatherRepository.requestDetailGather(accessToken: token, clubID: clubID)
                                .subscribe { result in
                                    switch result {
                                    case .success(let clubFindDetail):
                                        observer.onNext(Mutation.updateDetailGather(clubFindDetail))
                                    case .failure(let error):
                                        print("RESULT FAILURE: ", error.localizedDescription)
                                    }
                                }
                        case .failure(let error):
                            print("RESULT FAILURE: ", error.localizedDescription)
                        }
                    }.disposed(by: self.disposeBag)
                },
                onFailure: { _,_ in
                     return
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func addComment(comment: CommentRequest) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.detailGatherRepository.addComment(accessToken: token, comment: comment)
                        .subscribe { result in
                        switch result {
                        case .success(let clubFindDetail):
                            observer.onNext(Mutation.updateDetailGather(clubFindDetail))
                        case .failure(let error):
                            print("RESULT FAILURE: ", error.localizedDescription)
                        }
                    }.disposed(by: self.disposeBag)
                },
                onFailure: { _,_ in
                     return
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func reportClub(clubID: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.detailGatherRepository.reportClub(accessToken: token, clubID: clubID)
                        .subscribe { result in
                        switch result {
                        case .success(let isSuccess):
                            this.readyToDismiss.onNext(())
                            observer.onNext(Mutation.updateClubReportSuccess(isSuccess))
                        case .failure(_):
                            observer.onNext(Mutation.updateClubReportSuccess(true))
                        }
                    }.disposed(by: self.disposeBag)
                },
                onFailure: { _,_ in
                     return
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func deleteClub(clubID: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.detailGatherRepository.deleteClub(accessToken: token, clubID: clubID)
                        .subscribe { result in
                        switch result {
                        case .success(_):
                            this.readyToDismiss.onNext(())
                            observer.onNext(.empty)
                        case .failure(let error):
                            print("RESULT FAILURE: ", error.localizedDescription)
                        }
                    }.disposed(by: self.disposeBag)
                },
                onFailure: { _,_ in
                     return
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func leaveClub(clubID: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.detailGatherRepository.leaveClub(accessToken: token, clubID: clubID)
                        .subscribe { result in
                        switch result {
                        case .success(_):
                            this.readyToDismiss.onNext(())
                            observer.onNext(.empty)
                        case .failure(let error):
                            print("RESULT FAILURE: ", error.localizedDescription)
                        }
                    }.disposed(by: self.disposeBag)
                },
                onFailure: { _,_ in
                     return
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func reportComment(commentID: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.detailGatherRepository.reportComment(accessToken: token, commentID: commentID)
                        .subscribe { result in
                        switch result {
                        case .success(let isSuccess):
                            observer.onNext(Mutation.updateCommentReportSuccess(isSuccess))
                        case .failure(let error):
                            print("RESULT FAILURE: ", error.localizedDescription)
                        }
                    }.disposed(by: self.disposeBag)
                },
                onFailure: { _,_ in
                     return
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
}

private extension Date {
    func isFuture(than fromDate: Date) -> Bool {
        var result: Bool = false
        let comparisonResult: ComparisonResult = compare(fromDate)
        switch comparisonResult {
        case .orderedAscending:
            result = false
            break

        default:
            result = true
            break
        }
        return result
    }
}
