export class BARouterPath {
  //示例：'http://baapp/badiscovermodule/BAPyqPage?type=1&name=奇迹'

  static readonly HOST_APP = 'baapp'
  static readonly HOST_H5 = 'bah5'
  static readonly HOST_MINIPROJECT = 'baminiProject'

  //获取路由path-App
  static getAppRouterPath(path: string) {
    return String('http://' + BARouterPath.HOST_APP + path)
  }

  //获取路由path-h5
  static getH5RouterPath(path: string) {
    return String('http://' + BARouterPath.HOST_H5 + path)
  }

  //获取路由path-miniProject
  static getMiniProjectRouterPath(path: string) {
    return String('http://' + BARouterPath.HOST_MINIPROJECT + path)
  }
}