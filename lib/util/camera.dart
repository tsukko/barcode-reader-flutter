class Camera {
  static const flash_on = "FLASH ON";
  static const flash_off = "FLASH OFF";
  static const front_camera = "FRONT CAMERA";
  static const back_camera = "BACK CAMERA";

  static isFlashOn(String current) {
    return flash_on == current;
  }

  static isBackCamera(String current) {
    return back_camera == current;
  }
}
