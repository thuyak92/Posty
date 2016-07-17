//
//  Constants.h
//  MyDear
//
//  Created by phuongthuy on 1/8/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define HOST    @"http://52.69.239.6/"

//App id
#define APP_STORE_URL @"https://itunes.apple.com/us/app/id"
#define APP_STORE_ID @"975235037"

#define GOOGLE_MAP_API_KEY      @"AIzaSyBMtizOqE1uJZhnsph34ZCKOM2GeQLJpZs"

//Segue identifier
#define SEGUE_HOME_TO_DETAIL            @"segueHomeToDetail"
#define SEGUE_HOME_TO_SEARCH            @"segueHomeToSearch"
#define SEGUE_MAP_TO_SEARCH             @"segueMapToSearch"
#define SEGUE_MAP_TO_DETAIL             @"segueMapToDetail"
#define SEGUE_POST_TO_POST_SETTING      @"SeguePostToPostSetting"
#define SEGUE_LOGIN_TO_USER_INFO        @"segueLoginToUserInfo"
#define SEGUE_POST_SETTING_TO_CONFIRM   @"seguePostSettingToConfrim"
#define SEGUE_POST_TO_MENU_POST         @"seguePostToMenuPost"
#define SEGUE_INFO_TO_NOTICE            @"segueInfoToNotice"
#define SEGUE_INFO_TO_PROFILE           @"segueInfoToProfile"
#define SEGUE_SETTING_TO_ACCOUNT        @"segueSettingToAccount"

//Storyboard Identifier
#define SB_LOGIN            @"storyboardLogin"
#define SB_NOTICE           @"storyboardNotice"
#define SB_PROFILE          @"storyboardProfile"
#define SB_FRIEND           @"storyboardFriend"
#define SB_SETTING          @"storyboardSetting"

//Tab bar
#define TAB_HOME        0
#define TAB_MAP         1
#define TAB_POST        2
#define TAB_TALK        3
#define TAB_INFO        4

//Class Name
#define CLASS_POST      @"post"
#define CLASS_USER      @"user"
#define CLASS_COMMENT   @"comment"

//URL
#define URL_USER        @"api/v1/users"
#define URL_POST        @"api/v1/posts"
#define URL_SEARCH      @"api/v1/posts/search"
#define URL_POST_DETAIL @"api/v1/posts/1"
#define URL_LOGIN       @"api/v1/login"
#define URL_REGISTER    @"api/v1/register"
#define URL_UPDATE_USER @"api/v1/users/%ld"
#define URL_GET_COMMENT @"api/v1/posts/%ld/comments"
#define URL_ACTION      @"api/v1/posts/post_action"

//Dictionary key
#define KEY_DATA            @"data"
#define KEY_SEARCH          @"search"
#define KEY_CURRENT_USER    @"currentUser"
#define KEY_DISTANCE        @"distance"
#define KEY_LOGIN_AS_GUEST  @"loginAsGuest"
#define KEY_LIKED           @"liked"
#define KEY_FAVORITED       @"favorited"

//Post menu
#define MENU_RECEIVED   0
#define MENU_DELAY      1
#define MENU_SAVE       2
#define MENU_SEND       3
#define MENU_TRASH      4
#define MENU_TITLE      @[@"受信ポスト", @"送信予定ポスト(日時設定あり)", @"下書きポスト", @"送信済みポスト", @"ゴミ箱"]
#define MENU_ICON       @[@"menuReceived.png", @"menuDelay.png", @"menuSave.png", @"menuSend.png", @"menuTrash.png"]

//Action Type
#define ACTION_LIKE         1
#define ACTION_DISLIKE      2
#define ACTION_FAVORITE     3
#define ACTION_UNFAVORITE   4
#define ACTION_COMMENT      5

//Response status
#define KEY_RESPONSE_STATUS_OK  1
#define KEY_RESPONSE_STATUS_NG  0

//Color
#define COLOR_TINT      @"#FF4545"
#define COLOR_DEFAULT   @"#333333"

//Formatter
#define TIME_FORMAT         @"HH:mm"
#define DATE_FORMAT         @"dd-MM-yyyy"
#define DATE_TIME_FORMAT    @"yyyy-MM-dd HH:mm"

#endif /* Constants_h */
