import { NativeModules } from 'react-native';

const { PTRIDFA } = NativeModules;

class IDFA {
  getIDFA() {
    return PTRIDFA.getIDFA();
  }

  getOpenInstallData() {
    if(!PTRIDFA.hasOwnProperty("getOpenInstallData")){
      return new Promise( ( resolve, reject ) =>{
          resolve({})
      });
    }
    return PTRIDFA.getOpenInstallData();
  }

  openInstallReportRegister() {
      if(!PTRIDFA.hasOwnProperty("openInstallReportRegister")){
          return;
      }
      PTRIDFA.openInstallReportRegister();
  }
  openInstallReportEffectPoint(pointId,point) {
      if(!PTRIDFA.hasOwnProperty("openInstallReportEffectPoint")){
          return;
      }
      PTRIDFA.openInstallReportEffectPoint(pointId,point);
  }
}

IDFAInstance = new IDFA();
export default IDFAInstance;
