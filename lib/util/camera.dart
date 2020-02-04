class Camera {
  static const String flash_on = 'FLASH ON';
  static const String flash_off = 'FLASH OFF';
  static const String front_camera = 'FRONT CAMERA';
  static const String back_camera = 'BACK CAMERA';

  static bool isFlashOn(String current) {
    return flash_on == current;
  }

  static bool isBackCamera(String current) {
    return back_camera == current;
  }
}
