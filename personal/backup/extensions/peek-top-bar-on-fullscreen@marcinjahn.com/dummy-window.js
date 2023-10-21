imports.gi.versions.Gtk = "3.0";
const { Gtk } = imports.gi;

class DummyWindow {
  constructor() {
    this.dummyApp = this.createApp();
  }

  createWindow(app) {
    let win = app.win;
    if (!win) {
      win = new Gtk.ApplicationWindow({
        application: app,
        defaultHeight: 0,
        defaultWidth: 0,
      });
    }
    win.set_keep_above(true);
    win.set_decorated(false);
    win.set_skip_taskbar_hint(true);
    win.set_skip_pager_hint(true);
    win.set_accept_focus(false);
    win.present();
  }

  createApp() {
    const dummyApp = new Gtk.Application();
    dummyApp.connect("activate", this.createWindow);
    dummyApp.run(null);

    return dummyApp;
  }

  close() {
    this.dummyApp.quit();
  }
}

new DummyWindow();
