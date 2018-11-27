import { NativeModules } from 'react-native';

const { sc } = NativeModules;

class SC {
    getIDFA() {
        return PTRIDFA.getIDFA();
    }

    getOpenInstallData() {
        if(!sc.hasOwnProperty("getOpenInstallData")){
            return new Promise( ( resolve, reject ) =>{
                resolve({})
            });
        }
        return sc.getOpenInstallData();
    }

    /**
     * 注册时发送
     * @param uid
     * @param nickname
     * @constructor
     */
    ReportRegister(uid,nickname) {
        if(!sc.hasOwnProperty("ReportRegister")){
            return;
        }

        sc.ReportRegister(JSON.stringify({uid,nickname}));
    }

    /**
     * 登录打点
     * @param uid
     * @param nickname
     * @constructor
     */
    ReportLogin(uid,nickname) {
        if(!sc.hasOwnProperty("ReportLogin")){
            return;
        }
        sc.ReportLogin(JSON.stringify({uid,nickname}));
    }

    /**
     * 开始跟踪某一页面（可选），记录页面打开时间
     * @param pageName
     */
    trackPageBegin(pageName) {
        if(!sc.hasOwnProperty("trackPageBegin")){
            return;
        }
        sc.trackPageBegin(pageName);
    }

    /**
     * 结束某一页面的跟踪（可选），记录页面的关闭时间
     * @param pageName
     */
    trackPageEnd(pageName) {
        if(!sc.hasOwnProperty("trackPageBegin")){
            return;
        }
        sc.trackPageEnd(pageName);
    }

    /**
     *跟踪事件
     * @param event
     * @param label 事件标签或事件数值
     * @param param
     * @constructor
     */
    ReportEffectPoint(event,label,param) {
        if(!sc.hasOwnProperty("ReportEffectPoint")){
            return;
        }
        let defaultValue=0;
        if(!label&&label!==0){
            label="";
        }else if(!isNaN(label)){
            defaultValue=label;
            label=label+"";
        }else{
            defaultValue=0;
        }
        if(!param)param={};
        sc.ReportEffectPoint({event,label,defaultValue,param});
    }
}

SCInstance = new SC();
export default SCInstance;
