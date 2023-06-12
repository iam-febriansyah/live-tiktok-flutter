class Constant {
  static String appName = "-";
  static String yourCompany = "-, Inc";
  static String domainIP = "live-tiktok.febriansyah.dev";
  static String port = "";
  static String mainUrl = port == '' ? domainIP : "$domainIP:$port";
  static String httpMainUrl = "https://$mainUrl";
}
