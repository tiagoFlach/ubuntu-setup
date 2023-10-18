var init = (function (clutter1, gobject2, glib2) {
    'use strict';

    function __decorate(decorators, target, key, desc) {
        var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
        if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
        else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;

        return c > 3 && r && Object.defineProperty(target, key, r), r;
    }

    /// Taken from https://github.com/material-shell/material-shell/blob/main/src/utils/gjs.ts
    /// Decorator function to call `GObject.registerClass` with the given class.
    /// Use like
    /// ```
    /// @registerGObjectClass
    /// export class MyThing extends GObject.Object { ... }
    /// ```
    function registerGObjectClass(target) {
        // Note that we use 'hasOwnProperty' because otherwise we would get inherited meta infos.
        // This would be bad because we would inherit the GObjectName too, which is supposed to be unique.
        if (Object.prototype.hasOwnProperty.call(target, "metaInfo")) {
            // eslint-disable-next-line
            // @ts-ignore
            // eslint-disable-next-line
            return gobject2.registerClass(target.metaInfo, target);
        }
        else {
            // eslint-disable-next-line
            // @ts-ignore
            return gobject2.registerClass(target);
        }
    }

    const Shell = imports.gi.Shell;
    const Meta$1 = imports.gi.Meta;
    class Barrier {
        constructor(position, hitDirection, triggerMode, triggerAction) {
            this.position = position;
            this.hitDirection = hitDirection;
            this.triggerMode = triggerMode;
            this.triggerAction = triggerAction;
        }

        activate() {
            this.pressureBarrier = new imports.ui.layout.PressureBarrier(this.triggerMode === TriggerMode.Delayed ? 15 : 0, this.triggerMode === TriggerMode.Delayed ? 200 : 0, Shell.ActionMode.NORMAL);
            this.pressureBarrier.connect("trigger", this.onTrigger.bind(this));
            const { x1, x2, y1, y2 } = this.position;
            this.nativeBarrier = new Meta$1.Barrier({
                display: global.display,
                x1,
                x2,
                y1,
                y2,
                directions: this.hitDirection === HitDirection.FromBottom
                    ? Meta$1.BarrierDirection.POSITIVE_Y
                    : Meta$1.BarrierDirection.NEGATIVE_Y,
            });
            this.pressureBarrier.addBarrier(this.nativeBarrier);
        }

        onTrigger() {
            this.triggerAction();
        }

        dispose() {
            if (!this.nativeBarrier) {
                return;
            }
            this.pressureBarrier?.removeBarrier(this.nativeBarrier);
            this.nativeBarrier.destroy();
            this.nativeBarrier = null;
            this.pressureBarrier?.destroy();
            this.pressureBarrier = null;
        }
    }
    var HitDirection;
    (function (HitDirection) {
        HitDirection[HitDirection["FromTop"] = 0] = "FromTop";
        HitDirection[HitDirection["FromBottom"] = 1] = "FromBottom";
    })(HitDirection || (HitDirection = {}));
    var TriggerMode;
    (function (TriggerMode) {
        TriggerMode[TriggerMode["Instant"] = 0] = "Instant";
        TriggerMode[TriggerMode["Delayed"] = 1] = "Delayed";
    })(TriggerMode || (TriggerMode = {}));

    class CursorPositionLeaveDetector {
        constructor(position, hitDirection, leaveAction, leaveCondition) {
            this.position = position;
            this.leaveAction = leaveAction;
            this.leaveCondition = leaveCondition;
            this.timeoutId = null;
            this.boundsChecker =
                hitDirection === HitDirection.FromBottom
                    ? this.fromBottomBoundsChecker
                    : this.fromTopBoundsChecker;
        }

        activate() {
            this.timeoutId = glib2.timeout_add(glib2.PRIORITY_DEFAULT, 400, () => {
                if (!this.isOutOfBounds() || !this.leaveCondition?.()) {
                    return glib2.SOURCE_CONTINUE;
                }
                this.leaveAction();

                return glib2.SOURCE_REMOVE;
            });
        }

        dispose() {
            if (this.timeoutId) {
                glib2.source_remove(this.timeoutId);
                this.timeoutId = null;
            }
        }

        isOutOfBounds() {
            let [_, mouse_y, __] = global.get_pointer();

            return this.boundsChecker(mouse_y);
        }

        fromTopBoundsChecker(mouseY) {
            return this.position.y1 < mouseY;
        }

        fromBottomBoundsChecker(mouseY) {
            return this.position.y1 > mouseY;
        }
    }

    /**
     * Edge detection, hardcoded for top edge, since
     * I don't need anything else at the moment
     */
    let HotEdge = class HotEdge extends clutter1.Actor {
        constructor(monitor, leaveOffset, triggerAction, leaveAction, leaveCondition) {
            super();
            this.monitor = monitor;
            this.leaveOffset = leaveOffset;
            this.triggerAction = triggerAction;
            this.leaveAction = leaveAction;
            this.leaveCondition = leaveCondition;
            this.barrier = null;
            this.leaveDetector = null;
            this._isTriggered = false;
            this.connect("destroy", this.dispose.bind(this));
        }

        initialize() {
            const { x, y, width } = this.monitor;
            this.barrier = new Barrier({
                x1: x,
                x2: x + width,
                y1: y + 1,
                y2: y + 1,
            }, HitDirection.FromBottom, TriggerMode.Delayed, this.onEnter.bind(this));
            this.barrier.activate();
        }

        onEnter() {
            if (this._isTriggered) {
                return;
            }
            this._isTriggered = true;
            const { x, y, width } = this.monitor;
            this.leaveDetector = new CursorPositionLeaveDetector({
                x1: x,
                x2: x + width,
                y1: y + this.leaveOffset,
                y2: y + this.leaveOffset,
            }, HitDirection.FromTop, this.onLeave.bind(this), this.leaveCondition);
            this.leaveDetector.activate();
            this.triggerAction();
        }

        onLeave() {
            if (!this._isTriggered) {
                return;
            }
            this._isTriggered = false;
            this.disposeOfLeaveDetector();
            this.leaveAction();
        }

        dispose() {
            this.barrier?.dispose();
            this.barrier = null;
            this.disposeOfLeaveDetector();
        }

        disposeOfLeaveDetector() {
            this.leaveDetector?.dispose();
            this.leaveDetector = null;
        }
    };
    HotEdge = __decorate([
        registerGObjectClass
    ], HotEdge);

    function isFullscreen(monitor) {
        return monitor.inFullscreen;
    }

    function isInOverview() {
        const layoutManager = imports.ui.main.layoutManager;

        return layoutManager._inOverview;
    }

    let timeoutSourceIds = [];
    function delay(milliseconds) {
        return new Promise((resolve) => {
            const timeoutId = glib2.timeout_add(glib2.PRIORITY_DEFAULT, milliseconds, () => {
                removeFinishedTimeoutId(timeoutId);
                resolve(undefined);

                return glib2.SOURCE_REMOVE;
            });
            if (!timeoutSourceIds) {
                timeoutSourceIds = [];
            }
            timeoutSourceIds.push(timeoutId);
        });
    }

    function removeFinishedTimeoutId(timeoutId) {
        timeoutSourceIds?.splice(timeoutSourceIds.indexOf(timeoutId), 1);
    }

    function disposeDelayTimeouts() {
        timeoutSourceIds?.forEach((sourceId) => {
            glib2.Source.remove(sourceId);
        });
        timeoutSourceIds = null;
    }

    const Main$1 = imports.ui.main;
    const PanelBox$2 = Main$1.layoutManager.panelBox;
    const ExtensionUtils = imports.misc.extensionUtils;
    const extensionPath = ExtensionUtils.getCurrentExtension().path;
    /**
     * On Wayland, making the panel visible is not enough,
     * there is some weird issue that causes the panel to stay invisible,
     * even though it becomes clickable. As a workaround, on Wayland a concealed dumb
     * app with invisible window (always on top) is started. That makes the panel visible.
     */
    class WaylandPanelManager {
        constructor() { }

        static createAndInitialize() {
            const manager = new WaylandPanelManager();
            manager.spawnDummyApp();

            return manager;
        }

        showPanel() {
            PanelBox$2.visible = true;
        }

        hidePanel() {
            PanelBox$2.visible = false;
        }

        dispose() {
            glib2.spawn_command_line_async('pkill -f "marcinjahn.com/dummy-window.js"');
        }

        async spawnDummyApp() {
            glib2.spawn_command_line_async(`sh -c "GDK_BACKEND=x11 gjs ${extensionPath}/dummy-window.js"`);
        }
    }

    const PanelBox$1 = imports.ui.main.layoutManager.panelBox;
    class X11PanelManager {
        showPanel() {
            PanelBox$1.visible = true;
        }

        hidePanel() {
            PanelBox$1.visible = false;
        }

        dispose() { }
    }

    const PanelBox = imports.ui.main.layoutManager.panelBox;
    function getPanelHeight() {
        return PanelBox.get_children()[0].height;
    }

    function isAnyPanelMenuOpen() {
        const statusArea = PanelBox.get_children()[0].statusArea;
        const opennableIndicators = Object.keys(statusArea)
            .filter((indicator) => !!statusArea[indicator].menu)
            .map((indicator) => statusArea[indicator]);

        return (opennableIndicators.filter((indicator) => indicator.menu.isOpen).length > 0);
    }

    function toggleAnyIndicator() {
        const statusArea = PanelBox.get_children()[0].statusArea;
        const opennableIndicators = Object.keys(statusArea)
            .filter((indicator) => !!statusArea[indicator].menu)
            .map((indicator) => statusArea[indicator]);
        const closedIndicators = opennableIndicators.filter((indicator) => !indicator.menu.isOpen);
        if (closedIndicators.length < 1) {
            return;
        }
        closedIndicators[0].menu.toggle();
        closedIndicators[0].menu.toggle();
    }

    const Main = imports.ui.main;
    const Meta = imports.gi.Meta;
    class Extension {
        constructor(uuid) {
            this.uuid = null;
            this.hotEdge = null;
            this.hotCornersSub = null;
            this.panelManager = null;
            this.uuid = uuid;
        }

        enable() {
            log(`Enabling extension ${this.uuid}`);
            if (Meta.is_wayland_compositor()) {
                this.panelManager = WaylandPanelManager.createAndInitialize();
            }
            else {
                this.panelManager = new X11PanelManager();
            }
            const layoutManager = Main.layoutManager;
            this.hotCornersSub = layoutManager.connect("hot-corners-changed", () => {
                this.setupHotEdge();
            });
            this.setupHotEdge();
        }

        setupHotEdge() {
            this.hotEdge?.dispose();
            const primaryMonitor = Main.layoutManager.primaryMonitor;
            this.hotEdge = new HotEdge(primaryMonitor, getPanelHeight(), () => {
                if (!isFullscreen(primaryMonitor)) {
                    return;
                }
                this.panelManager?.showPanel();
            }, () => {
                if (!isFullscreen(primaryMonitor) || isInOverview()) {
                    toggleAnyIndicator();

                    return;
                }
                delay(200).then(() => {
                    if (!isFullscreen(primaryMonitor) || isInOverview()) {
                        toggleAnyIndicator();

                        return;
                    }
                    this.panelManager?.hidePanel();
                });
            }, () => !isAnyPanelMenuOpen() || isInOverview());
            this.hotEdge.initialize();
            Main.layoutManager.hotCorners.push(this.hotEdge);
        }

        disable() {
            log(`Disabling extension ${this.uuid}`);
            this.hotEdge?.dispose();
            this.hotEdge = null;
            Main.layoutManager.disconnect(this.hotCornersSub);
            this.hotCornersSub = null;
            this.panelManager?.dispose();
            this.panelManager = null;
            disposeDelayTimeouts();
            Main.layoutManager._updateHotCorners();
        }
    }
    function extension (meta) {
        return new Extension(meta.uuid);
    }

    return extension;

})(imports.gi.Clutter, imports.gi.GObject, imports.gi.GLib);
