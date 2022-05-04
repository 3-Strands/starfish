import 'dart:html' show window;

void removeSplashScreen() {
  window.document.getElementById('splash-img')?.remove();
}
