//
//  SignUpPrivacyPolicyViewController.swift
//  App
//
//  Created by Hani on 2022/07/01.
//

import UIKit

final class SignUpPrivacyPolicyViewController: UIViewController {
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    
    private lazy var guidanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .Togaether.primaryLabel
        label.text = "투개더(Togaether)\n개인정보취급방침"
        label.numberOfLines = 0
        
        return label
    }()
    
    private var guideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private lazy var guideView1 = GuideView(title: "제1조(개인정보의 처리 목적)", guide: """
    < 투개더 (Togaether) >('https://yapp-togather.com/'이하 '투개더 (Togaether)')은(는) 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며 이용 목적이 변경되는 경우에는 「개인정보 보호법」 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.

    1. 홈페이지 회원가입 및 관리
    회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 서비스 부정이용 방지, 각종 고지·통지, 고충처리 목적으로 개인정보를 처리합니다.

    2. 민원사무 처리
    민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 목적으로 개인정보를 처리합니다.

    3. 재화 또는 서비스 제공
    서비스 제공, 콘텐츠 제공, 맞춤서비스 제공, 본인인증, 연령인증을 목적으로 개인정보를 처리합니다.

    4. 마케팅 및 광고에의 활용
    서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 처리합니다.
    """)
    
    private lazy var guideView2 = GuideView(title: "제2조(개인정보의 처리 및 보유 기간)", guide: """
    ① < 투개더 (Togaether) >은(는) 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.

    ② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.

    1.<홈페이지 회원가입 및 관리>
    <홈페이지 회원가입 및 관리>와 관련한 개인정보는 수집.이용에 관한 동의일로부터<5년>까지 위 이용목적을 위하여 보유.이용됩니다.
    보유근거 : 전자상거래 등에서의 소비자보호에 관한 법률
    관련법령 : 계약 또는 청약철회 등에 관한 기록 : 5년
    예외사유 :
    2.<민원사무 처리>
    <민원사무 처리>와 관련한 개인정보는 수집.이용에 관한 동의일로부터<3년>까지 위 이용목적을 위하여 보유.이용됩니다.
    보유근거 : 전자상거래 등에서의 소비자보호에 관한 법률
    관련법령 : 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
    예외사유 :
    3.<재화 또는 서비스 제공>
    <재화 또는 서비스 제공>와 관련한 개인정보는 수집.이용에 관한 동의일로부터<5년>까지 위 이용목적을 위하여 보유.이용됩니다.
    보유근거 : 전자상거래 등에서의 소비자보호에 관한 법률
    관련법령 : 대금결제 및 재화 등의 공급에 관한 기록 : 5년
    예외사유 :
    4.<마케팅 및 광고에의 활용>
    <마케팅 및 광고에의 활용>와 관련한 개인정보는 수집.이용에 관한 동의일로부터<6개월>까지 위 이용목적을 위하여 보유.이용됩니다.
    보유근거 : 전자상거래 등에서의 소비자보호에 관한 법률
    관련법령 : 표시/광고에 관한 기록 : 6개월
    예외사유 :
    """)
    
    private lazy var guideView3 = GuideView(title: "제3조(처리하는 개인정보의 항목)", guide: """
    ① < 투개더 (Togaether) >은(는) 다음의 개인정보 항목을 처리하고 있습니다.

    1< 홈페이지 회원가입 및 관리 >
    필수항목 : 이메일, 성별, 생년월일, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보, 기기고유번호(UDID 또는 IMEI)
    선택항목 :
    2< 재화 또는 서비스 제공 >
    필수항목 : 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보
    선택항목 : 반려견 정보, 단말기 위치 정보
    """)
    private lazy var guideView4 = GuideView(title: "제4조(만 14세 미만 아동의 개인정보 처리에 관한 사항)", guide: """
    ① <개인정보처리자명>은(는) 만 14세 미만 아동에 대해 개인정보를 수집할 때 법정대리인의 동의를 얻어 해당 서비스 수행에 필요한 최소한의 개인정보를 수집합니다.

    • 필수항목 : 법정 대리인의 성명, 관계, 연락처

    ② 또한, <개인정보처리자명>의 <처리목적> 관련 홍보를 위해 아동의 개인정보를 수집할 경우에는 법정대리인으로부터 별도의 동의를 얻습니다.

    ③ <개인정보처리자명>은(는) 만 1 4세 미만 아동의 개인정보를 수집할 때에는 아동에게 법정대리인의 성명, 연락처와 같이 최소한의 정보를 요구할 수 있으며, 다음 중 하나의 방법으로 적법한 법정대리인이 동의하였는지를 확인합니다.

    • 동의 내용을 게재한 인터넷 사이트에 법정대리인이 동의 여부를 표시하도록 하고 개인정보처리자가 그 동의 표시를 확인했음을 법정대리인의 휴대전화 문자 메시지로 알리는 방법

    • 동의 내용을 게재한 인터넷 사이트에 법정대리인이 동의 여부를 표시하도록 하고 법정대리인의 신용카드·직불카드 등의 카드정보를 제공받는 방법

    • 동의 내용을 게재한 인터넷 사이트에 법정대리인이 동의 여부를 표시하도록 하고 법정대리인의 휴대전화 본인인증 등을 통해 본인 여부를 확인하는 방법

    • 동의 내용이 적힌 서면을 법정대리인에게 직접 발급하거나, 우편 또는 팩스를 통하여 전달하고 법정대리인이 동의 내용에 대하여 서명날인 후 제출하도록 하는 방법

    • 동의 내용이 적힌 전자우편을 발송하여 법정대리인으로부터 동의의 의사표시가 적힌 전자우편을 전송받는 방법

    • 전화를 통하여 동의 내용을 법정대리인에게 알리고 동의를 얻거나 인터넷주소 등 동의 내용을 확인할 수 있는 방법을 안내하고 재차 전화 통화를 통하여 동의를 얻는 방법

    • 그 밖에 위와 준하는 방법으로 법정대리인에게 동의 내용을 알리고 동의의 의사표시를 확인하는 방법
    """)
    private lazy var guideView5 = GuideView(title: "제5조(개인정보의 파기절차 및 파기방법)", guide: """
    ① < 투개더 (Togaether) > 은(는) 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.

    ② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.
    1. 법령 근거 :
    2. 보존하는 개인정보 항목 : 계좌정보, 거래날짜

    ③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.
    1. 파기절차
    < 투개더 (Togaether) > 은(는) 파기 사유가 발생한 개인정보를 선정하고, < 투개더 (Togaether) > 의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.

    2. 파기방법

    전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.

    종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다
    """)
    private lazy var guideView6 = GuideView(title: "제6조(정보주체와 법정대리인의 권리·의무 및 그 행사방법에 관한 사항)", guide: """
    ① 정보주체는 투개더 (Togaether)에 대해 언제든지 개인정보 열람·정정·삭제·처리정지 요구 등의 권리를 행사할 수 있습니다.

    ② 제1항에 따른 권리 행사는투개더 (Togaether)에 대해 「개인정보 보호법」 시행령 제41조제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 투개더 (Togaether)은(는) 이에 대해 지체 없이 조치하겠습니다.

    ③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다.이 경우 “개인정보 처리 방법에 관한 고시(제2020-7호)” 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.

    ④ 개인정보 열람 및 처리정지 요구는 「개인정보 보호법」 제35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.

    ⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.

    ⑥ 투개더 (Togaether)은(는) 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.
    """)
    private lazy var guideView7 = GuideView(title: "제7조(개인정보의 안전성 확보조치에 관한 사항)", guide: """
    < 투개더 (Togaether) >은(는) 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.

    1. 정기적인 자체 감사 실시
    개인정보 취급 관련 안정성 확보를 위해 정기적(분기 1회)으로 자체 감사를 실시하고 있습니다.

    2. 개인정보 취급 직원의 최소화 및 교육
    개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.

    3. 접속기록의 보관 및 위변조 방지
    개인정보처리시스템에 접속한 기록을 최소 1년 이상 보관, 관리하고 있으며,다만, 5만명 이상의 정보주체에 관하여 개인정보를 추가하거나, 고유식별정보 또는 민감정보를 처리하는 경우에는 2년이상 보관, 관리하고 있습니다.
    또한, 접속기록이 위변조 및 도난, 분실되지 않도록 보안기능을 사용하고 있습니다.

    4. 개인정보에 대한 접근 제한
    개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.

    5. 비인가자에 대한 출입 통제
    개인정보를 보관하고 있는 물리적 보관 장소를 별도로 두고 이에 대해 출입통제 절차를 수립, 운영하고 있습니다.
    """)
    private lazy var guideView8 = GuideView(title: "제8조(개인정보를 자동으로 수집하는 장치의 설치·운영 및 그 거부에 관한 사항)", guide: """
    ① 투개더 (Togaether) 은(는) 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다.
    ② 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 저장되기도 합니다.
    가. 쿠키의 사용 목적 : 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다.
    나. 쿠키의 설치•운영 및 거부 : 웹브라우저 상단의 도구>인터넷 옵션>개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부 할 수 있습니다.
    다. 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.
    """)
    private lazy var guideView9 = GuideView(title: "제9조(행태정보의 수집·이용·제공 및 거부 등에 관한 사항)", guide: """
    ① <개인정보처리자>은(는) 서비스 이용과정에서 정보주체에게 최적화된 맞춤형 서비스 및 혜택, 온라인 맞춤형 광고 등을 제공하기 위하여 행태정보를 수집·이용하고 있습니다.

    ② <개인정보처리자>은(는) 다음과 같이 행태정보를 수집합니다.

    수집하는 행태정보의 항목 : 이용자의 앱 서비스 방문이력, 검색이력
    행태정보 수집 방법 : 이용자의 앱 방문/실행시 자동 수집
    행태정보 수집 목적 : 서비스 관리 목적
    보유·이용기간 및 이후 정보처리 방법 : 수집일로부터 1년 후 파기


    <온라인 맞춤형 광고 등을 위해 제3자(온라인 광고사업자 등)가 이용자의 행태정보를 수집·처리할수 있도록 허용한 경우>

    ③ <개인정보처리자>은(는) 다음과 같이 온라인 맞춤형 광고 사업자가 행태정보를 수집·처리하도록 허용하고 있습니다.

    - 행태정보를 수집 및 처리하려는 광고 사업자 : 없음

    - 행태정보 수집 방법 : 이용자가 당사 웹사이트를 방문하거나 앱을 실행할 때 자동 수집 및 전송

    - 수집·처리되는 행태정보 항목 : 이용자의 웹/앱 방문이력, 검색이력, 구매이력

    - 보유·이용기간 : -

    ④ <개인정보처리자>은(는) 온라인 맞춤형 광고 등에 필요한 최소한의 행태정보만을 수집하며, 사상, 신념, 가족 및 친인척관계, 학력·병력, 기타 사회활동 경력 등 개인의 권리·이익이나 사생활을 뚜렷하게 침해할 우려가 있는 민감한 행태정보를 수집하지 않습니다.

    ⑤ <개인정보처리자>은(는) 만 14세 미만임을 알고 있는 아동이나 만14세 미만의 아동을 주 이용자로 하는 온라인 서비스로부터 맞춤형 광고 목적의 행태정보를 수집하지 않고, 만 14세 미만임을 알고 있는 아동에게는 맞춤형 광고를 제공하지 않습니다.

    ⑥ <개인정보처리자>은(는) 모바일 앱에서 온라인 맞춤형 광고를 위하여 광고식별자를 수집·이용합니다. 정보주체는 모바일 단말기의 설정 변경을 통해 앱의 맞춤형 광고를 차단·허용할 수 있습니다.

    ‣ 스마트폰의 광고식별자 차단/허용

    (1) (안드로이드) ① 설정 → ② 개인정보보호 → ③ 광고 → ③ 광고 ID 재설정 또는 광고ID 삭제

    (2) (아이폰) ① 설정 → ② 개인정보보호 → ③ 추적 → ④ 앱이 추적을 요청하도록 허용 끔

    ※ 모바일 OS 버전에 따라 메뉴 및 방법이 다소 상이할 수 있습니다.

    ⑦ 정보주체는 웹브라우저의 쿠키 설정 변경 등을 통해 온라인 맞춤형 광고를 일괄적으로 차단·허용할 수 있습니다. 다만, 쿠키 설정 변경은 웹사이트 자동로그인 등 일부 서비스의 이용에 영향을 미칠 수 있습니다.

    ‣ 웹브라우저를 통한 맞춤형 광고 차단/허용

    (1) 인터넷 익스플로러(Windows 10용 Internet Explorer 11)

    - Internet Explorer에서 도구 버튼을 선택한 다음 인터넷 옵션을 선택

    - 개인 정보 탭을 선택하고 설정에서 고급을 선택한 다음 쿠키의 차단 또는 허용을 선택

    (2) Microsoft Edge

    - Edge에서 오른쪽 상단 ‘…’ 표시를 클릭한 후, 설정을 클릭합니다.

    - 설정 페이지 좌측의 ‘개인정보, 검색 및 서비스’를 클릭 후 「추적방지」 섹션에서 ‘추적방지’ 여부 및 수준을 선택합니다.

    - ‘InPrivate를 검색할 때 항상 ""엄격"" 추적 방지 사용’ 여부를 선택합니다.

    - 아래 「개인정보」 섹션에서 ‘추적 안함 요청보내기’ 여부를 선택합니다.

    (3) 크롬 브라우저

    - Chrome에서 오른쪽 상단 ‘⋮’ 표시(chrome 맞춤설정 및 제어)를 클릭한 후, 설정 표시를 클릭합니다.

    - 설정 페이지 하단에 ‘고급 설정 표시’를 클릭하고 「개인정보」 섹션에서 콘텐츠 설정을 클릭합니다.

    - 쿠키 섹션에서 ‘타사 쿠키 및 사이트 데이터 차단’의 체크박스를 선택합니다.

    52 | 개인정보 처리방침 작성지침 일반

    ⑧ 정보주체는 아래의 연락처로 행태정보와 관련하여 궁금한 사항과 거부권 행사, 피해 신고 접수 등을 문의할 수 있습니다.

    ‣ 개인정보 보호 담당자


    담당자 : 김준수

    연락처 : kjs55495543@naver.com
    """)
    private lazy var guideView10 = GuideView(title: "제10조(추가적인 이용·제공 판단기준)", guide: """
    < 투개더 (Togaether) > 은(는) ｢개인정보 보호법｣ 제15조제3항 및 제17조제4항에 따라 ｢개인정보 보호법 시행령｣ 제14조의2에 따른 사항을 고려하여 정보주체의 동의 없이 개인정보를 추가적으로 이용·제공할 수 있습니다.
    이에 따라 < 투개더 (Togaether) > 가(이) 정보주체의 동의 없이 추가적인 이용·제공을 하기 위해서 다음과 같은 사항을 고려하였습니다.
    ▶ 개인정보를 추가적으로 이용·제공하려는 목적이 당초 수집 목적과 관련성이 있는지 여부

    ▶ 개인정보를 수집한 정황 또는 처리 관행에 비추어 볼 때 추가적인 이용·제공에 대한 예측 가능성이 있는지 여부

    ▶ 개인정보의 추가적인 이용·제공이 정보주체의 이익을 부당하게 침해하는지 여부

    ▶ 가명처리 또는 암호화 등 안전성 확보에 필요한 조치를 하였는지 여부

    ※ 추가적인 이용·제공 시 고려사항에 대한 판단기준은 사업자/단체 스스로 자율적으로 판단하여 작성·공개함
    """)
    private lazy var guideView11 = GuideView(title: "제11조(가명정보를 처리하는 경우 가명정보 처리에 관한 사항)", guide: """
    < 투개더 (Togaether) > 은(는) 다음과 같은 목적으로 가명정보를 처리하고 있습니다.

    ▶ 가명정보의 처리 목적

    닉네임을 사용한 가입 처리, 프로필 관리, 모임 생성과 참여 목적

    ▶ 가명정보의 처리 및 보유기간

    수집일로부터 5년

    ▶ 가명처리하는 개인정보의 항목

    닉네임

    ▶ 법 제28조의4(가명정보에 대한 안전조치 의무 등)에 따른 가명정보의 안전성 확보조치에 관한 사항

    투개더는 「개인정보보호법」제28조의4에 따라 다음과 같이 가명정보의 안전성 확보를 위하여 관리적, 기술적, 물리적 대책으로 여러 보안장치를 마련하고 있습니다.

    - 제7조에 따른 안전성 확보 조치

    - 추가정보의 별도 분리 보관

    추가정보는 가명정보와 분리하여 별도로 저장·관리하고 가명정보와 불법적으로 결합되어 재식별에 악용되지 않도록 접근 권한을 최소화하고 접근통제를 강화하는 등 필요한 조치를 적용하고 있습니다.

    - 접근권한의 분리

    투개더는 가명정보 또는 추가정보에 접근할 수 있는 담당자를 가명정보 처리 업무 목적달성에 필요한 최소한의 인원으로 엄격하게 통제하고 있으며, 접근권한도 업무에 따라 차등부여하고 있습니다.

    가명정보처리시스템에 접속할 수 있는 사용자계정을 발급하는 경우 가명정보취급자 별로 사용자계정을 발급하고 있으며, 다른 가명정보취급자 및 개인정보취급자와 공유되지 않도록 하고 있습니다.

    - 가명정보 기록작성·보관 및 공개

    투개더는 가명정보의 처리목적, 가명처리한 개인정보 항목, 가명정보의 이용내역, 제3자 제공 시 제공받는 자를 작성하여 보관하고 있습니다.
    """)
    private lazy var guideView12 = GuideView(title: "제12조 (개인정보 보호책임자에 관한 사항)", guide: """
    ① 투개더 (Togaether) 은(는) 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.

    ▶ 개인정보 보호책임자
    성명 :김준수
    직책 :PM
    직급 :-
    연락처 : kjs55495543@naver.com


    ② 정보주체께서는 투개더 (Togaether) 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자에게 문의하실 수 있습니다. 투개더 (Togaether) 은(는) 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.
    """)
    private lazy var guideView13 = GuideView(title: "제13조(개인정보의 열람청구를 접수·처리하는 담당자)", guide: """
    정보주체는 ｢개인정보 보호법｣ 제35조에 따른 개인정보의 열람 청구를 아래의 담당자에게 할 수 있습니다.
    < 투개더 (Togaether) >은(는) 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.

    ▶ 개인정보 열람청구 접수·처리 담당자
    담당자 : 김준수
    연락처 : kjs55495543@naver.com
    """)
    private lazy var guideView14 = GuideView(title: "제14조(정보주체의 권익침해에 대한 구제방법)", guide: """
    정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.

    1. 개인정보분쟁조정위원회 : (국번없이) 1833-6972 (www.kopico.go.kr)
    2. 개인정보침해신고센터 : (국번없이) 118 (privacy.kisa.or.kr)
    3. 대검찰청 : (국번없이) 1301 (www.spo.go.kr)
    4. 경찰청 : (국번없이) 182 (ecrm.cyber.go.kr)

    「개인정보보호법」제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대 하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.

    ※ 행정심판에 대해 자세한 사항은 중앙행정심판위원회(www.simpan.go.kr) 홈페이지를 참고하시기 바랍니다.
    """)
    private lazy var guideView15 = GuideView(title: "제15조(개인정보 처리방침 변경)", guide: """
    ① 이 개인정보처리방침은 2022년 7월 30일부터 적용됩니다.
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
