//
//  Area.swift
//  App
//
//  Created by Hani on 2022/06/25.
//

import Foundation

enum Area: String, CaseIterable {
    case seoul = "서울"
    case busan = "부산"
    case daegu = "대구"
    case incheon = "인천"
    case gwangju = "광주"
    case daejeon = "대전"
    case ulsan = "울산"
    case sejong = "세종"
    case gyeonggi = "경기"
    case gangwon = "강원"
    case chungcheongbuk = "충북"
    case chungcheongnam = "충남"
    case jeollabuk = "전북"
    case jeollanam = "전남"
    case gyeongsangbuk = "경북"
    case gyeongsangnam = "경남"
    case jeju = "제주"
    
    enum Seoul: String, CaseIterable {
        case gangnam = "강남구"
        case gangdong = "강동구"
        case gangbuk = "강북구"
        case gangseo = "강서구"
        case gwanak = "관악구"
        case gwangjin = "광진구"
        case guro = "구로구"
        case geumcheon = "금천구"
        case nowon = "노원구"
        case dobong = "도봉구"
        case dongdaemun = "동대문구"
        case dongjak = "동작구"
        case mapo = "마포구"
        case seodaemun = "서대문구"
        case seocho = "서초구"
        case seongdong = "성동구"
        case seongbuk = "성북"
        case songpa = "송파"
        case yangcheon = "양천구"
        case yeongdeungpo = "영등포구"
        case yongsan = "용산구"
        case eunpyeong = "은평구"
        case jongno = "종로구"
        case jung = "중구"
        case jungnang = "중랑구"
    }
    
    enum Busan: String, CaseIterable {
        case gangseo = "강서구"
        case geumjeong = "금정구"
        case gijang = "기장군"
        case nam = "남구"
        case dong = "동구"
        case dongnae = "동래구"
        case busanjin = "부산진구"
        case buk = "북구"
        case sasang = "사상구"
        case saha = "사하구"
        case seo = "서구"
        case suyeong = "수영구"
        case yeonje = "연제구"
        case yeongdo = "영도구"
        case jung = "중구"
        case haeundae = "해운대구"
    }
    
    enum Daegu: String, CaseIterable {
        case nam = "남구"
        case dalseo = "달서구"
        case dalseong = "달성군"
        case dong = "동구"
        case buk = "북구"
        case seo = "서구"
        case suseong = "수성구"
        case jung = "중구"
    }
    
    enum Incheon: String, CaseIterable {
        case ganghwa = "강화군"
        case gyeyang = "계양구"
        case namdong = "남동구"
        case dong = "동구"
        case michuhol = "미추홀구"
        case bupyeong = "부평구"
        case seo = "서구"
        case yeonsu = "연수구"
        case ongjin = "옹진군"
        case jung = "중구"
    }
    
    enum Gwangju: String, CaseIterable {
        case gwangsan = "광산구"
        case nam = "남구"
        case dong = "동구"
        case buk = "북구"
        case seo = "서구"
    }

    enum Daejeon: String, CaseIterable {
        case daedeok = "대덕구"
        case dong = "동구"
        case seo = "서구"
        case yuseong = "유성구"
        case jung = "중구"
    }

    enum Ulsan: String, CaseIterable {
        case nam = "남구"
        case dong = "동구"
        case buk = "북구"
        case ulju = "울주군"
        case jung = "중구"
    }

    enum Sejong: String, CaseIterable {
        case none = "세종"
    }
    enum Gyeonggi: String, CaseIterable {
        case gapyeong = "가평군"
        case deogyang = "고양시 덕양구"
        case ilsandong = "고양시 일산동구"
        case ilsanseo = "고양시 일산서구"
        case gwacheon = "과천시"
        case gwangmyeong = "광명시"
        case gwangju = "광주시"
        case guri = "구리시"
        case gunpo = "군포시"
        case gimpo = "김포시"
        case namyangju = "남양주시"
        case dongducheon = "동두천시"
        case bucheon = "부천시"
        case bundang = "성남시 분당구"
        case sujeong = "성남시 수정구"
        case jungwon = "성남시 중원구"
        case gwonseon = "수원시 권선구"
        case yeongtong = "수원시 영통구"
        case jangan = "수원시 장안구"
        case paldal = "수원시 팔달구"
        case siheung = "시흥시"
        case danwon = "안산시 단원구"
        case sangnok = "안산시 상록구"
        case anseong = "안성시"
        case dongan = "안양시 동안구"
        case manan = "안양시 만안구"
        case yangju = "양주시"
        case yangpyeong = "양평군"
        case yeoju = "여주시"
        case yeoncheon = "연천군"
        case osan = "오산시"
        case giheung = "용인시 기흥구"
        case suji = "용인시 수지구"
        case cheoin = "용인시 처인구"
        case uiwang = "의왕시"
        case uijeongbu = "의정부시"
        case icheon = "이천시"
        case paju = "파주시"
        case pyeongtaek = "평택시"
        case pocheon = "포천시"
        case hanam = "하남시"
        case hwaseong = "화성시"
    }
    
    enum Gangwon: String, CaseIterable {
        case gangneung = "강릉시"
        case goseong = "고성군"
        case donghae = "동해시"
        case samcheok = "삼척시"
        case sokcho = "속초시"
        case yanggu = "양구군"
        case yangyang = "양양군"
        case yeongwol = "영월군"
        case wonju = "원주시"
        case inje = "인제군"
        case jeongseon = "정선군"
        case cheorwon = "철원군"
        case chuncheon = "춘천시"
        case taebaek = "태백시"
        case pyeongchang = "평창군"
        case hongcheon = "홍천군"
        case hwacheon = "화천군"
        case hoengseong = "횡성군"
    }
    
    enum Chungcheongbuk: String, CaseIterable {
        case goesan = "괴산군"
        case danyang = "단양군"
        case boeun = "보은군"
        case yeongdong = "영동군"
        case okcheon = "옥천군"
        case eumseong = "음성군"
        case jecheon = "제천시"
        case jeungpyeong = "증평군"
        case jincheon = "진천군"
        case sangdang = "청주시 상당구"
        case seowon = "청주시 서원구"
        case cheongwon = "청주시 청원구"
        case heungdeok = "청주시 흥덕구"
        case chungju = "충주시"
    }
    
    enum Chungcheongnam: String, CaseIterable {
        case gyeryong = "계룡시"
        case gongju = "공주시"
        case geumsan = "금산군"
        case nonsan = "논산시"
        case dangjin = "당진시"
        case boryeong = "보령시"
        case buyeo = "부여군"
        case seosan = "서산시"
        case seocheon = "서천군"
        case asan = "아산시"
        case yesan = "예산군"
        case dongnam = "천안시 동남구"
        case sebuk = "천안시 서북구"
        case cheongyang = "청양군"
        case taean = "태안군"
        case hongseong = "홍성군"
    }
    
    enum Jeollabuk: String, CaseIterable {
        case gochang = "고창군"
        case gunsan = "군산시"
        case gimje = "김제시"
        case namwon = "남원시"
        case muju = "무주군"
        case buan = "부안군"
        case sunchang = "순창군"
        case wanju = "완주군"
        case iksan = "익산시"
        case imsil = "임실군"
        case jangsu = "장수군"
        case deokjin = "전주시 덕진구"
        case wansan = "전주시 완산구"
        case jeongeup = "정읍시"
        case jinan = "진안군"
    }
    
    enum Jeollanam: String, CaseIterable {
        case gangjin = "강진군"
        case goheung = "고흥군"
        case gokseong = "곡성군"
        case gwangyang = "광양시"
        case gurye = "구례군"
        case naju = "나주시"
        case damyang = "담양군"
        case mokpo = "목포시"
        case muan = "무안군"
        case boseong = "보성군"
        case suncheon = "순천시"
        case sinan = "신안군"
        case yeosu = "여수시"
        case yeonggwang = "영광군"
        case yeongam = "영암군"
        case wando = "완도군"
        case jangseong = "장성군"
        case jangheung = "장흥군"
        case jindo = "진도군"
        case hampyeong = "함평군"
        case haenam = "해남군"
        case hwasun = "화순군"
    }
    
    enum Gyeongsangbuk: String, CaseIterable {
        case gyeongsan = "경산시"
        case gyeongju = "경주시"
        case goryeong = "고령군"
        case gumi = "구미시"
        case gunwi = "군위군"
        case gimcheon = "김천시"
        case mungyeong = "문경시"
        case bonghwa = "봉화군"
        case sangju = "상주시"
        case seongju = "성주군"
        case andong = "안동시"
        case yeongdeok = "영덕군"
        case yeongyang = "영양군"
        case yeongju = "영주시"
        case yeongcheon = "영천시"
        case yecheon = "예천군"
        case ulleung = "울릉군"
        case uljin = "울진군"
        case uiseong = "의성군"
        case cheongdo = "청도군"
        case cheongsong = "청송군"
        case chilgok = "칠곡군"
        case nam = "포항시 남구"
        case buk = "포항시 북구"
    }
    
    enum Gyeongsangnam: String, CaseIterable {
        case geoje = "거제시"
        case geochang = "거창군"
        case goseong = "고성군"
        case gimhae = "김해시"
        case namhae = "남해군"
        case miryang = "밀양시"
        case sacheon = "사천시"
        case sancheong = "산청군"
        case yangsan = "양산시"
        case uiryeong = "의령군"
        case jinju = "진주시"
        case changnyeong = "창녕군"
        case masanhappo = "창원시 마산합포구"
        case masanhoewon = "창원시 마산회원구"
        case seongsan = "창원시 성산구"
        case uichang = "창원시 의창구"
        case jinhae = "창원시 진해구"
        case tongyeong = "통영시"
        case hadong = "하동군"
        case haman = "함안군"
        case hamyang = "함양군"
        case hapcheon = "합천군"
    }
    
    enum Jeju: String, CaseIterable {
        case seogwipo = "서귀포시"
        case jeju = " 제주시"
    }

    static func getSmallCity(bigCity: String) -> [String] {
        guard let area = Area(rawValue: bigCity) else {
            return []
        }
        
        switch area {
        case .seoul:
            return Area.Seoul.allCases.map { $0.rawValue }
        case .busan:
            return Area.Busan.allCases.map { $0.rawValue }
        case .daegu:
            return Area.Daegu.allCases.map { $0.rawValue }
        case .incheon:
            return Area.Incheon.allCases.map { $0.rawValue }
        case .gwangju:
            return Area.Gwangju.allCases.map { $0.rawValue }
        case .daejeon:
            return Area.Daejeon.allCases.map { $0.rawValue }
        case .ulsan:
            return Area.Ulsan.allCases.map { $0.rawValue }
        case .sejong:
            return Area.Sejong.allCases.map { $0.rawValue }
        case .gyeonggi:
            return Area.Gyeonggi.allCases.map { $0.rawValue }
        case .gangwon:
            return Area.Gangwon.allCases.map { $0.rawValue }
        case .chungcheongbuk:
            return Area.Chungcheongbuk.allCases.map { $0.rawValue }
        case .chungcheongnam:
            return Area.Chungcheongnam.allCases.map { $0.rawValue }
        case .jeollabuk:
            return Area.Jeollabuk.allCases.map { $0.rawValue }
        case .jeollanam:
            return Area.Jeollanam.allCases.map { $0.rawValue }
        case .gyeongsangbuk:
            return Area.Gyeongsangbuk.allCases.map { $0.rawValue }
        case .gyeongsangnam:
            return Area.Gyeongsangnam.allCases.map { $0.rawValue }
        case .jeju:
            return Area.Jeju.allCases.map { $0.rawValue }
        }
    }
}
