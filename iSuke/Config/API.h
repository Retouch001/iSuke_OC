//
//  Header.h
//  iSuke
//
//  Created by Tang Retouch on 2018/3/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define RT_APPSERIALNUM                     @"MIS0812778904"
#define RT_APPORGCODE                       @"0"
#define RT_ORGID                            @"-1"


#define   RT_HAOWEI_BASE_URL                 @"http://192.168.8.241:8082"
#define   RT_LINAG_BASE_URL                  @"http://192.168.1.182"
#define   RT_DEVELOP_BASE_URL                @"http://117.78.48.143"
#define   RT_TEST_BASE_URL                   @"http://117.78.48.140"

#define RT_ICON_BASE                         @"/iSukeImage/"

//LoginMode
#define   RT_REGISTER_URL                    @"/iSukeServer/api/register"
#define   RT_GET_CAPTCHA_URL                 @"/iSukeServer/api/getVerifyCode"
#define   RT_LOGIN_URL                       @"/iSukeServer/api/login"
#define   RT_FORGET_PSD                      @"/iSukeServer/api/forgetPwd"



//DeviceCentre
#define RT_DEVICEMANAGE                      @"/iSukeServer/device/getDeviceManage"
#define RT_DEVICE_DETAIL                     @"/iSukeServer/device/getDeviceDetail"
#define RT_OPERATE_SWITCH                    @"/iSukeServer/device/operateSwitch"
#define RT_SETDEVICE_ALIAS                   @"/iSukeServer/device/deviceAlias"


#define RT_SHARED_USERS                      @"iSukeServer/user/getSharedUser"
#define RT_UNSHARE_USER                      @"iSukeServer/user/unShareDeviceToUser"
#define RT_SET_SHAREUSER_ALIAS               @"iSukeServer/user/setShareUserAlias"
#define RT_ADD_SHARE_USER                    @"iSukeServer/user/addShareUser"
#define RT_QUERY_USER                        @"iSukeServer/user/queryUser"
#define RT_QUERY_DEVICE                      @"iSukeServer/device/getDeviceOnline"
#define RT_SEARCH_DEVICE_V                   @"iSukeServer/device/getCurrentDeviceVersion"
#define RT_UPDATE_DEVICE_V                   @"iSukeServer/device/updateDevice"
#define RT_ADD_DEVICE                        @"iSukeServer/device/relativeDevice"



#define RT_GET_TIMEDTASK                     @"iSukeServer/timedTask/getTimedTask"
#define RT_TIMEDTASK_DETAIL                  @"iSukeServer/timedTask/timedTaskDetail"
#define RT_EDIT_TIMEDTASK                    @"iSukeServer/timedTask/editTimedTask"
#define RT_DELETE_TIMEDTASK                  @"iSukeServer/timedTask/deleteTimedTask"
#define RT_ADD_TIMEDTASK                     @"iSukeServer/timedTask/addTimedTask"

#define RT_DEVICE_POWER                      @"iSukeServer/device/devicePower"
#define RT_DEVICE_POWER_DETAIL               @"iSukeServer/device/devicePowerDetail"

#define RT_DELETE_DEVICE                     @"iSukeServer/device/deleteDevice"





//SceneMode
#define RT_GET_SCENE                          @"iSukeServer/scene/getScene"
#define RT_SCENE_DETAIL                       @"iSukeServer/scene/sceneDetail"
#define RT_EDIT_SCENE                         @"iSukeServer/scene/editScene"
#define RT_ADD_SCENE                          @"iSukeServer/scene/addScene"
#define RT_DELETE_SCENE                       @"iSukeServer/scene/deleteScene"
#define RT_GET_SCENE_CONDITION                @"iSukeServer/scene/getSceneCondition"



//PersonalCentre
#define RT_MODIFY_ICON                         @"iSukeServer/user/changeAvatar"
#define RT_MODIFY_USERINFO                     @"iSukeServer/user/modifyUserInfo"
#define RT_GET_MESSAGES                        @"iSukeServer/api/getMessageCenter"
#define RT_FEEDBACK                            @"iSukeServer/api/feedback"
#define RT_MODIFY_PWD                          @"iSukeServer/api/changePwd"
#define RT_GET_MESSAGES_DETAIL                 @"iSukeServer/api/getMessageDetail"
#define RT_NORMAL_PROBLEM                      @"iSukeServer/api/normalProblem"









#endif /* Header_h */
