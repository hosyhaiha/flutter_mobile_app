class ApiEndpoints {
  static final String getToken = 'http://10.2.9.76:8080/api/auth/token';
  static final String getUserInfor = 'http://10.15.12.227:8080/api/users/current';
  static final String getTenants = 'http://10.15.12.227:8080/api/tenants/get-by-code/tnt-ce8670d3-3b67-41bd-aa1d-587b714b0595';
  static final String getListDevice = 'http://10.2.9.76:8080/api/devices/search?query=&page=0&size=10&sort=created,desc';
}