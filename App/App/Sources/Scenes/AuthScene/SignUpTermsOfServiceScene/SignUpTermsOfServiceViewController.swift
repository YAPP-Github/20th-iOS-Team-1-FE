//
//  SignUpTermsOfServiceViewController.swift
//  App
//
//  Created by Hani on 2022/07/01.
//

import UIKit

final class SignUpTermsOfServiceViewController: UIViewController {
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    
    private lazy var guidanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .Togaether.primaryLabel
        label.text = "투개더(Togaether)\n서비스 이용약관"
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var guideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private lazy var guideView1 = GuideView(title: "제1조 (목적)", guide: """
    이 약관은 투개더 운영진(이하 “제공자”)이 제공하는 '투개더(Togaether)' 서비스를 이용함에 있어 운영진과 회원 간의 권리, 의무 및 책임사항과 절차 등을 정하기 위해 만들어졌습니다.
    """)
    
    private lazy var guideView2 = GuideView(title: "제2조 (정의)", guide: """
    이 약관에서는 용어를 다음과 같이 정의하여 사용합니다.
    "서비스"란 회원의 단말기(모바일, 태블릿PC 등 각종 유/무선 장치를 포함)를 통하여 제공자가 제공하는 '투개더(Togaether)' 서비스 일체를 말합니다.
    "회원"이란 서비스에 접속하여 이 약관에 따라 제공자와 이용계약을 체결함으로써 서비스를 이용하는 고객을 말합니다.
    "닉네임"이란 회원의 식별과 서비스 제공을 위하여 회원이 정하고 제공자가 승인한 문자와 숫자의 조합입니다.
    "포인트"란 본 약관 제12조에 따라 회원이 일정한 행위를 마친 때에 시스템에 적립되는 서비스 상의 데이터입니다.
    "제휴 컨텐츠"란 제공자가 외부 업체와의 제휴를 통하여 회원에게 제공하는 유/무상의 컨텐츠를 말합니다.
    """)
    
    private lazy var guideView3 = GuideView(title: "제3조 (약관의 게시와 개정)", guide: """
    본 약관은 회원의 쉬운 인지를 위해 회원가입 절차 중 첫 번째 단계에 게시합니다. 추후 약관을 조회하고자 하는 사용자는 이메일을 통해 제공자에게 문의하여 약관을 조회할 수 있습니다.
    제공자는 필요에 따라 “약관의 규제에 관한 법률”, “정보통신망 이용촉진 및 정보보호 등에 관한 법률” 등 관련 법령을 위반하지 않는 범위 내에서 본 약관을 개정할 수 있습니다.
    제공자가 약관을 개정하는 경우 적용 일자 및 개정 사항을 명시하여 적용일 14일 전에 이메일을 통해 공지합니다.
    공지일로부터 14일 이내에 회원이 명시적으로 거부하지 않는 경우 개정 약관에 동의한 것으로 봅니다.
    회원이 개정에 동의하지 않는다는 의사를 표시한 경우 제공자는 개정된 약관을 적용할 수 없으며, 회원은 개정 약관의 효력 발생일부터 서비스를 이용하실 수 없습니다.
    """)
    private lazy var guideView4 = GuideView(title: "제4조 (약관의 해석)", guide: """
    이 약관에서 정하지 않은 사항이나 해석에 대하여는 관련 법령 또는 상관례에 따릅니다.
    제공자는 투개더 내부의 개별 서비스에 대해 별도의 이용약관 또는 정책(이하 "별도약관")을 둘 수 있으며, 그 내용이 이 약관과 충돌하는 경우 별도의 약관이 우선하여 적용됩니다.
    """)
    private lazy var guideView5 = GuideView(title: "제5조 (이용계약의 체결)", guide: """
    서비스 이용 계약은 회원이 되고자 하는 사람(이하 “가입신청자”)이 약관에 동의하고 가입을 신청한 다음 제공자가 이를 수락함으로써 체결됩니다. 필요한 경우 제공자는 본인확인 기관을 통한 실명확인 및 본인인증을 요청할 수 있습니다.
    가입신청자는 가입신청 시 진실한 정보를 기재하여야 하며, 허위의 정보를 기재함으로 인한 불이익 및 법적 책임은 가입신청자 본인에게 있습니다.
    만 14세 미만은 회원이 될 수 없습니다.
    가입신청자가 이전에 회원자격을 상실한 적이 있는 경우, 허위의 명의 또는 타인의 명의를 이용한 경우, 기타 승낙이 불가능한 사유가 있는 경우 가입이 거부될 수 있습니다.
    제공자는 서비스 관련 설비의 여유 기타 기술상 또는 업무상의 이유로 승낙을 유보할 수 있으며, 그 결과를 가입신청자에게 알려드립니다.
    """)
    private lazy var guideView6 = GuideView(title: "제6조 (회원정보의 변경)", guide: """
    회원은 서비스 내 마이 페이지 화면을 통하여 본인의 개인정보를 열람하고 수정할 수 있습니다. 단, 서비스 관리를 위하여 ID, 이메일 주소는 수정할 수 없습니다.
    가입신청 시에 기재한 회원정보에 변동이 생긴 경우 이를 수정하거나 제공자에 통지하여야 하며, 미수정 또는 통지하지 않음으로 인한 불이익에 대하여 제공자는 책임지지 않습니다.
    """)
    private lazy var guideView7 = GuideView(title: "제7조 (서비스 내용)", guide: """
    투개더 서비스(이하 "투개더")는 장소를 기반으로 반려견 모임을 생성하고 탐색, 참여할 수 있는 모바일 어플리케이션입니다.
    제공자가 회원에게 제공하는 투개더의 기본 내용은 다음과 같습니다.
    모임 찾기 : 주변에 생성된 반려견 모임 또는 원하는 조건에 맞는 모임을 탐색
    모임 참여 : 조건에 맞는 반려견 모임에 참여
    모임 생성 : 세부 참여 조건을 설정하여 반려견 모임을 생성
    광고: 광고 이미지, 텍스트, 음향, 링크 등의 제공
    컨텐츠 이용: 제공자가 제공하는 컨텐츠 이용, 구매 가능
    이벤트 등 제공자가 개발하거나 다른 제공자와의 제휴를 통해 회원에게 제공하는 기타의 서비스
    회원은 보다 상세한 서비스 내용을 이메일을 통해 문의할 수 있습니다.
    제공자는 타겟팅 광고 서비스 특성 상 광고주의 요구에 따라, 또는 관련법규 준수를 위하여 일부 서비스를 이용할 수 있는 회원의 범위를 다르게 정할 수 있습니다.
    제공자는 원활한 서비스 제공을 위하여 회원에게 이메일, SMS, Push알림창을 통한 광고 및 서비스 관련 정보를 제공할 수 있으며, 원치 않는 경우 회원은 언제든지 수신거부 할 수 있습니다.
    회원의 스마트폰 잠금 시에도 어플리케이션이 실행될 수 있으며, 잠금 화면에서 회원에게 광고와 컨텐츠가 Push알림창 형식으로 노출될 수 있습니다.
    회원이 스마트폰 잠금 시 어플리케이션이 실행되는 것을 원치 않을 경우 서비스 사용 중 설정 메뉴에서 ‘잠금화면 사용하기’ 설정을 해제 할 수 있습니다.
    회원이 Push알림창 사용을 원하지 않을 경우 본 조 제6항과 동일한 방법으로 설정 해제 할 수 있습니다.
    """)
    private lazy var guideView8 = GuideView(title: "제8조 (서비스의 변경)", guide: """
    제공자는 운영상, 기술상의 필요에 따라 제공하는 서비스의 전부 또는 일부를 변경할 수 있으며, 이에 대하여 약관에 다른 규정이 없는 한 회원에게 별도의 보상을 하지는 않습니다.
    서비스를 변경하는 경우 변경사유 및 일자, 변경내용을 변경 14일 전 공지사항 게시판에 공지합니다. 단, 변경사유 또는 내용을 구체적으로 공지하기 어려운 경우에는 그 이유를 밝힙니다.
    """)
    private lazy var guideView9 = GuideView(title: "제9조 (서비스의 일시 중단)", guide: """
    제공자는 서비스관련설비 보수점검, 교체 및 고장, 통신두절 등 기술상 업무상의 이유로 서비스의 제공을 일시적으로 중단할 수 있습니다. 이 경우 사전에 통지함을 원칙으로 하지만, 부득이한 사유가 있는 경우 사후에 통지할 수 있습니다.
    서비스 일시 중단은 이메일 또는 서비스 내 공지사항, 서비스 웹사이트에 게시하는 방법으로 통지합니다.
    중단으로 인하여 회원이 손실을 입은 경우 제공자는 통상적으로 예상 가능한 범위 내에서 보상할 수 있습니다. 단, 천재지변 등 불가항력에 의한 경우에는 보상하지 않습니다.
    """)
    private lazy var guideView10 = GuideView(title: "제10조 (회원의 계약해지, 이용 중지 요청 등)", guide: """
    회원은 언제든지 이메일을 통하여 서비스 이용계약 해지를 신청할 수 있으며 제공자는 이를 즉시 처리합니다.
    위의 해지 시, 회원의 개인정보는 제공자의 “개인정보취급방침”에 따라 파기됩니다.
    해지로 인하여 회원에게 발생하는 손해에 대해 제공자는 책임지지 않습니다.
    회원은 이메일 통보 등 정해진 절차를 거쳐 서비스의 이용 중지를 요청할 수 있습니다.
    """)
    private lazy var guideView11 = GuideView(title: "제11조 (제공자의 계약해지, 이용제한 등)", guide: """
    제공자는 다음의 경우 사전통보 없이 해당 회원과의 이용계약을 해지하여 회원 자격을 상실시킬 수 있습니다.
    회원 및 반려견이 사망한 경우
    타인의 개인정보 또는 모바일 기기를 도용한 경우
    회원이 가입 시 작성한 개인정보가 허위임이 밝혀진 경우
    포인트를 부정한 방법으로 적립하거나 사용한 경우
    다른 회원의 서비스 이용을 방해하는 등 전자거래질서를 위협하는 경우
    서비스 외에서 제공자, 운영자, 임직원 등을 사칭하는 경우
    무단으로 제공자의 클라이언트 프로그램을 변경하거나 서버를 해킹하는 등 시스템을 위협한 경우
    허위사실 유포, 위계 기타 방법으로 제공자의 명예 또는 신용을 훼손하거나 업무를 방해한 경우
    서비스에 관한 스팸성 활동을 하는 경우
    기타 본 약관상의 의무 또는 법령에 위반되는 행위를 한 경우
    제공자는 위의 사유가 있는 경우 자격상실 대신 이용의 제한을 가할 수 있습니다.
    """)
    private lazy var guideView12 = GuideView(title: "제12조 (회원ID 및 비밀번호)", guide: """
    회원ID와 비밀번호에 관한 관리책임은 회원 본인에게 있으며, 회원은 제3자에게 자신의 ID및 비밀번호를 알려주거나 이용하게 해서는 안됩니다.
    회원이 자신의 ID 또는 비밀번호를 도난 당하거나 제3자가 사용하고 있음을 인지한 경우 즉시 제공자에 통지하고 제공자의 안내를 따라야합니다.
    제2항의 경우 제공자에 통지하지 않거나, 안내에 따르지 않아 발생한 불이익에 대하여 제공자는 책임지지 않습니다.
    """)
    private lazy var guideView13 = GuideView(title: "제13조 (제공자의 의무)", guide: """
    제공자는 관련 법령 또는 이 약관을 위반하지 않으며, 계속적이고 안정적으로 서비스를 제공하기 위하여 최선을 다합니다.
    제공자는 신용정보를 포함한 회원의 개인정보 보호를 위하여 보안시스템을 갖추어야 하며 개인정보취급방침을 공시하고 준수하겠습니다.
    제공자는 서비스 이용과 관련한 회원의 의견이나 불만사항 등이 정당하다고 인정할 경우 이를 처리하여야 합니다. 처리된 결과는 이메일을 통해 회원에게 통보합니다.
    """)
    private lazy var guideView14 = GuideView(title: "제14조 (회원의 의무)", guide: """
    회원은 서비스 이용과 관련하여 다음의 행위를 하여서는 안됩니다.
    서비스 이용 관련 제반 신청 및 변경 행위 시 허위 내용의 등록
    서비스 내 게시된 각종 정보의 무단 변경, 삭제 등 훼손
    일체의 가공 행위를 통해 서비스를 분해, 변경, 모방하는 행위
    제공자 기타 제3자의 지적재산권을 포함하여 권리를 침해하는 행위
    다른 회원의 개인정보 수집하거나 명예를 손상하는 행위
    제공자의 동의 없이 광고를 전송하거나 외설, 폭력적인 정보 등을 노출하는 행위
    기타 약관 상의 의무를 불이행하는 행위
    기타 불법, 부당한 행위
    """)
    private lazy var guideView15 = GuideView(title: "제15조 (저작권의 귀속 및 이용제한)", guide: """
    제공자의 상표, 로고, 제공하는 서비스 및 광고 내용에 관한 지적재산권 등의 권리는 제공자에 귀속합니다.
    회원은 서비스를 이용함으로써 얻은 정보를 제공자의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 및 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하도록 하여서는 안됩니다.
    """)
    private lazy var guideView16 = GuideView(title: "제16조 (서비스 관련 분쟁 해결)", guide: """
    제공자는 서비스 이용과 관련한 회원의 의견이나 불만사항을 신속하게 처리합니다. 단, 신속한 처리가 곤란한 경우에는 그 사유와 처리일정을 통보하여 드립니다.
    제공자와 회원간에 발생한 분쟁은 전자거래기본법에 의해 설치된 전자거래분쟁 조정위원회의 조정절차에 의해 해결할 수 있습니다.
    """)
    private lazy var guideView17 = GuideView(title: "제17조 (서비스의 종료)", guide: """
    제공자는 서비스를 종료하고자 하는 날로부터 3개월 이전에 이 약관 제3조 3항의 방법으로 회원에게 알립니다.
    서비스 종료 통지일 현재 기 적립된 포인트는 서비스 종료일까지 본 약관이 정하는 바에 따라 소진하셔야 하며, 서비스 종료일 이후로는 자동 소멸되어 회원은 포인트에 관한 권리를 주장하실 수 없습니다.
    종료 통지일로부터 서비스 종료일까지 서비스의 일부가 제한될 수 있습니다.
    """)
    private lazy var guideView18 = GuideView(title: "제18조 (준거법 및 합의 관할)", guide: """
    제공자와 회원간에 제기된 법적 분쟁은 대한민국 법을 준거법으로 합니다.
    제공자와 회원간의 분쟁에 관한 소송은 서울중앙지방법원 또는 민사소송법 상의 관할법원에 제소합니다.
    """)
    private lazy var guideView19 = GuideView(title: "제19조 (개인정보보호의무)", guide: """
    제공자는 관련 법령이 정하는 바에 따라서 회원 등록정보를 포함한 개인정보를 보호하기 위하여 노력합니다. 이에 관해서는 관련 법령 및 제공자의 ‘개인정보취급방침’에 의하며, 확인을 원하는 회원은 이메일 문의를 통하여 언제든 확인할 수 있습니다.
    """)
    private lazy var guideView20 = GuideView(title: "부칙", guide: """
    이 약관은 2022년 07월 30일부터 적용됩니다.
    """)
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureLayout()
        configureUI()
    }

    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(guidanceLabel)
        contentView.addSubview(guideStackView)
        
        guideStackView.addArrangedSubview(guideView1)
        guideStackView.addArrangedSubview(guideView2)
        guideStackView.addArrangedSubview(guideView3)
        guideStackView.addArrangedSubview(guideView4)
        guideStackView.addArrangedSubview(guideView5)
        guideStackView.addArrangedSubview(guideView6)
        guideStackView.addArrangedSubview(guideView7)
        guideStackView.addArrangedSubview(guideView8)
        guideStackView.addArrangedSubview(guideView9)
        guideStackView.addArrangedSubview(guideView10)
        guideStackView.addArrangedSubview(guideView11)
        guideStackView.addArrangedSubview(guideView12)
        guideStackView.addArrangedSubview(guideView13)
        guideStackView.addArrangedSubview(guideView14)
        guideStackView.addArrangedSubview(guideView15)
        guideStackView.addArrangedSubview(guideView16)
        guideStackView.addArrangedSubview(guideView17)
        guideStackView.addArrangedSubview(guideView18)
        guideStackView.addArrangedSubview(guideView19)
        guideStackView.addArrangedSubview(guideView20)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),
            
            guidanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            guidanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            guideStackView.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 24),
            guideStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            guideStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            guideStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
    }
}
