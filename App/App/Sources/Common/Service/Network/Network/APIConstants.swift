//
//  APIConstants.swift
//  App
//
//  Created by Hani on 2022/08/04.
//

import Foundation

struct APIConstants {
    private static let baseURL = "https://yapp-togather.com"
    
    /// 강아지 정보 관련 API를 제공합니다.
    struct Pet {
        private static let `default` = "\(baseURL)/api/pets"
        
        public static let register = "\(`default`)"
        public static let delete = "\(`default`)"
    }
    
    /// 계정 관련 API를 제공합니다.
    struct Account {
        private static let `default` = "\(baseURL)/api/accounts"

        public static let nicknameCheck = "\(`default`)/validation"
        public static let signUp = "\(`default`)/sign-up"
        public static let mypage = "\(`default`)/my-page"
        public static let edit = "\(`default`)"
        public static let delete = "\(`default`)"
    }
    
    /// 소셜 로그인 관련 API를 제공합니다.
    struct Auth {
        private static let `default` = "\(baseURL)/auth"
        
        public static let apple = "\(`default`)/apple"
    }

    /// 댓글 관련 API를 제공합니다.
    struct Comment {
        private static let `default` = "\(baseURL)/api/comments"
        
        public static let post = "\(`default`)"
        public static let delete = "\(`default`)"
    }
    
    /// 모임 관련 API를 제공합니다.
    struct Club {
        private static let `default` = "\(baseURL)/api/clubs"
        
        public static let list = "\(`default`)"
        public static let detail = "\(`default`)"
        public static let create = "\(`default`)"
        public static let delete = "\(`default`)"
        public static let participate = "\(`default`)/participate"
        public static let leave = "\(`default`)/leave"
    }
    
    /// 검색 관련 API를 제공합니다.
    struct Search {
        private static let `default` = "\(baseURL)/api/clubs/search"
        
        public static let lookup = "\(`default`)"
        public static let range = "\(`default`)/range"
        public static let simple = "\(`default`)/simple"
    }


    /// 신고 관련 API를 제공합니다.
    struct Report {
        private static let `default` = "\(baseURL)/api/reports"
        
        public static let club = "\(`default`)/club"
        public static let comment = "\(`default`)/comment"
        public static let account = "\(`default`)/account"
    }
    
    /// 토큰 관련 API를 제공합니다.
    struct Token {
        private static let `default` = "\(baseURL)/api/tokens"

        public static let expire = "\(`default`)/expire"
        public static let reissuance = "\(`default`)/re-issuance"
    }
    
}
